require('metismenu');
require('bootstrap-datepicker');
require('../../../../node_modules/bootstrap-datepicker/dist/locales/bootstrap-datepicker.zh-CN.min');
require('bootstrap-datetime-picker');
require('../../../../node_modules/bootstrap-datetime-picker/js/locales/bootstrap-datetimepicker.zh-CN');

$.fn.datepicker.defaults.language = 'zh-CN';
$.fn.datepicker.dates['zh-CN'].format = 'yyyy-mm-dd';
$.fn.datepicker.defaults.autoclose = true;
$.fn.datetimepicker.defaults.language = 'zh-CN';
$.fn.datetimepicker.dates['zh-CN'].format = 'yyyy-mm-dd hh:ii';
$.fn.datetimepicker.defaults.autoclose = true;
import  router from './router/router';





const app = new Vue({
    el: '#app',
    router
});
$(function () {
    $('#menu').metisMenu();
})