CREATE DATABASE IF NOT EXISTS 'iblog' DEFAULT CHARACTER SET utf8;

USE 'iblog';

DROP TABLE IF EXISTS 'admin';

CREATE TABLE 'admin' {
  `username` varchar(45) NOT NULL COMMENT '用户名',
  `password` varchar(45) NOT NULL COMMENT '密码',
  `password_salt` VARCHAR(45) NOT NULL COMMENT '加密密码',
  `email` varchar(64) NOT NULL DEFAULT '#',
  `github` varchar(64) NOT NULL DEFAULT '#',
  `resume_md` text COMMENT '简历的md格式文本',
  `resume_html` text COMMENT '简历的html格式文本',
  `avatar` varchar(80) NOT NULL DEFAULT '/img/avatar.jpg' COMMENT '头像',
  PRIMARY KEY (`username`)
} ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMNET='管理员表';

DROP TABLE IF EXISTS 'blog';

CREATE TABLE `blog` (
	`id` INT NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `publish_time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `category_id` INT NOT NULL COMMENT '分类id',
	`title` VARCHAR(128) NOT NULL COMMENT '文章标题',
	`blog_md` TEXT NOT NULL COMMENT 'blog的md格式文本',
  `blog_html` TEXT NOT NULL COMMENT 'blog的html格式文本',
	`read_times` INT(11) NOT NULL COMMENT '阅读次数',
  `comment_times` INT(11) NOT NULL COMMENT '评论次数',
	`thumbup_times` INT(11) NOT NULL COMMENT '点赞次数',
	`status` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '状态:0,草稿 1,发布 2,删除',
	PRIMARY KEY (`id`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户blog表';

DROP TABLE IF EXISTS 'blog_category';

CREATE TABLE 'blog_category' {
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  'category_name' VARCHAR(20) NOT NULL COMMENT 'blog类名',
  PRIMARY KEY (`id`)
}  ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='blog分类表';


DROP TABLE IF EXISTS 'web_visitor';

CREATE TABLE 'web_visitor' {
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `visitor_name` varchar(45) NOT NULL COMMENT '访客名',
  `password` varchar(45) NOT NULL COMMENT '密码',
  `password_salt` VARCHAR(45) NOT NULL COMMENT '加密密码',
  `avatar` varchar(80) NOT NULL DEFAULT '/img/visitor.jpg' COMMENT '头像',
  PRIMARY KEY (`id`)
} ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网络访客表';

DROP TABLE IF EXISTS 'friend_link';

CREATE TABLE 'friend_link' {
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `friend_name` varchar(45) NOT NULL COMMENT '朋友名',
  `url` varchar(64) NOT NULL DEFAULT '#' COMMENT '友情链接',
  PRIMARY KEY (`id`)
} ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='友情链接表';

DROP TABLE IF EXISTS 'blog_thumbup';

CREATE TABLE 'blog_thumbup' {
  `id` INT NOT NULL AUTO_INCREMENT COMMENT '主键',
  `create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  'blog_id' INT NOT NULL COMMENT 'blogID',
  'web_visitor_id' INT NOT NULL COMMENT '访客ID',
  PRIMARY KEY (`id`)
} ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='blog点赞表';

DROP TABLE IF EXISTS 'blog_comment';

CREATE TABLE `blog_comment` (
	`id` INT NOT NULL AUTO_INCREMENT COMMENT '主键',
	`create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	`web_visitor_id` INT NOT NULL COMMENT '访客id',
	`blog_id` INT NOT NULL COMMENT '文章ID',
	`comment` VARCHAR(2000) NOT NULL COMMENT '评论内容',
	`reply_comment_id` INT(11) NULL COMMENT '父级评论',
  `parents_comment_id` VARCHAR(128) NOT NULL DEFAULT '0,' COMMENT '父级评论路径',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='blog评论表';
