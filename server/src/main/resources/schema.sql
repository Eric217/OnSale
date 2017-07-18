DROP DATABASE IF EXISTS discount;

CREATE DATABASE discount default character set UTF8;

USE discount;

DROP TABLE IF EXISTS user;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT 1,
  `gender` varchar(5) DEFAULT '男',
  `email` varchar(50),
  `realname` varchar(20),
  `real_id` char(18),
  `phone` varchar(11),
  `nickName` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `nickName` (`nickName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS role;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS privilege;
CREATE TABLE `privilege` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS role_privilege;
CREATE TABLE `role_privilege` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `privilege_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id` (`role_id`,`privilege_id`),
  KEY `role_privilege_ibfk_2` (`privilege_id`),
  CONSTRAINT `role_privilege_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`),
  CONSTRAINT `role_privilege_ibfk_2` FOREIGN KEY (`privilege_id`) REFERENCES `privilege` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS goods;
CREATE TABLE `goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text,
  `loc0` varchar(255) DEFAULT NULL,
  `loc1` varchar(255) DEFAULT NULL,
  `loc2` varchar(255) DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `date` datetime NOT NULL,
  `deadline` datetime NOT NULL,
  `is_valid` tinyint(4) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `pic` text,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS comment;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `content` varchar(255) DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `goods_id` (`goods_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`goods_id`) REFERENCES `goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


INSERT PRIVILEGE(`name`) VALUES("READ");
INSERT PRIVILEGE(`name`) VALUES("UPLOAD");
INSERT PRIVILEGE(`name`) VALUES("DELETE");

INSERT Role(`name`) VALUES("ANONYMOUSE");
INSERT Role(`name`) VALUES("NORMAL");

INSERT role_privilege(`role_id`, `privilege_id`) VALUES(1, 1);
INSERT role_privilege(`role_id`, `privilege_id`) VALUES(2, 1);
INSERT role_privilege(`role_id`, `privilege_id`) VALUES(2, 2);
INSERT role_privilege(`role_id`, `privilege_id`) VALUES(2, 3);

INSERT user(`nickName`, `phone`, `password`, `role_id`) VALUES("omsfuk", "110", "admin", 2);

INSERT goods(type, loc0, loc1, loc2, date, deadline, user_id) values(1, '山东', '济南', 'ALL', current_timestamp(), current_timestamp(), 1);

INSERT goods(type, loc0, loc1, loc2, date, deadline, user_id) values(1, '山东', '青岛', 'ALL', current_timestamp(), current_timestamp(), 1);

INSERT goods(type, loc0, loc1, loc2, date, deadline, user_id) values(1, '山东', '潍坊', 'ALL', current_timestamp(), current_timestamp(), 1);
 


INSERT comment(content, goods_id, user_id, date) values("aaa", 1, 1, current_timestamp());

INSERT comment(content, goods_id, user_id, date) values("bbb", 1, 1, current_timestamp());

INSERT comment(content, goods_id, user_id, date) values("ccc", 1, 1, current_timestamp());

INSERT comment(content, goods_id, user_id, date) values("ddd", 1, 1, current_timestamp());

