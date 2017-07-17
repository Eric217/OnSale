DROP DATABASE IF EXISTS discount;

CREATE DATABASE discount default character set UTF8;

USE discount;

DROP TABLE IF EXISTS user;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(50),
  `phone` varchar(11),
  `nickname` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `roleId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `nickname` (`nickname`)
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8



INSERT PRIVILEGE(`name`) VALUES("READ");
INSERT PRIVILEGE(`name`) VALUES("UPLOAD");
INSERT PRIVILEGE(`name`) VALUES("DELETE");

INSERT Role(`name`) VALUES("ANONYMOUSE");
INSERT Role(`name`) VALUES("NORMAL");

INSERT role_privilege(`role_id`, `privilege_id`) VALUES(1, 1);
INSERT role_privilege(`role_id`, `privilege_id`) VALUES(2, 1);
INSERT role_privilege(`role_id`, `privilege_id`) VALUES(2, 2);
INSERT role_privilege(`role_id`, `privilege_id`) VALUES(2, 3);

INSERT user(`nickname`, `phone`, `password`, `roleId`) VALUES("omsfuk", "110", "admin", 2);
