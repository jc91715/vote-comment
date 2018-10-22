<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Post;

class PostsController extends Controller
{
    public function index()
    {
        //评论
//        $posts = Post::with(['comments'=>function ($query){
//            $query->where('parent_id',null)->with(['user','seconds'=>function($query){
//                $query->with('user','parent.user');
//            }]);
//        }])->get();
        //点赞+评论
//        $posts = Post::with(['comments'=>function ($query){
//            $query->where('parent_id',null)->with(['votes'=>function($query){
//                $query->with('user');
//            },'user','seconds'=>function($query){
//                $query->with(['user','parent.user','votes'=>function($query){
//                    $query->with('user');
//                }]);
//            }]);
//        },'votes'=>function($query){
//            $query->with('user');
//        }])->get();
//        $posts = Post::with('comments','comments.user')->get();
        $posts = Post::with('comments','comments.user','votes.user','comments.votes.user')->get();
        $posts = collect($posts->toArray())->map(function ($post){
            $nestedKeys = [];
            $post['comments'] = array_column($post['comments'], null, 'id');
            foreach ($post['comments'] as $key=>$comment){
                if(!$parent_id=$comment['parent_id']){
                    continue;
                }
                if (array_key_exists($first_depth_id=$comment['first_depth_id'], $post['comments'])) {
                    if(!isset($post['comments'][$first_depth_id]['seconds'])){
                        $post['comments'][$first_depth_id]['seconds'] = [];
                    }
                    $comment['parent']=$post['comments'][$parent_id];
                    $post['comments'][$first_depth_id]['seconds'][] = $comment;
                    $nestedKeys[]=$key;
                }else{
                    $nestedKeys[]=$key;
                }
            }
            foreach ($nestedKeys as $val){
                unset($post['comments'][$val]);
            }
            return $post;
        });
        return json_encode(['posts'=>$posts]);
    }

    public function show(Request $request,Post $post)
    {
//        $post->load(['comments'=>function($query){
//            $query->where('parent_id',null)->with(['user','seconds'=>function($query){
//                $query->with('user','parent.user');
//            }]);
//        }]);
        $post = $post->load('comments','comments.user')->toArray();
        $nestedKeys = [];
        $post['comments'] = array_column($post['comments'], null, 'id');
        foreach ($post['comments'] as $key=>$comment){
            if(!$parent_id=$comment['parent_id']){
                continue;
            }
            if (array_key_exists($first_depth_id=$comment['first_depth_id'], $post['comments'])) {
                if(!isset($post['comments'][$first_depth_id]['seconds'])){
                    $post['comments'][$first_depth_id]['seconds'] = [];
                }
                $comment['parent']=$post['comments'][$parent_id];
                $post['comments'][$first_depth_id]['seconds'][] = $comment;
                $nestedKeys[]=$key;
            }else{
                $nestedKeys[]=$key;
            }
        }
        foreach ($nestedKeys as $val){
            unset($post['comments'][$val]);
        }
        return json_encode($post);
    }
}
