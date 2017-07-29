/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50636
Source Host           : localhost:3306
Source Database       : dbwm

Target Server Type    : MYSQL
Target Server Version : 50636
File Encoding         : 65001

Date: 2017-07-29 22:53:13
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for company
-- ----------------------------
DROP TABLE IF EXISTS `company`;
CREATE TABLE `company` (
  `number` int(11) NOT NULL,
  `companyname` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`number`),
  UNIQUE KEY `companyname` (`companyname`) USING BTREE,
  CONSTRAINT `company_ibfk_1` FOREIGN KEY (`number`) REFERENCES `loging` (`number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of company
-- ----------------------------
INSERT INTO `company` VALUES ('9', 'test', 'dayuncun', '110');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `number` int(11) NOT NULL,
  `customername` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `deaddress` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`number`),
  UNIQUE KEY `customername` (`customername`) USING BTREE,
  CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`number`) REFERENCES `loging` (`number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES ('1', null, '10086', '1', null, 'dayuncun');
INSERT INTO `customer` VALUES ('11', null, '1302006301', null, null, '大运村');
INSERT INTO `customer` VALUES ('12', null, '100', null, null, '中国');
INSERT INTO `customer` VALUES ('13', null, '130200631', null, null, '中国大运村');
INSERT INTO `customer` VALUES ('14', null, '130200632', null, null, '中国北京大运村');
INSERT INTO `customer` VALUES ('15', null, '130200630', null, null, '大运村中国');

-- ----------------------------
-- Table structure for food
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food` (
  `number` int(11) NOT NULL,
  `foodnum` int(11) NOT NULL,
  `foodname` varchar(20) DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`foodnum`),
  UNIQUE KEY `foodname` (`foodname`) USING BTREE,
  KEY `number` (`number`) USING BTREE,
  CONSTRAINT `food_ibfk_1` FOREIGN KEY (`number`) REFERENCES `shop` (`number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of food
-- ----------------------------
INSERT INTO `food` VALUES ('1', '11', '巨无霸', '20', '12');
INSERT INTO `food` VALUES ('1', '12', '麦辣鸡腿汉堡大套餐', '33', '5');
INSERT INTO `food` VALUES ('1', '13', '蜜汁鸡腿满碗饭', '21', '2');
INSERT INTO `food` VALUES ('2', '21', '海鲜粥', '15', '1');
INSERT INTO `food` VALUES ('2', '22', '绿豆饼', '18', '1');
INSERT INTO `food` VALUES ('2', '23', '南瓜羹', '15', '1');
INSERT INTO `food` VALUES ('3', '31', '田园风光披萨9', '33', '1');
INSERT INTO `food` VALUES ('3', '32', '意大利肉酱面', '30', '1');
INSERT INTO `food` VALUES ('3', '33', '秘制鸡翅（6个）', '36', '1');
INSERT INTO `food` VALUES ('4', '34', '黄焖鸡米饭', '24', '1');
INSERT INTO `food` VALUES ('4', '35', '鱼香肉丝饭', '21', '1');
INSERT INTO `food` VALUES ('4', '41', '香菇滑鸡饭', '22', '1');
INSERT INTO `food` VALUES ('4', '42', '湘味小炒牛肉饭', '25', '1');
INSERT INTO `food` VALUES ('4', '43', '土豆烧牛肉饭', '24', '1');
INSERT INTO `food` VALUES ('5', '51', '红烧牛肉面', '20', '1');
INSERT INTO `food` VALUES ('5', '52', '油泼面', '19', '1');
INSERT INTO `food` VALUES ('5', '53', '羊肉泡馍', '28', '1');
INSERT INTO `food` VALUES ('6', '61', '招牌干锅牛蛙', '138', '1');
INSERT INTO `food` VALUES ('6', '62', '干锅鸭头', '118', '1');
INSERT INTO `food` VALUES ('6', '63', '干锅鸡中翅', '118', '1');
INSERT INTO `food` VALUES ('7', '71', '酱油炒饭', '12', '1');
INSERT INTO `food` VALUES ('7', '72', '酸菜鱼捞面', '58', '1');
INSERT INTO `food` VALUES ('7', '73', '混沌', '8', '1');
INSERT INTO `food` VALUES ('8', '81', '肉末四季豆套餐', '28', '1');
INSERT INTO `food` VALUES ('8', '82', '小炒扁豆丝套餐', '28', '1');
INSERT INTO `food` VALUES ('8', '83', '肉末茄子煲（盖饭）', '25', '1');
INSERT INTO `food` VALUES ('1', '84', '吃的东西', '12', '0');
INSERT INTO `food` VALUES ('1', '85', '12345', '12', '0');

-- ----------------------------
-- Table structure for loging
-- ----------------------------
DROP TABLE IF EXISTS `loging`;
CREATE TABLE `loging` (
  `number` int(11) NOT NULL,
  `zhanghao` varchar(20) NOT NULL,
  `mima` varchar(20) NOT NULL,
  `quanxian` int(11) DEFAULT NULL,
  PRIMARY KEY (`number`),
  UNIQUE KEY `zhanghao` (`zhanghao`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of loging
-- ----------------------------
INSERT INTO `loging` VALUES ('1', 'shop01', 'shop01', '3');
INSERT INTO `loging` VALUES ('2', 'shop02', 'shop02', '3');
INSERT INTO `loging` VALUES ('3', 'shop03', 'shop03', '3');
INSERT INTO `loging` VALUES ('4', 'shop04', 'shop04', '3');
INSERT INTO `loging` VALUES ('5', 'shop05', 'shop05', '3');
INSERT INTO `loging` VALUES ('6', 'shop06', 'shop06', '3');
INSERT INTO `loging` VALUES ('7', 'shop07', 'shop07', '3');
INSERT INTO `loging` VALUES ('8', 'shop08', 'shop08', '3');
INSERT INTO `loging` VALUES ('9', 'company09', 'company09', '4');
INSERT INTO `loging` VALUES ('10', 'worker10', 'worker10', '2');
INSERT INTO `loging` VALUES ('11', 'testuser', '111111', '1');
INSERT INTO `loging` VALUES ('12', 'signup01', 'signup', '1');
INSERT INTO `loging` VALUES ('13', 'test01', '123456', '1');
INSERT INTO `loging` VALUES ('14', 'test02', '123456', '1');
INSERT INTO `loging` VALUES ('15', '123456', '123456', '1');

-- ----------------------------
-- Table structure for orderfood
-- ----------------------------
DROP TABLE IF EXISTS `orderfood`;
CREATE TABLE `orderfood` (
  `ordernum` int(11) NOT NULL,
  `foodnum` int(11) NOT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`ordernum`,`foodnum`),
  KEY `foodnum` (`foodnum`) USING BTREE,
  CONSTRAINT `orderfood_ibfk_1` FOREIGN KEY (`ordernum`) REFERENCES `ordering` (`ordernum`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orderfood_ibfk_2` FOREIGN KEY (`foodnum`) REFERENCES `food` (`foodnum`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of orderfood
-- ----------------------------
INSERT INTO `orderfood` VALUES ('0', '11', '1');
INSERT INTO `orderfood` VALUES ('1', '11', '1');
INSERT INTO `orderfood` VALUES ('1', '12', '1');
INSERT INTO `orderfood` VALUES ('2', '11', '1');
INSERT INTO `orderfood` VALUES ('3', '11', '1');
INSERT INTO `orderfood` VALUES ('3', '13', '1');
INSERT INTO `orderfood` VALUES ('4', '11', '1');
INSERT INTO `orderfood` VALUES ('4', '12', '1');
INSERT INTO `orderfood` VALUES ('5', '11', '1');
INSERT INTO `orderfood` VALUES ('6', '11', '1');
INSERT INTO `orderfood` VALUES ('7', '11', '1');
INSERT INTO `orderfood` VALUES ('8', '12', '1');
INSERT INTO `orderfood` VALUES ('9', '11', '2');
INSERT INTO `orderfood` VALUES ('11', '11', '1');

-- ----------------------------
-- Table structure for ordering
-- ----------------------------
DROP TABLE IF EXISTS `ordering`;
CREATE TABLE `ordering` (
  `ordernum` int(11) NOT NULL,
  `number` int(11) DEFAULT NULL,
  `shopnum` int(11) DEFAULT NULL,
  `workernum` int(11) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  PRIMARY KEY (`ordernum`),
  KEY `number` (`number`) USING BTREE,
  KEY `shopnum` (`shopnum`) USING BTREE,
  KEY `workernum` (`workernum`) USING BTREE,
  CONSTRAINT `ordering_ibfk_1` FOREIGN KEY (`number`) REFERENCES `customer` (`number`),
  CONSTRAINT `ordering_ibfk_2` FOREIGN KEY (`shopnum`) REFERENCES `shop` (`number`),
  CONSTRAINT `ordering_ibfk_3` FOREIGN KEY (`workernum`) REFERENCES `worker` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ordering
-- ----------------------------
INSERT INTO `ordering` VALUES ('0', '11', '1', '10', '大运村', '20');
INSERT INTO `ordering` VALUES ('1', '11', '1', '10', '大运村', '53');
INSERT INTO `ordering` VALUES ('2', '12', '1', '10', '中国', '20');
INSERT INTO `ordering` VALUES ('3', '12', '1', '10', '中国', '41');
INSERT INTO `ordering` VALUES ('4', '11', '1', '10', '大运村', '53');
INSERT INTO `ordering` VALUES ('5', '11', '1', '10', '大运村', '20');
INSERT INTO `ordering` VALUES ('6', '11', '1', '10', '大运村', '20');
INSERT INTO `ordering` VALUES ('7', '11', '1', '10', '大运村', '20');
INSERT INTO `ordering` VALUES ('8', '11', '1', '10', '大运村', '33');
INSERT INTO `ordering` VALUES ('9', '11', '1', '10', '大运村', '40');
INSERT INTO `ordering` VALUES ('11', '11', '1', '10', '大运村', '20');

-- ----------------------------
-- Table structure for shop
-- ----------------------------
DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop` (
  `number` int(11) NOT NULL,
  `shopname` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`number`),
  UNIQUE KEY `shopname` (`shopname`) USING BTREE,
  CONSTRAINT `shop_ibfk_1` FOREIGN KEY (`number`) REFERENCES `loging` (`number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shop
-- ----------------------------
INSERT INTO `shop` VALUES ('1', '北京麦当劳花园路北路餐厅 ', '北京市海淀区学院路甲38号', '4000517117');
INSERT INTO `shop` VALUES ('2', '拼豆夜宵（中关村店）', '北京市海淀区苏州街', '4000655900');
INSERT INTO `shop` VALUES ('3', 'laker‘s披萨', '海淀区成府路240号', '010-62615515');
INSERT INTO `shop` VALUES ('4', '人民公社（五道口店）', '北京市海淀区展春园小区19号楼1号楼1层', '010-57462488');
INSERT INTO `shop` VALUES ('5', '陕味食族(双榆树店)', '北京市海淀区双榆树西里9号陕味食族（UME华星国际影城西侧）', '1062542370');
INSERT INTO `shop` VALUES ('6', '蛙蛙叫干锅年代', '东直门内大街288-6号（近北新桥地铁站C口）', '18701005177');
INSERT INTO `shop` VALUES ('7', '面香八方（双清路店）', '双清路88号华源世纪商务楼2楼（近清华东门）', '1082526858');
INSERT INTO `shop` VALUES ('8', '满座儿(银网店)', '知春路113号银网中心B座5层', '010-56102718');

-- ----------------------------
-- Table structure for shopcompany
-- ----------------------------
DROP TABLE IF EXISTS `shopcompany`;
CREATE TABLE `shopcompany` (
  `shopnum` int(11) NOT NULL,
  `companynum` int(11) NOT NULL,
  PRIMARY KEY (`shopnum`,`companynum`),
  KEY `companynum` (`companynum`) USING BTREE,
  CONSTRAINT `shopcompany_ibfk_1` FOREIGN KEY (`companynum`) REFERENCES `company` (`number`),
  CONSTRAINT `shopcompany_ibfk_2` FOREIGN KEY (`shopnum`) REFERENCES `shop` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of shopcompany
-- ----------------------------
INSERT INTO `shopcompany` VALUES ('1', '9');
INSERT INTO `shopcompany` VALUES ('2', '9');
INSERT INTO `shopcompany` VALUES ('3', '9');
INSERT INTO `shopcompany` VALUES ('4', '9');
INSERT INTO `shopcompany` VALUES ('5', '9');
INSERT INTO `shopcompany` VALUES ('6', '9');
INSERT INTO `shopcompany` VALUES ('7', '9');
INSERT INTO `shopcompany` VALUES ('8', '9');

-- ----------------------------
-- Table structure for worker
-- ----------------------------
DROP TABLE IF EXISTS `worker`;
CREATE TABLE `worker` (
  `number` int(11) NOT NULL,
  `companynum` int(11) DEFAULT NULL,
  `workername` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `sex` int(11) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  PRIMARY KEY (`number`),
  UNIQUE KEY `workername` (`workername`) USING BTREE,
  KEY `companynum` (`companynum`) USING BTREE,
  CONSTRAINT `worker_ibfk_1` FOREIGN KEY (`companynum`) REFERENCES `company` (`number`),
  CONSTRAINT `worker_ibfk_2` FOREIGN KEY (`number`) REFERENCES `loging` (`number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of worker
-- ----------------------------
INSERT INTO `worker` VALUES ('10', '9', 'worker10', '10010', '1', '20');

-- ----------------------------
-- Procedure structure for procai1
-- ----------------------------
DROP PROCEDURE IF EXISTS `procai1`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `procai1`(in foodnum1 int,in amount1 int,out returnValue	int)
begin
	declare sign int;
	declare maxx int;
	declare foodcount int;
	declare danjia int;
	declare yuanjia int;

select max(ordernum) into maxx from ordering;
select count into foodcount from food where foodnum=foodnum1;
select money into danjia from food where foodnum=foodnum1;
select foodnum1 into sign from orderfood where ordernum=maxx and foodnum1=foodnum;
select money into yuanjia from ordering where ordernum=maxx;

if danjia is null THEN
	set danjia=0;
end if;

if foodcount is null THEN
	set foodcount=0;
end if;

if yuanjia is null THEN
	set yuanjia=0;
end if;

if sign is null then
insert into orderfood values(maxx,foodnum1,amount1);
update food set count=amount1+foodcount where foodnum=foodnum1;
update ordering set money=yuanjia+danjia*amount1 where ordernum=maxx;
set returnValue=1;
ELSE
set returnValue=2;
end if;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for prolog1
-- ----------------------------
DROP PROCEDURE IF EXISTS `prolog1`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `prolog1`(in zhanghao1 varchar(20),in mima1 varchar(20),in shouji1 varchar(20),in dizhi1 varchar(20),out returnValue	int)
begin
	declare sign varchar(50);
	declare maxx int;
select zhanghao into sign from loging where zhanghao=zhanghao1;
select max(number) into maxx from loging;
set maxx=maxx+1;
if sign is null THEN
insert into loging(number,zhanghao,mima,quanxian) values (maxx,zhanghao1,mima1,1);
insert into customer(number,phone,deaddress) values(maxx,shouji1,dizhi1);
set returnValue=1;
else
set returnValue=2;
end IF;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for proorder1
-- ----------------------------
DROP PROCEDURE IF EXISTS `proorder1`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `proorder1`(in customernum1 int,in shopnum1 int,in address1 varchar(100),out returnValue	int)
begin
	declare sign int;
	declare maxx int;
select number into sign from customer where number=customernum1;
select max(ordernum) into maxx from ordering;
set maxx=maxx+1;
if sign is null THEN
set returnValue=2;
else
insert into ordering(ordernum,number,shopnum,workernum,address,money) values (maxx,customernum1,shopnum1,null,address1,null);
set returnValue=1;
end IF;
end
;;
DELIMITER ;
DROP TRIGGER IF EXISTS `wmorder`;
DELIMITER ;;
CREATE TRIGGER `wmorder` BEFORE INSERT ON `ordering` FOR EACH ROW BEGIN
		declare comnum int;
		declare ordernum1 int;
		declare worknum int;
		select companynum into comnum from shopcompany where new.shopnum=shopnum  order by rand() limit 1;
		select number into worknum from worker where companynum=comnum  order by rand() limit 1;
		set new.workernum=worknum ;
END
;;
DELIMITER ;
SET FOREIGN_KEY_CHECKS=1;
