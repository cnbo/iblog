CREATE DATABASE IF NOT EXISTS iblog DEFAULT CHARACTER SET utf8;

USE iblog;

DROP TABLE IF EXISTS admin;

CREATE TABLE admin (
  username      VARCHAR(45)
  COMMENT '用户名',
  password      VARCHAR(45)
  COMMENT '密码',
  introduction  VARCHAR(200) DEFAULT ''
  COMMENT '用户简介',
  email         VARCHAR(64)  DEFAULT '#',
  github        VARCHAR(64)  DEFAULT '#',
  resume_md     TEXT COMMENT '简历的md格式文本',
  nickname      VARCHAR(45)  COMMENT '昵称',
  avatar        VARCHAR(80)  DEFAULT '/img/avatar.jpg'
  COMMENT '头像',
  PRIMARY KEY (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='管理员表';

DROP TABLE IF EXISTS 'blog';

CREATE TABLE blog (
	id INT NOT NULL AUTO_INCREMENT COMMENT '主键',
	create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  publish_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  category_id INT COMMENT '分类id',
	title VARCHAR(128) COMMENT '文章标题',
	blog_md TEXT COMMENT 'blog的md格式文本',
	read_times INT(11) COMMENT '阅读次数',
  comment_times INT(11) COMMENT '评论次数',
	love_times INT(11) COMMENT '喜欢次数',
	status TINYINT(1) DEFAULT 0 COMMENT '状态:0,草稿 1,发布 2,删除',
	PRIMARY KEY (id)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户blog表';

DROP TABLE IF EXISTS blog_category;

CREATE TABLE blog_category (
  id            INT         AUTO_INCREMENT
  COMMENT '主键',
  create_time   TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  update_time   TIMESTAMP   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间',
  category_name VARCHAR(20) COMMENT 'blog类名',
  PRIMARY KEY (id)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='blog分类表';


DROP TABLE IF EXISTS web_visitor;

CREATE TABLE web_visitor (
  id            INT         AUTO_INCREMENT
  COMMENT '主键',
  create_time   TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  update_time   TIMESTAMP   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间',
  visitor_name  VARCHAR(45)
  COMMENT '访客名',
  password      VARCHAR(45)
  COMMENT '密码',
  password_salt VARCHAR(45)
  COMMENT '加密密码',
  avatar        VARCHAR(80) DEFAULT '/img/visitor.jpg'
  COMMENT '头像',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='网络访客表';

DROP TABLE IF EXISTS friend_link;

CREATE TABLE friend_link (
  id          INT         AUTO_INCREMENT
  COMMENT '主键',
  create_time TIMESTAMP   DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  update_time TIMESTAMP   DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间',
  friend_name VARCHAR(45)
  COMMENT '朋友名',
  url         VARCHAR(64) DEFAULT '#'
  COMMENT '友情链接',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='友情链接表';

DROP TABLE IF EXISTS blog_love;

CREATE TABLE blog_love (
  id             INT       AUTO_INCREMENT
  COMMENT '主键',
  create_time    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  COMMENT '创建时间',
  update_time    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  COMMENT '更新时间',
  blog_id        INT
  COMMENT 'blogID',
  web_visitor_id INT
  COMMENT '访客ID',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='blog喜欢表';

DROP TABLE IF EXISTS blog_comment;

CREATE TABLE blog_comment (
	id INT AUTO_INCREMENT COMMENT '主键',
	create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
	web_visitor_id INT COMMENT '访客id',
	blog_id INT COMMENT '文章ID',
	comment VARCHAR(2000) COMMENT '评论内容',
	reply_comment_id INT(11) COMMENT '父级评论',
  parents_comment_id VARCHAR(128) DEFAULT '0,' COMMENT '父级评论路径',
	PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='blog评论表';


--在表blog中新增一个blog_html字段
ALTER TABLE blog ADD blog_html TEXT;