<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

//Route::get('/', function () {
//    return view('welcome');
//});
Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');

Route::group(['as'=>'api.front.','prefix'=>'api/front'],function(){
    Route::resource('posts','PostsController',['only'=>['index','show'],'names'=>[
        'index' =>'posts.index',
        'show' =>'posts.show',
    ]]);
});

Route::any('/{all?}','HomeController@home')->where(['all'=>'.*']);
