let mix = require('laravel-mix');
const webpack = require('webpack');
mix.webpackConfig({
    plugins: [
        new webpack.ContextReplacementPlugin(/moment[\/\\]locale$/, /zh\-cn/)
    ]
});
mix
    .js('resources/assets/js/common/bootstrap.js', 'js/bootstrap.js')
    .js('resources/assets/js/front/app.js', 'js/front.js')
    .autoload({
        jquery: ['$', 'window.jQuery', 'jQuery']
    })
    .sass('resources/assets/sass/app.scss', 'css/')
    .sass('resources/assets/sass/front.scss', 'css/')
    .extract(['vue', 'vue-router', 'axios','jquery']) // 提取依赖库
    .version()
    .setResourceRoot('/build/') // 设置资源目录
    .setPublicPath('./public/build') // 设置 mix-manifest.json 目录
