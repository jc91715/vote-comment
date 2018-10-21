/*
Navicat MySQL Data Transfer

Source Server         : home
Source Server Version : 50719
Source Host           : 192.168.10.10:3306
Source Database       : blog

Target Server Type    : MYSQL
Target Server Version : 50719
File Encoding         : 65001

Date: 2018-10-21 18:31:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `body` text COLLATE utf8mb4_unicode_ci,
  `commentable_id` int(10) unsigned DEFAULT NULL COMMENT '文章ID',
  `commentable_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文章模型',
  `parent_id` int(10) unsigned DEFAULT NULL COMMENT '被评论者模型id 一级评论为空',
  `user_id` int(10) unsigned DEFAULT NULL,
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '该评论被评论的数量',
  `first_depth_id` int(10) DEFAULT NULL,
  `vote_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '该条评论的赞数量',
  `is_directory` tinyint(1) NOT NULL DEFAULT '1',
  `level` int(10) unsigned NOT NULL DEFAULT '0',
  `path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '-',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_user_id_foreign` (`user_id`),
  KEY `comments_parent_id_index` (`parent_id`),
  CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES ('1', 'comment1', '1', 'App\\Post', null, '1', '0', null, '0', '1', '0', '-', null, null);
INSERT INTO `comments` VALUES ('2', 'comment2', '1', 'App\\Post', null, '2', '0', null, '0', '1', '0', '-', null, null);
INSERT INTO `comments` VALUES ('3', 'comment3', '1', 'App\\Post', null, '3', '0', null, '0', '1', '0', '-', null, null);
INSERT INTO `comments` VALUES ('4', 'comment4', '1', 'App\\Post', '1', '4', '0', '1', '0', '1', '0', '-1-', null, null);
INSERT INTO `comments` VALUES ('5', 'comment5', '1', 'App\\Post', '2', '5', '0', '2', '0', '1', '0', '-2-', null, null);
INSERT INTO `comments` VALUES ('6', 'comment6', '1', 'App\\Post', '3', '6', '0', '3', '0', '1', '0', '-3-', null, null);
INSERT INTO `comments` VALUES ('7', 'comment7', '1', 'App\\Post', '4', '7', '0', '1', '0', '1', '0', '-1-4-', null, null);
INSERT INTO `comments` VALUES ('8', 'commnet8', '1', 'App\\Post', '5', '8', '0', '2', '0', '1', '0', '-2-5-', null, null);
INSERT INTO `comments` VALUES ('9', 'comment9', '1', 'App\\Post', '6', '9', '0', '3', '0', '1', '0', '-3-6-', null, null);

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES ('6', '2014_10_12_000000_create_users_table', '1');
INSERT INTO `migrations` VALUES ('7', '2014_10_12_100000_create_password_resets_table', '1');
INSERT INTO `migrations` VALUES ('8', '2018_10_20_013500_create_posts_table', '1');
INSERT INTO `migrations` VALUES ('9', '2018_10_20_013554_create_comments_table', '1');
INSERT INTO `migrations` VALUES ('10', '2018_10_20_013813_create_votes_table', '1');

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for posts
-- ----------------------------
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci,
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '该文章被评论的数量',
  `vote_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '该文章的赞数量',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of posts
-- ----------------------------
INSERT INTO `posts` VALUES ('1', 'post1', 'fsdf', '0', '0', null, null);
INSERT INTO `posts` VALUES ('2', 'post2', 'fsdf', '0', '0', null, null);
INSERT INTO `posts` VALUES ('3', 'post3', 'fsdf', '0', '0', null, null);
INSERT INTO `posts` VALUES ('4', 'post4', 'fsdf', '0', '0', null, null);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'fas1', 'fsf', 'fs', 'fsd', null, null);
INSERT INTO `users` VALUES ('2', 'fas2', 'sfsd', 'fasd', null, null, null);
INSERT INTO `users` VALUES ('3', 'fas3', 'ffdssf', 'fs', 'fsd', null, null);
INSERT INTO `users` VALUES ('4', 'fas4', 'ffdfsssf', 'fs', 'fsd', null, null);
INSERT INTO `users` VALUES ('5', 'fas5', 'fffdsdfsssf', 'fs', 'fsd', null, null);
INSERT INTO `users` VALUES ('6', 'fas6', 'tfhfg', 'hfg', null, null, null);
INSERT INTO `users` VALUES ('7', 'hhgf7', 'hf', 'hfh', null, null, null);
INSERT INTO `users` VALUES ('8', 'hfg8', 'hfgdf', 'hfg', null, null, null);
INSERT INTO `users` VALUES ('9', 'fds9', 'gfd', 'gfd', null, null, null);
INSERT INTO `users` VALUES ('12', 'BsR0mhpa5c', 'jkXkSF8XB6@gmail.com', '$2y$10$yQyX/.5yPQpXW9NRDDxQX.Kz4.a4aTO/qM0W3kaLi/Qsgh9Oed7/m', null, null, null);
INSERT INTO `users` VALUES ('13', 'ikepKhV4Y6', 'gxcK3n0dlK@gmail.com', '$2y$10$GipUAP4VtGHSPisFAImANu8/aEX4TYiPLICpITibmfgHLsGtJDjTO', null, null, null);

-- ----------------------------
-- Table structure for votes
-- ----------------------------
DROP TABLE IF EXISTS `votes`;
CREATE TABLE `votes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned DEFAULT NULL,
  `voteable_id` int(10) unsigned DEFAULT NULL COMMENT '文章或者评论ID',
  `voteable_type` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '文章或评论模型',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `votes_user_id_foreign` (`user_id`),
  CONSTRAINT `votes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of votes
-- ----------------------------
INSERT INTO `votes` VALUES ('1', '1', '1', 'App\\Post', null, null);
INSERT INTO `votes` VALUES ('2', '2', '1', 'App\\Post', null, null);
INSERT INTO `votes` VALUES ('3', '3', '1', 'App\\Post', null, null);
INSERT INTO `votes` VALUES ('4', '4', '1', 'App\\Comment', null, null);
INSERT INTO `votes` VALUES ('5', '5', '1', 'App\\Comment', null, null);
