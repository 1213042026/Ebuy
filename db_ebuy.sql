/*
Navicat MySQL Data Transfer

Source Server         : rrrr
Source Server Version : 50045
Source Host           : localhost:3306
Source Database       : db_ebuy

Target Server Type    : MYSQL
Target Server Version : 50045
File Encoding         : 65001

Date: 2017-05-20 20:24:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_bigtype
-- ----------------------------
DROP TABLE IF EXISTS `t_bigtype`;
CREATE TABLE `t_bigtype` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `remarks` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_bigtype
-- ----------------------------
INSERT INTO `t_bigtype` VALUES ('1', '赠礼佳品', '赠礼佳品');
INSERT INTO `t_bigtype` VALUES ('2', '美食天地', '美食天地');

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment` (
  `id` int(11) NOT NULL auto_increment,
  `content` varchar(1000) default NULL,
  `createTime` datetime default NULL,
  `nickName` varchar(30) default NULL,
  `replyContent` varchar(100) default NULL,
  `replyTime` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES ('1', '网站东西很好，我很喜欢', '2017-05-17 17:10:09', '大大卷', null, null);
INSERT INTO `t_comment` VALUES ('2', '网站东西很好，我很喜欢', '2017-05-17 17:10:12', '大大卷', null, null);

-- ----------------------------
-- Table structure for t_news
-- ----------------------------
DROP TABLE IF EXISTS `t_news`;
CREATE TABLE `t_news` (
  `id` int(11) NOT NULL auto_increment,
  `content` text,
  `createTime` datetime default NULL,
  `title` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_news
-- ----------------------------
INSERT INTO `t_news` VALUES ('1', '<p>好消息，好消息，本网站多种商品均有特价销售，预购从速</p>\r\n', '2017-05-17 17:00:57', '好消息');
INSERT INTO `t_news` VALUES ('2', '<p>本网站已进典藏茅台酒，数量有限，预购从速</p>\r\n', '2017-05-17 17:01:43', '茅台酒来了');

-- ----------------------------
-- Table structure for t_notice
-- ----------------------------
DROP TABLE IF EXISTS `t_notice`;
CREATE TABLE `t_notice` (
  `id` int(11) NOT NULL auto_increment,
  `content` text,
  `createTime` datetime default NULL,
  `title` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_notice
-- ----------------------------
INSERT INTO `t_notice` VALUES ('1', '<p>近期网站将增进一批名优小吃，由真空包装方式邮递，内附说明书</p>\r\n', '2017-05-17 16:58:46', '新货已到');
INSERT INTO `t_notice` VALUES ('2', '<p>欢迎来到贵州特产销售网，此网站将竭诚为您服务，如果您有好的意见请留言</p>\r\n', '2017-05-17 17:00:15', '贵州特产销售网简介');

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order` (
  `id` int(11) NOT NULL auto_increment,
  `cost` float NOT NULL,
  `createTime` datetime default NULL,
  `orderNo` varchar(255) default NULL,
  `status` int(11) NOT NULL,
  `userId` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_kh19wisaki6acmrs36vcmboj3` (`userId`),
  CONSTRAINT `FK_kh19wisaki6acmrs36vcmboj3` FOREIGN KEY (`userId`) REFERENCES `t_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES ('1', '1108', '2017-05-18 10:29:19', '20170518102919', '1', '22');

-- ----------------------------
-- Table structure for t_order_product
-- ----------------------------
DROP TABLE IF EXISTS `t_order_product`;
CREATE TABLE `t_order_product` (
  `id` int(11) NOT NULL auto_increment,
  `num` int(11) NOT NULL,
  `orderId` int(11) default NULL,
  `productId` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_8k7n3hmcgwvrs3ljx47u8l5w6` (`orderId`),
  KEY `FK_1orhyavyw8w5a8cj5tmtqfpd2` (`productId`),
  CONSTRAINT `FK_1orhyavyw8w5a8cj5tmtqfpd2` FOREIGN KEY (`productId`) REFERENCES `t_product` (`id`),
  CONSTRAINT `FK_8k7n3hmcgwvrs3ljx47u8l5w6` FOREIGN KEY (`orderId`) REFERENCES `t_order` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_order_product
-- ----------------------------
INSERT INTO `t_order_product` VALUES ('22', '1', null, null);
INSERT INTO `t_order_product` VALUES ('23', '2', null, null);
INSERT INTO `t_order_product` VALUES ('24', '1', null, null);
INSERT INTO `t_order_product` VALUES ('25', '1', null, null);
INSERT INTO `t_order_product` VALUES ('26', '1', null, null);
INSERT INTO `t_order_product` VALUES ('27', '1', null, null);
INSERT INTO `t_order_product` VALUES ('28', '1', null, null);
INSERT INTO `t_order_product` VALUES ('29', '1', null, null);
INSERT INTO `t_order_product` VALUES ('30', '1', null, null);
INSERT INTO `t_order_product` VALUES ('31', '1', null, null);
INSERT INTO `t_order_product` VALUES ('32', '1', null, null);
INSERT INTO `t_order_product` VALUES ('33', '1', null, null);
INSERT INTO `t_order_product` VALUES ('34', '1', null, null);
INSERT INTO `t_order_product` VALUES ('35', '1', null, null);
INSERT INTO `t_order_product` VALUES ('36', '1', null, null);
INSERT INTO `t_order_product` VALUES ('37', '1', null, null);
INSERT INTO `t_order_product` VALUES ('38', '1', null, null);
INSERT INTO `t_order_product` VALUES ('39', '1', null, null);
INSERT INTO `t_order_product` VALUES ('40', '1', null, null);
INSERT INTO `t_order_product` VALUES ('41', '1', null, null);
INSERT INTO `t_order_product` VALUES ('42', '1', null, null);
INSERT INTO `t_order_product` VALUES ('43', '1', null, null);
INSERT INTO `t_order_product` VALUES ('44', '1', null, null);
INSERT INTO `t_order_product` VALUES ('45', '1', null, null);
INSERT INTO `t_order_product` VALUES ('46', '1', null, null);
INSERT INTO `t_order_product` VALUES ('47', '10', '1', '15');
INSERT INTO `t_order_product` VALUES ('48', '6', '1', '1');

-- ----------------------------
-- Table structure for t_product
-- ----------------------------
DROP TABLE IF EXISTS `t_product`;
CREATE TABLE `t_product` (
  `id` int(11) NOT NULL auto_increment,
  `description` varchar(2000) default NULL,
  `hot` int(11) NOT NULL,
  `hotTime` datetime default NULL,
  `name` varchar(50) default NULL,
  `price` int(11) NOT NULL,
  `proPic` varchar(255) default NULL,
  `specialPrice` int(11) NOT NULL,
  `specialPriceTime` datetime default NULL,
  `stock` int(11) NOT NULL,
  `bigTypeId` int(11) default NULL,
  `smallTypeId` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_2vciohqujaeij91ujm5va2xs4` (`bigTypeId`),
  KEY `FK_qexns4el8esjqbdrqfys82ih8` (`smallTypeId`),
  CONSTRAINT `FK_2vciohqujaeij91ujm5va2xs4` FOREIGN KEY (`bigTypeId`) REFERENCES `t_bigtype` (`id`),
  CONSTRAINT `FK_qexns4el8esjqbdrqfys82ih8` FOREIGN KEY (`smallTypeId`) REFERENCES `t_smalltype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_product
-- ----------------------------
INSERT INTO `t_product` VALUES ('1', '正宗土蜂糖', '0', null, '正宗土蜂糖', '168', 'images/product/20170517041637.jpg', '0', null, '5000', '1', '34');
INSERT INTO `t_product` VALUES ('2', '软糯，香甜', '0', null, '竹叶黄粑', '88', 'images/product/20170517041721.jpg', '0', null, '5000', '2', '34');
INSERT INTO `t_product` VALUES ('3', '', '0', null, '老干妈', '8', 'images/product/20170517041538.jpg', '0', null, '5000', '2', '34');
INSERT INTO `t_product` VALUES ('4', '贵州名贵中药材', '0', null, '野生林芝', '130', 'images/product/20170517041810.jpg', '0', null, '5000', '2', '34');
INSERT INTO `t_product` VALUES ('5', '贵州名优特产', '0', null, '黑糯米粑', '88', 'images/product/20170517041855.jpg', '1', '2017-05-17 16:53:19', '5000', '2', '34');
INSERT INTO `t_product` VALUES ('6', '开袋即食', '0', null, '香酥辣椒', '30', 'images/product/20170517041952.jpg', '0', null, '5000', '2', '34');
INSERT INTO `t_product` VALUES ('7', '', '0', null, '习酒15年', '1288', 'images/product/20170517044626.jpg', '0', null, '2000', '1', '32');
INSERT INTO `t_product` VALUES ('8', '', '0', null, '银质习酒', '120', 'images/product/20170517044708.jpg', '0', null, '2000', '1', '32');
INSERT INTO `t_product` VALUES ('9', '', '0', null, '习酒天辰', '888', 'images/product/20170517044747.jpg', '0', null, '2000', '1', '32');
INSERT INTO `t_product` VALUES ('10', '', '0', null, '贵州茅台酒', '1200', 'images/product/20170517044821.jpg', '0', null, '2000', '1', '32');
INSERT INTO `t_product` VALUES ('11', '', '0', null, '飞天茅台典藏', '19000', 'images/product/20170517044858.jpg', '0', null, '2000', '1', '32');
INSERT INTO `t_product` VALUES ('12', '', '0', null, '茅台15年', '19999', 'images/product/20170517044932.jpg', '0', null, '2000', '1', '32');
INSERT INTO `t_product` VALUES ('13', '', '0', null, '竹荪', '60', 'images/product/20170517045020.jpg', '0', null, '5000', '2', '34');
INSERT INTO `t_product` VALUES ('14', '', '0', null, '野生天麻', '128', 'images/product/20170517045101.jpg', '0', null, '2000', '2', '34');
INSERT INTO `t_product` VALUES ('15', '', '0', null, '丝娃娃', '10', 'images/product/20170517045131.jpg', '1', '2017-05-17 16:53:30', '5000', '2', '33');
INSERT INTO `t_product` VALUES ('16', '', '0', null, '五彩糯米饭', '10', 'images/product/20170517045201.jpg', '1', '2017-05-17 16:53:30', '5000', '2', '33');
INSERT INTO `t_product` VALUES ('17', '', '1', '2017-05-17 16:54:13', '冲冲糕', '15', 'images/product/20170517045232.jpg', '0', null, '5000', '2', '33');
INSERT INTO `t_product` VALUES ('18', '', '0', null, '羊肉粉', '18', 'images/product/20170517045301.jpg', '0', null, '5000', '2', '33');
INSERT INTO `t_product` VALUES ('19', '', '1', '2017-05-17 16:54:13', '刷把头', '20', 'images/product/20170517045404.jpg', '0', null, '5000', '2', '33');
INSERT INTO `t_product` VALUES ('20', '', '0', null, '湄潭翠芽', '688', 'images/product/20170517045441.jpg', '0', null, '5000', '1', '31');
INSERT INTO `t_product` VALUES ('21', '', '0', null, '都匀毛尖', '288', 'images/product/20170517045516.jpg', '0', null, '2000', '1', '31');
INSERT INTO `t_product` VALUES ('22', '', '0', null, '湄潭翠芽典藏', '1000', 'images/product/20170517045552.jpg', '0', null, '2000', '1', '31');
INSERT INTO `t_product` VALUES ('23', '', '0', null, '肠旺面', '18', 'images/product/20170517045656.jpg', '0', null, '5000', '2', '33');
INSERT INTO `t_product` VALUES ('24', '', '1', '2017-05-18 10:53:55', '去', '12', 'images/product/20150922062127.jp', '1', '2017-05-18 10:54:01', '2222', '1', '31');
INSERT INTO `t_product` VALUES ('25', 'i', '0', null, 'u', '7', 'images/product/20170520075434.jpg', '0', null, '8', '1', '31');
INSERT INTO `t_product` VALUES ('26', 'testfor', '0', null, 'test', '1', 'images/product/20170520080933.jpg', '0', null, '12', '2', '33');

-- ----------------------------
-- Table structure for t_smalltype
-- ----------------------------
DROP TABLE IF EXISTS `t_smalltype`;
CREATE TABLE `t_smalltype` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `remarks` varchar(255) default NULL,
  `bigTypeId` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_a9rcrieyoywpcgb1luxsbir8s` (`bigTypeId`),
  CONSTRAINT `FK_a9rcrieyoywpcgb1luxsbir8s` FOREIGN KEY (`bigTypeId`) REFERENCES `t_bigtype` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_smalltype
-- ----------------------------
INSERT INTO `t_smalltype` VALUES ('31', '名茶', '贵州各地名茶', '1');
INSERT INTO `t_smalltype` VALUES ('32', '名酒', '贵州名酒', '1');
INSERT INTO `t_smalltype` VALUES ('33', '小吃', '各地名优小吃', '2');
INSERT INTO `t_smalltype` VALUES ('34', '特产', '各地名优特产', '2');

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `url` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_tag
-- ----------------------------

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` int(11) NOT NULL auto_increment,
  `address` varchar(200) default NULL,
  `birthday` datetime default NULL,
  `dentityCode` varchar(20) default NULL,
  `email` varchar(20) default NULL,
  `mobile` varchar(20) default NULL,
  `password` varchar(20) default NULL,
  `sex` varchar(5) default NULL,
  `status` int(11) NOT NULL,
  `trueName` varchar(20) default NULL,
  `userName` varchar(20) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('1', '山西太原尖草坪', '1976-09-04 00:00:00', '411522199407254576', 'admin@qq.com', '13523902576', 'admin', '女', '2', '张三', 'admin');
INSERT INTO `t_user` VALUES ('22', '大连民族大学', '1996-02-26 00:00:00', '522321199502251217', '444569104@qq.com', '18342039199', '950226', '男', '1', null, 'wzl950226');
