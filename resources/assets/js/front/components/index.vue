<template>
    <div class="home">
        <router-link :to="{name: 'post.index'}" class="btn btn-success btn-xs">去文章列表页</router-link>
        <router-view></router-view>
    </div>
</template>

<script>
    export default {
        name: "index",
        data(){
            return {
                message : 'hello home index'
            }
        }
    }
</script>

<style scoped>
    .home{
        margin-top: 10px;
    }
</style>