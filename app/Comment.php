<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{
    protected $fillable =array('*');


    public function commentable()
    {
        return $this->morphTo();
    }

    public function parent()
    {
        return $this->belongsTo(Comment::class,'parent_id');
    }

    public function children()
    {
        return $this->hasMany(Comment::class, 'parent_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }


    public function votes()
    {
        return $this->morphMany('App\Vote', 'voteable');
    }

    public function seconds()
    {
        return $this->hasMany(Comment::class,'first_depth_id');
    }

    public function getParentId()
    {
        return $this->parent_id;
    }


    public function test(){
        Post::with(['comments'=>function ($query){
            $query->where('parent_id',null);
        }])->get();

        //高效查询 点赞
        $posts = Post::with('comments','comments.user')->get();
        $posts = Post::with('comments','comments.user','votes.user','comments.votes.user')->get();
        $posts = collect($posts->toArray())->map(function ($post){
            $array =[];
            $nestedKeys = [];
            foreach ($post['comments'] as $comment){
                $array[$comment['id']] = $comment;
            }
            $post['comments'] = $array;
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

        //评论
        Post::with(['comments'=>function ($query){
            $query->where('parent_id',null)->with(['user','seconds'=>function($query){
                $query->with('user','parent.user');
            }]);
        }])->get();
        //点赞+评论
        $posts = Post::with(['comments'=>function ($query){
            $query->where('parent_id',null)->with(['votes'=>function($query){
                $query->with('user');
            },'user','seconds'=>function($query){
                $query->with(['user','parent.user','votes'=>function($query){
                    $query->with('user');
                }]);
            }]);
        },'votes'=>function($query){
            $query->with('user');
        }])->get();

        Post::with(['comments'=>function ($query){
            $query->where('path','like','-1-%')->with('user','parent.user');
        }])->get();

        Post::whereHas('comments')->with(['comments'=>function ($query){
            $query->where('parent_id',null)->limit(2);
        }])->with('comments.user')->get();

        Post::find(1)->load(['comments'=>function ($query){
            $query->where('parent_id',null)->with('seconds');
        }]);

        Post::find(1)->load(['comments'=>function($query){
            $query->where('parent_id',null)->with(['user','seconds'=>function($query){
                $query->with('user','parent.user');
            }]);
        }]);

        $post = Post::with('comments','comments.user')->find(1)->toArray();
        $array =[];
        $nestedKeys = [];
        foreach ($post['comments'] as $comment){
            $array[$comment['id']] = $comment;
        }
        $post['comments'] = $array;
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

        $post = Post::find(1)->load('comments');
    }

}
