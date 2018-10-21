<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCommentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('comments', function (Blueprint $table) {
            $table->increments('id');
            $table->text('body')->nullable();
            $table->unsignedInteger('commentable_id')->nullable()->comment('文章ID');
            $table->string('commentable_type')->nullable()->comment('文章模型');
            $table->unsignedInteger('parent_id')->nullable()->index()->comment('被评论者模型id 一级评论为空');
            $table->unsigned('user_id')->nullable();
            $table->unsignedInteger('comment_count')->default(0)->comment('该评论被评论的数量');
            $table->unsignedInteger('vote_count')->default(0)->comment('该条评论的赞数量');
            $table->unsignedInteger('first_depth_id')->nullable()->comment('记录一级评论id');

            $table->foreign('user_id')->references('id')->on('users')
                ->onDelete('cascade');

            $table->boolean('is_directory')->default(true);
            $table->unsignedInteger('level')->default(0);
            $table->string('path')->default('');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('comments');
    }
}
