<template>
    <div class="show">
        <h1>文章详情页</h1>
        <div class="col-md-4 col-md-offset-4">
            <h3>文章标题：<router-link :to="{name: 'post.show'}" class="btn btn-success  btn-xs">{{post.title}}</router-link></h3>
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
        </div>
    </div>
</template>

<script>
    export default {
        props:['id'],
        name: "show",
        data(){
            return {
                post:{}
            }
        },
        created(){
            axios.get(Laravel.router('api.front.posts.show',{post:this.id})).then(res=>{
                console.log(res)
                this.post = res.data
            }).catch(error=>{

            })
        }
    }
</script>

<style scoped>
    .comment{
        margin-left: 20px;
    }
    .second{
        margin-left: 20px;
    }
</style>