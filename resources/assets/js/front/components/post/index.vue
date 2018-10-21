<template>
    <div class="page">
        <h1>文章列表页</h1>
        <div class="link">
            <router-link :to="{name: 'home'}" class="btn btn-success  btn-xs">首页</router-link>
        </div>
        <div class="col-md-4 col-md-offset-4">
            <div class="lists" v-for="post in posts">
                <h3>文章标题：<router-link :to="{name: 'post.show',params: { id: post.id }}" class="btn btn-success  btn-xs">{{post.title}}</router-link></h3>
                <p>文章内容：{{post.body}}</p>
                <div class="comments">
                    <div class="comment" v-for="comment in post.comments ">
                        <h4>用户：{{comment.user.name}}发表了评论：{{comment.body}}</h4>
                        <div class="seconds">
                            <div class="second"  v-for="second in comment.seconds ">
                                <h5>用户: {{second.user.name}}回复了用户：{{second.parent.user.name}}：{{second.body}}</h5>
                            </div>
                        </div>
                        <hr>
                    </div>
                </div>
                <hr>
            </div>
        </div>

    </div>
</template>

<script>
    export default {
        name: "index",
        data(){
            return {
                message: 'hello post index',
                posts:[]
            }
        },
        created(){
            axios.get(Laravel.router('api.front.posts.index')).then(res=>{
                console.log(res)
                this.posts = res.data.posts
            }).catch(error=>{

            })
        }
    }
</script>

<style scoped>
    .page{
        margin-top: 10px;
    }
    .link{
        text-align: center;
    }
    .comment{
        margin-left: 20px;
    }
    .second{
        margin-left: 20px;
    }
</style>