/*
 Navicat Premium Data Transfer

 Source Server         : phptools
 Source Server Type    : MySQL
 Source Server Version : 50553
 Source Host           : localhost:3306
 Source Schema         : ysfk

 Target Server Type    : MySQL
 Target Server Version : 50553
 File Encoding         : 65001

 Date: 18/10/2018 23:21:37
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ys_acp
-- ----------------------------
DROP TABLE IF EXISTS `ys_acp`;
CREATE TABLE `ys_acp`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `email` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `userid` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userkey` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_ste` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否启用 1是 0否',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `code`(`code`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 43 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ys_acp
-- ----------------------------
INSERT INTO `ys_acp` VALUES (38, 'zfbf2f', '支付宝当面付', '', '', '', 0);
INSERT INTO `ys_acp` VALUES (40, 'alipay', '支付宝即时到账', '', '', '', 0);
INSERT INTO `ys_acp` VALUES (41, 'chenalipay', 'CHENPAY支付宝免签', '', '', '', 0);
INSERT INTO `ys_acp` VALUES (42, 'chenwxpay', 'CHENPAY微信免签', '', '', '', 0);
-- ----------------------------
-- Table structure for ys_admin
-- ----------------------------
DROP TABLE IF EXISTS `ys_admin`;
CREATE TABLE `ys_admin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `adminname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `adminpass` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `token` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_state` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `limits` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `limit_ip` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `is_limit_ip` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ys_admin
-- ----------------------------
INSERT INTO `ys_admin` VALUES (1, 'admin', 'd5a1bdf9ce989fd6161063e94b92bdeacb94ed23', '4718737b9f2f6e2c225fe605d6c7234330e7e7e4', 0, '{\"limit_ip\":\"\",\"is_limit_ip\":\"0\",\"set\":\"\\u7cfb\\u7edf\\u8bbe\\u7f6e\",\"mailtpl\":\"\\u90ae\\u4ef6\\u6a21\\u7248\",\"admins\":\"\\u7ba1\\u7406\\u5458\\u5217\\u8868\",\"pwd\":\"\\u4fee\\u6539\\u5bc6\\u7801\",\"logs\":\"\\u767b\\u5f55\\u65e5\\u5fd7\",\"cog\":\"\\u5bfc\\u822a\\u8bbe\\u7f6e\",\"orders\":\"\\u8ba2\\u5355\\u5217\\u8868\",\"gdclass\":\"\\u5546\\u54c1\\u5206\\u7c7b\",\"goods\":\"\\u5546\\u54c1\\u5217\\u8868\",\"kami\":\"\\u5361\\u5bc6\\u7ba1\\u7406\",\"acp\":\"\\u63a5\\u5165\\u4fe1\\u606f\"}', '', 0);

-- ----------------------------
-- Table structure for ys_adminlogs
-- ----------------------------
DROP TABLE IF EXISTS `ys_adminlogs`;
CREATE TABLE `ys_adminlogs`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `adminid` int(10) UNSIGNED NOT NULL,
  `addtime` int(10) UNSIGNED NOT NULL,
  `ip` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `adminid`(`adminid`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 46 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ys_config
-- ----------------------------
DROP TABLE IF EXISTS `ys_config`;
CREATE TABLE `ys_config`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sitename` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `siteurl` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `siteinfo` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `keyword` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `tel` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `qq` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `icpcode` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `stacode` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `smtp_server` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `smtp_email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `smtp_pwd` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `tips` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `ctime` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email_state` tinyint(1) NOT NULL DEFAULT 0,
  `ismail_kuc` tinyint(1) NOT NULL DEFAULT 0,
  `ismail_num` int(20) NULL DEFAULT 0,
  `serive_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ys_config
-- ----------------------------
INSERT INTO `ys_config` VALUES (1, '云尚发卡系统', 'phpke.cn', '云尚发卡系统 安全稳定', '云尚发卡系统 安全稳定', '云尚发卡系统 安全稳定', '53331323@qq.com', '400-000-0000', '53331323', '云尚创想科技', '沪ICP备13008591号', '', '', '', '', '<h2>\r\n	<ul class=\"tpl-task-list tpl-task-remind\" style=\"box-sizing:border-box;margin:0px;padding:0px;list-style:none;color:#333333;font-family:&quot;font-size:18px;white-space:normal;background-color:#FFFFFF;\">\r\n		<li style=\"box-sizing:border-box;margin:0px 0px 7px;padding:10px !important;list-style:none;position:relative;border-bottom:1px solid #F4F6F9;height:auto !important;font-size:14px !important;line-height:22px !important;color:#82949A;\">\r\n			<div class=\"cosA\" style=\"box-sizing:border-box;margin-right:80px;\">\r\n				<span class=\"cosIco\" style=\"box-sizing:border-box;display:inline-block;width:24px;height:24px;vertical-align:middle;color:#FFFFFF;text-align:center;border-radius:3px;background-color:#36C6D3;\"><span class=\"am-icon-bell-o\" style=\"box-sizing:border-box;display:inline-block;\"></span></span>&nbsp;<span style=\"box-sizing:border-box;\">注意：本站为云尚发卡系统演示站，商品数据只做测试使用！</span>\r\n			</div>\r\n		</li>\r\n		<li style=\"box-sizing:border-box;margin:0px 0px 7px;padding:10px !important;list-style:none;position:relative;border-bottom:1px solid #F4F6F9;height:auto !important;font-size:14px !important;line-height:22px !important;color:#82949A;\">\r\n			<div class=\"cosA\" style=\"box-sizing:border-box;margin-right:80px;\">\r\n				<span class=\"cosIco label-danger\" style=\"box-sizing:border-box;background-color:#36C6D3;display:inline-block;width:24px;height:24px;vertical-align:middle;color:#FFFFFF;text-align:center;border-radius:3px;\"><span class=\"am-icon-bolt\" style=\"box-sizing:border-box;display:inline-block;\"></span></span>&nbsp;云尚发卡系统免授权使用，切勿上当受骗，系统开源没有任何加密！\r\n			</div>\r\n		</li>\r\n		<li style=\"box-sizing:border-box;margin:0px 0px 7px;padding:10px !important;list-style:none;position:relative;border-bottom:1px solid #F4F6F9;height:auto !important;font-size:14px !important;line-height:22px !important;color:#82949A;\">\r\n			<div class=\"cosA\" style=\"box-sizing:border-box;margin-right:80px;\">\r\n				<span class=\"cosIco label-info\" style=\"box-sizing:border-box;background-color:#36C6D3;display:inline-block;width:24px;height:24px;vertical-align:middle;color:#FFFFFF;text-align:center;border-radius:3px;\"><span class=\"am-icon-bullhorn\" style=\"box-sizing:border-box;display:inline-block;\"></span></span>&nbsp;防止不法分子在源码中加入后门请到云尚官网下载正版程序！\r\n			</div>\r\n		</li>\r\n		<li style=\"box-sizing:border-box;margin:0px 0px 7px;padding:10px !important;list-style:none;position:relative;border-bottom:1px solid #F4F6F9;height:auto !important;font-size:14px !important;line-height:22px !important;color:#82949A;background:#F4F6F9;\">\r\n			<div class=\"cosA\" style=\"box-sizing:border-box;margin-right:80px;\">\r\n				<span class=\"cosIco label-warning\" style=\"box-sizing:border-box;background-color:#36C6D3;display:inline-block;width:24px;height:24px;vertical-align:middle;color:#FFFFFF;text-align:center;border-radius:3px;\"><span class=\"am-icon-plus\" style=\"box-sizing:border-box;display:inline-block;\"></span></span>&nbsp;软件官网：<a href=\"http://www.phpke.cn\" target=\"_blank\">http://www.phpke.cn</a>&nbsp; &nbsp; 交流QQ群 ：<a target=\"_blank\" href=\"//shang.qq.com/wpa/qunwpa?idkey=633fb72ae5064407d2af35f9bc0502629ccd3d9cd5b64ea51a424b1276f0cb9b\"><img border=\"0\" src=\"//pub.idqqimg.com/wpa/images/group.png\" alt=\"云尚软件交流群\" title=\"云尚软件交流群\"></a>\r\n			</div>\r\n		</li>\r\n	</ul>\r\n</h2>', '2017-03-21', 0, 0, 10, 'yunsfk2018');

-- ----------------------------
-- Table structure for ys_gdclass
-- ----------------------------
DROP TABLE IF EXISTS `ys_gdclass`;
CREATE TABLE `ys_gdclass`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `ord` int(100) NULL DEFAULT 0 COMMENT '商品排序',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ys_goods
-- ----------------------------
DROP TABLE IF EXISTS `ys_goods`;
CREATE TABLE `ys_goods`  (
  `id` int(100) NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `cid` int(100) NOT NULL COMMENT '分类id',
  `gname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '商品名称',
  `gmoney` decimal(20, 2) NOT NULL COMMENT '商品售价',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 自动发卡  1 手工订单',
  `checks` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否允许重复下单 1是  0否',
  `cont` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '商品介绍',
  `onetle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '第一个输入框标题',
  `gdipt` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更多input qq密码 ,大区名称',
  `ord` int(100) NULL DEFAULT 0 COMMENT '排序',
  `is_ste` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0下架 1上架',
  `kuc` int(100) NOT NULL DEFAULT 0 COMMENT '库存',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 24 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ys_kami
-- ----------------------------
DROP TABLE IF EXISTS `ys_kami`;
CREATE TABLE `ys_kami`  (
  `id` int(100) NOT NULL AUTO_INCREMENT,
  `gid` int(100) NOT NULL COMMENT '商品id',
  `kano` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '卡号',
  `is_ste` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0:正常 1:已售',
  `ctime` int(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 223 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for ys_mailtpl
-- ----------------------------
DROP TABLE IF EXISTS `ys_mailtpl`;
CREATE TABLE `ys_mailtpl`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `is_state` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `addtime` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cname`(`cname`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ys_mailtpl
-- ----------------------------
INSERT INTO `ys_mailtpl` VALUES (3, '卡密发送', '您在{sitename}购买的商品已发货', '<p class=\"p1\">\r\n<span class=\"s1\">尊敬的用户您好：</span> \r\n</p>\r\n<p class=\"p1\">\r\n<span class=\"s1\">您在：【{sitename}】 购买的商品：{gname} 已发货。</span> \r\n</p>\r\n<p class=\"p1\">订单号：{orid}</p>\r\n<p class=\"p1\">数量：{ornum}</p>\r\n<p class=\"p1\">金额：{cmoney}</p>\r\n<p class=\"p1\">时间：{ctime}</p>\r\n---------------------------------------------------------------------------------------------------------------------------<br/>\r\n<p class=\"p1\"> \r\n<span class=\"s1\">{orderinfo}</span>\r\n</p> \r\n---------------------------------------------------------------------------------------------------------------------------<br/>\r\n\r\n感谢您的惠顾，祝您生活愉快！<br/>\r\n<p class=\"p1\">\r\n	<span class=\"s1\">来自 <span style=\"white-space:normal;\">{sitename} -{siteurl}</span></span> \r\n</p>', 0, 1523789794);
INSERT INTO `ys_mailtpl` VALUES (5, '管理员通知', '【{sitename}】新订单等待处理', '<p class=\"p1\">尊敬的管理员：</p>\r\n\r\n<p class=\"p1\">客户购买的商品：【{gname}】 已支付成功，请及时处理。</p>\r\n------------------------------------------<br/>\r\n<p class=\"p1\">订单号：{orid}</p>\r\n<p class=\"p1\">数量：{ornum}</p>\r\n<p class=\"p1\">金额：{cmoney}</p>\r\n<p class=\"p1\">时间：{ctime}</p>\r\n---------------------------------------------<br/>\r\n\r\n<p class=\"p1\">\r\n	<span class=\"s1\">来自 <span style=\"white-space:normal;\">{sitename} -{siteurl}</span></span> \r\n</p>', 0, 1523790269);
INSERT INTO `ys_mailtpl` VALUES (6, '库存告警', '【{sitename}】库存告警', '<p class=\"p1\">尊敬的管理员：</p>\r\n\r\n<p class=\"p1\">平台商品：【{gname}】库存低于{ornum}，请及时补货。</p>\r\n\r\n<p class=\"p1\">\r\n	<span class=\"s1\">来自 <span style=\"white-space:normal;\">{sitename} -{siteurl}</span></span> \r\n</p>', 0, 1526475356);

-- ----------------------------
-- Table structure for ys_navcog
-- ----------------------------
DROP TABLE IF EXISTS `ys_navcog`;
CREATE TABLE `ys_navcog`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 17 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ys_navcog
-- ----------------------------
INSERT INTO `ys_navcog` VALUES (16, '{\"set\":\"\\u7cfb\\u7edf\\u8bbe\\u7f6e\",\"admins\":\"\\u7ba1\\u7406\\u5458\\u5217\\u8868\",\"orders\":\"\\u8ba2\\u5355\\u5217\\u8868\"}');

-- ----------------------------
-- Table structure for ys_orders
-- ----------------------------
DROP TABLE IF EXISTS `ys_orders`;
CREATE TABLE `ys_orders`  (
  `id` int(200) NOT NULL AUTO_INCREMENT,
  `orderid` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单id',
  `oname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '订单名称',
  `gid` int(100) NOT NULL COMMENT '商品id',
  `omoney` decimal(60, 2) NOT NULL DEFAULT 0.00 COMMENT '商品单价',
  `cmoney` decimal(60, 2) NOT NULL COMMENT '订单总价',
  `onum` int(100) NOT NULL COMMENT '订单数量',
  `chapwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '查询密码',
  `account` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '充值账号',
  `otype` tinyint(1) NOT NULL COMMENT '订单类型 0自动发卡 1手工充值',
  `info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '充值详情',
  `payid` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '第三方支付平台id',
  `paytype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '支付方式',
  `ctime` int(100) NOT NULL COMMENT '下单日期',
  `status` tinyint(1) NOT NULL COMMENT '0待付款 1待处理 2已处理 3已完成  4处理失败 5发卡失败',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 768 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
