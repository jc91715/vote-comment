window.Vue = require('vue');
window._ = require('lodash');
window.Bus = new Vue();
window.bootbox=require('bootbox');
window.bootbox.setLocale('zh_CN');

window.$ = window.jQuery = require('jquery');

window.axios = require('axios');

window.axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': Laravel.csrfToken
};

Laravel.router = require('./backend-router-generator')(require('../front/route'));
