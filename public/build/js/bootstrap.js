webpackJsonp([2],{

/***/ "./resources/assets/js/common/backend-router-generator.js":
/***/ (function(module, exports) {

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; };

module.exports = function (routes) {
    return function (route, param) {
        var routeUrl = routes[route];
        var append = [];

        var _loop = function _loop(x) {
            var search = '{' + x + '}';

            if (routeUrl.indexOf(search) >= 0) {
                routeUrl = routeUrl.replace('{' + x + '}', param[x]);
            } else {
                if (_typeof(param[x]) != 'object') {
                    append.push(x + '=' + encodeURIComponent(param[x]));
                } else if (param[x] instanceof Array) {
                    param[x].forEach(function (item) {
                        append.push(x + '[]=' + encodeURIComponent(item));
                    });
                } else {
                    for (var key in param[x]) {
                        append.push(x + '[' + key + ']=' + encodeURIComponent(param[x][key]));
                    }
                }
            }
        };

        for (var x in param) {
            _loop(x);
        }

        var url = '/' + routeUrl;

        if (append.length == 0) {
            return url;
        }

        if (url.indexOf('?') >= 0) {
            url += '&';
        } else {
            url += '?';
        }

        url += append.join('&');

        return url;
    };
};

/***/ }),

/***/ "./resources/assets/js/common/bootstrap.js":
/***/ (function(module, exports, __webpack_require__) {

/* WEBPACK VAR INJECTION */(function(__webpack_provided_window_dot_jQuery) {window.Vue = __webpack_require__("./node_modules/vue/dist/vue.common.js");
window._ = __webpack_require__("./node_modules/lodash/lodash.js");
window.Bus = new Vue();
window.bootbox = __webpack_require__("./node_modules/bootbox/bootbox.js");
window.bootbox.setLocale('zh_CN');

window.$ = __webpack_provided_window_dot_jQuery = __webpack_require__("./node_modules/jquery/dist/jquery.js");

window.axios = __webpack_require__("./node_modules/axios/index.js");

window.axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': Laravel.csrfToken
};

Laravel.router = __webpack_require__("./resources/assets/js/common/backend-router-generator.js")(__webpack_require__("./resources/assets/js/front/route.js"));
/* WEBPACK VAR INJECTION */}.call(exports, __webpack_require__("./node_modules/jquery/dist/jquery.js")))

/***/ }),

/***/ "./resources/assets/js/front/route.js":
/***/ (function(module, exports) {

module.exports = {
    "login": "login",
    "logout": "logout",
    "register": "register",
    "password.request": "password\/reset",
    "password.email": "password\/email",
    "password.reset": "password\/reset\/{token}",
    "home": "home",
    "api.front.posts.index": "api\/front\/posts",
    "api.front.posts.show": "api\/front\/posts\/{post}"
};

/***/ }),

/***/ "./resources/assets/sass/app.scss":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ "./resources/assets/sass/front.scss":
/***/ (function(module, exports) {

// removed by extract-text-webpack-plugin

/***/ }),

/***/ 0:
/***/ (function(module, exports, __webpack_require__) {

__webpack_require__("./resources/assets/js/common/bootstrap.js");
__webpack_require__("./resources/assets/sass/app.scss");
module.exports = __webpack_require__("./resources/assets/sass/front.scss");


/***/ })

},[0]);