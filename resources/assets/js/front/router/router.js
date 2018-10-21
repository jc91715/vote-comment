
import VueRouter from 'vue-router';
Vue.use(VueRouter);

const routes=[
    {
        path: '/', component: require('../components/index.vue') ,name: 'home',
        children: [
            {
                path: 'posts',component: require('../components/home.vue'),
                children: [
                    { path: '',component: require('../components/post/index.vue') ,name: 'post.index' },
                    { path: ':id',component: require('../components/post/show') ,name: 'post.show',props: true },
                ]
            }
        ]
    },

];

const router = new VueRouter({
    mode: 'history',
    routes
})
export default router