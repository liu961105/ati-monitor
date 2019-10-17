/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : springmvc-model

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 11/01/2019 11:20:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for email_user
-- ----------------------------
DROP TABLE IF EXISTS `email_user`;
CREATE TABLE `email_user`  (
  `email_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮件id',
  `user_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户id',
  PRIMARY KEY (`email_id`, `user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '邮件用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of email_user
-- ----------------------------
INSERT INTO `email_user` VALUES ('40289ff7667fb33b01667fc14f820011', '40289f5b659d50d201659d5a9ab20000');
INSERT INTO `email_user` VALUES ('40289ff7667fb33b01667fc1e4a90012', '40289f5b659d50d201659d5a9ab20000');
INSERT INTO `email_user` VALUES ('40289ff7667fb33b01667fc1e4a90012', '40289f5b6656b34201665799fe700007');

-- ----------------------------
-- Table structure for file_catalog
-- ----------------------------
DROP TABLE IF EXISTS `file_catalog`;
CREATE TABLE `file_catalog`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据主键',
  `catalog_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目录编码',
  `catalog_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '目录名称',
  `p_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上级目录编码',
  `seq` int(11) NULL DEFAULT NULL COMMENT '顺序',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改时间',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据状态（1：有效；0：无效）',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `catalog_code`(`catalog_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文件目录维护表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file_catalog
-- ----------------------------
INSERT INTO `file_catalog` VALUES ('0000000065e650e30165e69c6f340003', '001001001', '工艺文件', '001001', 1, 'admin', '2018-09-17 16:18:56', NULL, NULL, '1');
INSERT INTO `file_catalog` VALUES ('0000000065e650e30165e69cb0950004', '001001002', '管理办法', '001001', 2, 'admin', '2018-09-17 16:19:13', NULL, NULL, '1');
INSERT INTO `file_catalog` VALUES ('0000000065e650e30165e69cddfe0005', '001001003', '作业指导书', '001001', 3, 'admin', '2018-09-17 16:19:24', NULL, NULL, '1');
INSERT INTO `file_catalog` VALUES ('402880a265dc39e50165dc53d1800019', '001002', '第一层次', '001', 2, 'admin', '2018-09-15 16:23:25', NULL, NULL, '1');
INSERT INTO `file_catalog` VALUES ('40289fa065c10d110165c10f5dc80001', '001001', '第三层次', '001', 1, 'admin', '2018-09-10 09:18:54', NULL, NULL, '1');
INSERT INTO `file_catalog` VALUES ('9842af39b28f11e883be00e04c1a78e0', '001', '公司文件', '0', 1, 'admin', '2018-09-07 19:19:19', NULL, NULL, '1');

-- ----------------------------
-- Table structure for file_manage
-- ----------------------------
DROP TABLE IF EXISTS `file_manage`;
CREATE TABLE `file_manage`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '数据主键',
  `catalog_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属桥梁主键',
  `file_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文件类型（1：桥梁图纸；2：历史报告；3：其他）',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `file_size` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件大小',
  `upload_time` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上传时间',
  `file_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件存放路径',
  `sh_status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件锁定状态：1：未锁定；0：锁定',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件有效状态：1：有效；0无效',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_filetypename`(`file_type`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文档管理信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file_manage
-- ----------------------------
INSERT INTO `file_manage` VALUES ('40289fa068126db90168127b9a7e0004', '1', '0', '2、test（模板） -20181218.xlsx', '53496', NULL, '/upload/filebridge/2、test（模板） -20181218.xlsx', NULL, NULL);
INSERT INTO `file_manage` VALUES ('40289fa068126db901681283fce00005', '1', '1', 'login.compment.txt', '5577', NULL, '/upload/filebridge/login.compment.txt', NULL, NULL);
INSERT INTO `file_manage` VALUES ('40289fa068126db90168128606360006', '1', '2', '定期检查软件v1.xls', '77824', NULL, '/upload/filebridge/定期检查软件v1.xls', NULL, NULL);

-- ----------------------------
-- Table structure for group_user
-- ----------------------------
DROP TABLE IF EXISTS `group_user`;
CREATE TABLE `group_user`  (
  `group_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '班组主键',
  `user_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '员工主键',
  PRIMARY KEY (`group_id`, `user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '班组人员关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for index_remind
-- ----------------------------
DROP TABLE IF EXISTS `index_remind`;
CREATE TABLE `index_remind`  (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '事务提醒id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提醒名称',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '提醒内容',
  `create_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `source` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建来源',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '事务提醒' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of index_remind
-- ----------------------------
INSERT INTO `index_remind` VALUES ('ajhgda', '测试事务提醒', '今天天气很好', NULL, NULL, NULL);
INSERT INTO `index_remind` VALUES ('asdasdasd', 'kingleo加班', '今晚大家都加班', NULL, NULL, NULL);
INSERT INTO `index_remind` VALUES ('dasjdghsjkd', '有新的订单', '有新的订单了，请注意查看', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role`  (
  `roleid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `menuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`roleid`, `menuid`) USING BTREE,
  INDEX `FK_frsm75appsa9g9bf3sonchdrc`(`menuid`) USING BTREE,
  INDEX `FK_7dixssjx3o9hb27rb570t96kk`(`roleid`) USING BTREE,
  CONSTRAINT `FK_7dixssjx3o9hb27rb570t96kk` FOREIGN KEY (`roleid`) REFERENCES `sys_role` (`roleid`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_frsm75appsa9g9bf3sonchdrc` FOREIGN KEY (`menuid`) REFERENCES `sys_menu` (`menuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单角色关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES ('402880e860f555c20160f584af0c0002', '0');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '0');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '0000000065a25e0f0165a7b5789d000e');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '05d404cdad0d11e88bc100e04c1a78e0');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '2a90ff16ad0d11e88bc100e04c1a78e0');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880a265d1ab790165d1db5c100003');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880a265d7073f0165d73565ea0008');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880a265d7073f0165d73b07de0009');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880a265d7073f0165d73b7492000a');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880a265d7073f0165d73bd6f8000b');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880a265d7073f0165d73c32a1000c');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880a265d7073f0165d73c83ce000d');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880e860e5d5b40160e5dfee730003');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880e860f534020160f54e5dbc0000');
INSERT INTO `menu_role` VALUES ('402880e860f555c20160f584af0c0002', '402880f760e13d840160e13dd5970000');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e13d840160e13dd5970000');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e13d840160e14269650003');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e13d840160e1486800000a');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e152afec0000');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e15353ed0001');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e15431460002');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e166900f000a');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e167f912000c');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e1691009000f');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e17bb349001b');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e17cfddf001c');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e17d8d0e001d');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e17eba37001e');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e1802af0001f');
INSERT INTO `menu_role` VALUES ('402880e860f555c20160f584af0c0002', '402880f760e14fc90160e1841c470021');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e1841c470021');
INSERT INTO `menu_role` VALUES ('402880e860f555c20160f584af0c0002', '402880f760e14fc90160e184dcb50022');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e184dcb50022');
INSERT INTO `menu_role` VALUES ('402880e860f555c20160f584af0c0002', '402880f760e14fc90160e18561150023');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e18561150023');
INSERT INTO `menu_role` VALUES ('402880e860f555c20160f584af0c0002', '402880f760e14fc90160e18601b40024');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '402880f760e14fc90160e18601b40024');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289f5b659ae04701659ae6ca5a0000');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289f5b659af09601659af6b96f0001');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289f5b659af09601659af785a90002');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289f5b659af09601659af8ed030003');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289f5b65ce006d0165ce0399950001');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289f5b65ce58250165ce5b68280001');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289f5b667af16f01667bb432b70001');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa065ace0960165acf42ff10001');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa065ace0960165acf8d7960003');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa065ace0960165acf9aedd0004');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa065ace0960165acfcb5280005');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa065ace0960165acfdb17e0006');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa065b20b0c0165b23ee0010012');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa065b20b0c0165b23f1ea20013');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa065b20b0c0165b23f94ef0014');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa0667579a101667589accd0001');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa0667579a101667592856e0002');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa0667d99a801667da81c8e0001');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa0667d99a801667da93d570002');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa0667d99a801667da9a4870003');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa0667d99a801667da9fb7d0004');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa0667d99a801667daa941d0005');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa0667d99a801667dab1cec0006');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289fa066ae16e90166ae1925c00001');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289ff7659ad6a401659ae017b20000');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289ff7659aee1401659af792a70001');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289ff7659aee1401659af7f9670002');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289ff7659aee1401659af8a1c10003');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289ff7659de05d01659de21e990000');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289ff766ae022d0166ae2002060002');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289ff766af04060166af1208ea0001');
INSERT INTO `menu_role` VALUES ('402880e860f555c20160f584af0c0002', '40289ff766af4da80166af5420890001');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289ff766af4da80166af5420890001');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '40289ff766af4da80166af5d230d0002');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '4549901bad0d11e88bc100e04c1a78e0');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '4a0a10c6ad0d11e88bc100e04c1a78e0');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '4dc8ebdbad0d11e88bc100e04c1a78e0');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '793b80e9ad0c11e88bc100e04c1a78e0');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '84bb87acad0d11e88bc100e04c1a78e0');
INSERT INTO `menu_role` VALUES ('402880e860f555c20160f584af0c0002', '8828132dad0d11e88bc100e04c1a78e0');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '8828132dad0d11e88bc100e04c1a78e0');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', 'd21a5f17ad0c11e88bc100e04c1a78e0');
INSERT INTO `menu_role` VALUES ('402880e860f555c20160f584af0c0002', 'dfe7a481ad0c11e88bc100e04c1a78e0');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', 'dfe7a481ad0c11e88bc100e04c1a78e0');
INSERT INTO `menu_role` VALUES ('402880e860f555c20160f584af0c0002', 'e92aec10ad0c11e88bc100e04c1a78e0');
INSERT INTO `menu_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', 'e92aec10ad0c11e88bc100e04c1a78e0');

-- ----------------------------
-- Table structure for sys_comp_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_comp_dept`;
CREATE TABLE `sys_comp_dept`  (
  `DEPT_ID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DEPT_NAME` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `COMPANY_ID` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPT_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `PARENT_DEPT_CODE` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `DEPT_SEQ` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `CREATE_TIME` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `UPDATE_TIME` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `STATE` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据有效性（0：无效，1：有效）',
  PRIMARY KEY (`DEPT_ID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_comp_dept
-- ----------------------------
INSERT INTO `sys_comp_dept` VALUES ('40289f5b65c229f90165c24cec1b0001', '艾特111', '40289ff7659f117a01659f12908b0000', '001001001001', '001001001', '1', '2018-09-10 15:05:45', '2018-09-10 15:05:45', '1');
INSERT INTO `sys_comp_dept` VALUES ('40289ff7659f117a01659f1290e90001', '公司1', '40289ff7659f117a01659f12908b0000', '001', '0', '11', '2018-09-03 18:55:18', '2018-09-03 18:55:18', '1');
INSERT INTO `sys_comp_dept` VALUES ('40289ff7659f8e5d01659f8ebf640000', '艾1', '40289ff7659f117a01659f12908b0000', '001001', '001', '12', '2018-09-03 21:11:31', '2018-09-03 21:11:31', '1');
INSERT INTO `sys_comp_dept` VALUES ('40289ff7659f8e5d01659f8eefa80001', '艾特11', '40289ff7659f117a01659f12908b0000', '001001001', '001001', '1', '2018-09-03 21:16:09', '2018-09-03 21:16:09', '1');
INSERT INTO `sys_comp_dept` VALUES ('40289ff7659fa52301659fa5d8810001', '公司', '40289ff7659fa52301659fa5d8440000', '001', '0', '1', '2018-09-17 17:32:50', '2018-09-17 17:32:50', '1');
INSERT INTO `sys_comp_dept` VALUES ('40289ff7659fad9101659faed8eb0000', '艾特11', '40289ff7659fa52301659fa5d8440000', '001001', '001', '1', '2018-09-03 21:46:00', '2018-09-03 21:46:00', '1');
INSERT INTO `sys_comp_dept` VALUES ('40289ff7659fad9101659faf76ab0001', '部门', '40289ff7659fa52301659fa5d8440000', '001001001', '001001', '1', '2018-09-03 21:46:41', '2018-09-03 21:46:41', '1');
INSERT INTO `sys_comp_dept` VALUES ('40289ff765a23a260165a24365280000', '部门1', '40289ff7659fa52301659fa5d8440000', '001001001001', '001001001', '1', '2018-09-04 09:47:30', '2018-09-04 09:47:30', '1');
INSERT INTO `sys_comp_dept` VALUES ('40289ff765a23a260165a24373d70001', '小组', '40289ff7659fa52301659fa5d8440000', '001001001001001', '001001001001', '1', '2018-09-04 09:47:34', '2018-09-04 09:47:34', '1');

-- ----------------------------
-- Table structure for sys_company_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_company_info`;
CREATE TABLE `sys_company_info`  (
  `company_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '公司主键',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司名称',
  `shorter_form` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司简称',
  `tax_num` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司纳税登记号',
  `legal_person_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司法人姓名',
  `legal_person_tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司法人电话',
  `legal_person_addr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司法人住址',
  `legal_person_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公司法人邮箱',
  `brief_introduction` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '公司简介',
  `create_time` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `state` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '数据有效性（0：无效，1：有效）',
  PRIMARY KEY (`company_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '公司信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_company_info
-- ----------------------------
INSERT INTO `sys_company_info` VALUES ('40289ff7659fa52301659fa5d8440000', '公司', 'asda', 'cacasca', '1231', '11111111111', '123123', 'qewq', '测试测试测测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试试测试测试测试测试', '2018-09-03 21:36:10', '2018-10-26 09:49:54', '1');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `deptid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `createtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createuser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `updatetime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `updateuser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dept_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`deptid`) USING BTREE,
  INDEX `FK_byyqm7eau37hb07wkv6v8apyh`(`pid`) USING BTREE,
  CONSTRAINT `FK_byyqm7eau37hb07wkv6v8apyh` FOREIGN KEY (`pid`) REFERENCES `sys_dept` (`deptid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('ff8080816610e22d016613e9a83c0004', '2018-09-26 11:26:12', 'admin', '营销部', '', '2018-09-27 10:17:03', 'admin', 'ff8080816610e22d01661463779b0029', NULL);
INSERT INTO `sys_dept` VALUES ('ff8080816610e22d016613ee110d0005', '2018-09-26 11:31:01', 'admin', '研发中心', '', '2018-09-27 10:17:45', 'admin', 'ff8080816610e22d01661463779b0029', NULL);
INSERT INTO `sys_dept` VALUES ('ff8080816610e22d016613ee41100006', '2018-09-26 11:31:13', 'admin', '制造部', '', '2018-09-27 10:17:31', 'admin', 'ff8080816610e22d01661463779b0029', NULL);
INSERT INTO `sys_dept` VALUES ('ff8080816610e22d016613ee6a100007', '2018-09-26 11:31:23', 'admin', '财务部', '', '2018-09-27 10:17:57', 'admin', 'ff8080816610e22d01661463779b0029', NULL);
INSERT INTO `sys_dept` VALUES ('ff8080816610e22d016613eead400008', '2018-09-26 11:31:40', 'admin', '质量部', '', '2018-09-27 10:18:15', 'admin', 'ff8080816610e22d01661463779b0029', NULL);
INSERT INTO `sys_dept` VALUES ('ff8080816610e22d016613eeeac00009', '2018-09-26 11:31:56', 'admin', '综合部', '', '2018-09-27 10:18:35', 'admin', 'ff8080816610e22d01661463779b0029', NULL);
INSERT INTO `sys_dept` VALUES ('ff8080816610e22d016613ef18b7000a', '2018-09-26 11:32:08', 'admin', '人事行政部', '', '2018-09-27 10:18:47', 'admin', 'ff8080816610e22d01661463779b0029', NULL);
INSERT INTO `sys_dept` VALUES ('ff8080816610e22d016613f16f82000b', '2018-09-26 11:34:41', 'admin', '管理及内勤', '', NULL, NULL, 'ff8080816610e22d016613e9a83c0004', NULL);
INSERT INTO `sys_dept` VALUES ('ff8080816610e22d016613f94e970011', '2018-09-26 11:43:17', 'admin', '管理组', '', NULL, NULL, 'ff8080816610e22d016613ee110d0005', NULL);
INSERT INTO `sys_dept` VALUES ('ff8080816610e22d0166140be056001c', '2018-09-26 12:03:34', 'admin', '会计组', '', NULL, NULL, 'ff8080816610e22d016613ee6a100007', NULL);
INSERT INTO `sys_dept` VALUES ('ff8080816610e22d016614575f9a001f', '2018-09-26 13:26:02', 'admin', '质管组', '', '2018-09-27 09:24:47', 'admin', 'ff8080816610e22d016613eead400008', NULL);
INSERT INTO `sys_dept` VALUES ('ff8080816610e22d01661458cbc20024', '2018-09-26 13:27:35', 'admin', '项目组', '', NULL, NULL, 'ff8080816610e22d016613eeeac00009', NULL);
INSERT INTO `sys_dept` VALUES ('ff8080816610e22d016614596e020027', '2018-09-26 13:28:17', 'admin', '人事组', '', NULL, NULL, 'ff8080816610e22d016613ef18b7000a', NULL);
INSERT INTO `sys_dept` VALUES ('ff8080816610e22d01661463779b0029', '2018-09-26 13:39:14', 'admin', '总经办', '', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_email
-- ----------------------------
DROP TABLE IF EXISTS `sys_email`;
CREATE TABLE `sys_email`  (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编号',
  `subject` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '主题',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '内容',
  `file_list` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '附件',
  `to_list` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '收件人',
  `create_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '邮件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_email
-- ----------------------------
INSERT INTO `sys_email` VALUES ('40289ff7667fb33b01667fc14f820011', 'scqgq', '生产期过期', '生产期过期111', '软件研发部-于建刚.jpg,需要修改功能.docx', '40289f5b659d50d201659d5a9ab20000', '2018-10-18 15:29:06', 'admin', '1');
INSERT INTO `sys_email` VALUES ('40289ff7667fb33b01667fc1e4a90012', 'sbyc', '2', '2', 'newOrder.xls,newUser.xls', '40289f5b659d50d201659d5a9ab20000,40289f5b6656b34201665799fe700007', '2018-10-17 10:01:45', 'admin', '1');

-- ----------------------------
-- Table structure for sys_group
-- ----------------------------
DROP TABLE IF EXISTS `sys_group`;
CREATE TABLE `sys_group`  (
  `group_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '班组主键',
  `workshop_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属车间id',
  `group_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '班组名称',
  `group_leader` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '班组组长',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '班组信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_group
-- ----------------------------
INSERT INTO `sys_group` VALUES ('40289fa066e33acc0166e37ae46b0002', NULL, '123', '123', 'admin', '2018-11-05 18:46:13');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `logid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `businss_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createuser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_success` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `oper` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_by` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `create_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `exception_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `exception_detail` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `params` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `request_ip` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`logid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('0447cba135c94680946bd29204480730', '移动端系统登录', '2018-12-31 15:33:49', 'Admin', '122.234.223.205', '执行成功', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('0cc292531f814e18b53d5e228651d8ee', '移动端系统登录', '2018-12-31 16:07:07', 'admin', '122.234.223.205', '执行成功', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('15a1e0b4cf4a455daa4660c5015e7640', '移动端系统登录', '2018-12-31 15:15:45', 'admin', '122.234.223.205', '执行成功', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f67f8b098016811b9ff49000a', '日志管理-系统登录', '2019-01-03 11:20:28', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f67f8b0980168128e2eb8000b', '日志管理-系统登录', '2019-01-03 15:12:14', 'admin', '42.92.181.84', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f67f8b0980168128e63ee000c', '日志管理-系统登录', '2019-01-03 15:12:28', 'admin', '222.85.147.87', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f67f8b0980168128e88da000d', '日志管理-系统登录', '2019-01-03 15:12:37', 'admin', '222.85.147.87', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f681294500168129492bc0000', '日志管理-系统登录', '2019-01-03 15:19:13', 'admin', '42.92.181.84', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '88', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812a2571c0001', '日志管理-系统登录', '2019-01-03 15:34:15', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812a2e4880002', '日志管理-系统登录', '2019-01-03 15:34:51', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812a32ebc0003', '日志管理-系统登录', '2019-01-03 15:35:10', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812a4c8520004', '日志管理-系统登录', '2019-01-03 15:36:55', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812a4e5060005', '日志管理-系统登录', '2019-01-03 15:37:02', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812a50c2a0006', '日志管理-系统登录', '2019-01-03 15:37:12', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812a546810007', '日志管理-系统登录', '2019-01-03 15:37:27', 'admin', '115.207.94.135', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '8', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812a666560008', '日志管理-系统登录', '2019-01-03 15:38:41', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812a6ad980009', '日志管理-系统登录', '2019-01-03 15:38:59', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812a6c4d0000a', '日志管理-系统登录', '2019-01-03 15:39:05', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812b808d9000b', '日志管理-系统登录', '2019-01-03 15:57:57', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812bab0fe000c', '日志管理-系统登录', '2019-01-03 16:00:51', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812bace03000d', '日志管理-系统登录', '2019-01-03 16:00:58', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812bb1ce8000e', '日志管理-系统登录', '2019-01-03 16:01:19', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812be10ac000f', '日志管理-系统登录', '2019-01-03 16:04:32', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812c1496d0010', '日志管理-系统登录', '2019-01-03 16:08:03', 'Admin', '223.104.94.255', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812c21d9c0011', '日志管理-系统登录', '2019-01-03 16:08:58', 'admin', '223.104.94.255', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812c28d790012', '日志管理-系统登录', '2019-01-03 16:09:26', 'admin', '223.104.95.164', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812c314080013', '日志管理-系统登录', '2019-01-03 16:10:01', 'admin', '223.104.95.219', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812c513e30014', '日志管理-系统登录', '2019-01-03 16:12:12', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812cacb790016', '日志管理-系统登录', '2019-01-03 16:18:26', 'admin', '223.104.95.187', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812cb16eb0017', '日志管理-系统登录', '2019-01-03 16:18:46', 'admin', '223.104.95.187', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812cbc7a30018', '日志管理-系统登录', '2019-01-03 16:19:31', 'admin', '223.104.95.187', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812e31c100019', '日志管理-系统登录', '2019-01-03 16:45:00', 'admin', '223.104.95.187', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016812e4eddc001b', '日志管理-系统登录', '2019-01-03 16:46:59', 'admin', '223.104.95.187', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f681294500168130321f5001d', '日志管理-系统登录', '2019-01-03 17:19:58', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f6812945001681304eb0c001e', '日志管理-系统登录', '2019-01-03 17:21:55', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016813056bc5001f', '日志管理-系统登录', '2019-01-03 17:22:28', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016813058cf40020', '日志管理-系统登录', '2019-01-03 17:22:37', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f6812945001681305a99d0021', '日志管理-系统登录', '2019-01-03 17:22:44', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016816cba1f10025', '日志管理-系统登录', '2019-01-04 10:57:50', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '32', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016816e295dd0026', '日志管理-系统登录', '2019-01-04 11:22:54', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016818fa51940027', '日志管理-系统登录', '2019-01-04 21:08:04', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('2c92ab4f68129450016818fa99c30028', '日志管理-系统登录', '2019-01-04 21:08:23', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '8', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('359fd8e98a4c451388d98c7bb5b82679', '移动端系统登录', '2018-12-26 14:35:57', 'admin', '125.120.172.104', '执行失败', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402880e667fe270f0167fe2822480000', '日志管理-系统登录', '2019-12-30 16:08:21', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '270', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881e76828bf6e016828c2fa390000', '日志管理-系统登录', '2019-01-07 22:41:32', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '316', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881e76828d90b016828d9986e0000', '日志管理-系统登录', '2019-01-07 23:06:15', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '11', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881e76828d90b016828d9b1b10001', '日志管理-系统登录', '2019-01-07 23:06:21', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '116', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881e76828e1fc016828e40bab0000', '日志管理-系统登录', '2019-01-07 23:17:40', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '238', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881e8675f9a6e01675fa429280000', '日志管理-系统登录', '2018-11-29 21:24:12', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '201', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881e8675fbe4201675fc22e600000', '日志管理-系统登录', '2018-11-29 21:57:00', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '234', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881e8675fd9db01675fda36420000', '日志管理-系统登录', '2018-11-29 22:23:15', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '247', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881e8675fd9db01675fda5d670001', '日志管理-系统登录', '2018-11-29 22:23:25', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '10', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881e867600ebb0167601126550000', '日志管理-系统登录', '2018-11-29 23:23:15', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '350', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881e867602517016760258d800000', '日志管理-系统登录', '2018-11-29 23:45:32', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '333', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881e86765d167016765d55d3b0000', '日志管理-系统登录', '2018-12-01 02:15:40', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '172', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881e86798b89e016798b96a320000', '日志管理-系统登录', '2018-12-10 23:25:47', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '215', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881e867da0fe70167da2e526c0000', '日志管理-系统登录', '2018-12-23 16:28:47', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '295', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881ea6703164e0167031766620000', '日志管理-系统登录', '2018-11-11 22:05:24', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '165', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881ea670338b20167033935ae0000', '日志管理-系统登录', '2018-11-11 22:42:19', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '179', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('402881ea67033aec0167033b42c10000', '日志管理-系统登录', '2018-11-11 22:44:34', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '151', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5267cb462d0167cb4858ca0000', '日志管理-系统登录', '2018-12-20 19:02:55', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '11', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5267cb462d0167cb4874340001', '日志管理-系统登录', '2018-12-20 19:03:02', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '148', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5267cba6300167cba818330000', '日志管理-系统登录', '2018-12-20 20:47:30', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '208', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5267cbac1c0167cbac8cbf0000', '日志管理-系统登录', '2018-12-20 20:52:21', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '316', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5267cf5a160167cf5a9b770000', '日志管理-系统登录', '2018-12-21 14:01:20', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '8', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5267cf5a160167cf5ab5960001', '日志管理-系统登录', '2018-12-21 14:01:27', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '141', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5267cfd57e0167cfd69f0d0000', '日志管理-系统登录', '2018-12-21 16:16:48', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '254', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5267cfd57e0167cfd6b4970001', '日志管理-系统登录', '2018-12-21 16:16:53', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '16', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5267cfd57e0167cfd6c6180002', '日志管理-系统登录', '2018-12-21 16:16:58', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '14', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5267cfe10e0167cfe55df00000', '日志管理-系统登录', '2018-12-21 16:32:54', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '375', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5267de03fb0167de04f2090000', '日志管理-系统登录', '2018-12-24 10:22:04', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '273', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5267de06ce0167de09c1450000', '日志管理-系统登录', '2018-12-24 10:27:20', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '275', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b6685fae0016685fb56f90000', '日志管理-系统登录', '2018-10-18 15:02:13', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '150', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b668628da0166863192650000', '日志管理-系统登录', '2018-10-18 16:01:27', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '102', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b66866d190166866fe50e0000', '日志管理-系统登录', '2018-10-18 17:09:31', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '122', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b668a144401668a2d21fc0000', '日志管理-系统登录', '2018-10-19 10:35:05', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '122', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b668a439c01668a4423d40000', '日志管理-系统登录', '2018-10-19 11:00:13', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '108', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b668a439c01668a66c0b50001', '日志管理-系统登录', '2018-10-19 11:38:01', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '8', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b668a6f0a01668a70f1490000', '日志管理-系统登录', '2018-10-19 11:49:09', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '137', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b668a74dc01668a7547b40000', '日志管理-系统登录', '2018-10-19 11:53:53', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '144', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b668b16b201668b1785ce0000', '日志管理-系统登录', '2018-10-19 14:51:06', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '124', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b669987a80166998ad9d50000', '日志管理-系统登录', '2018-10-22 10:11:45', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '101', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b6699b582016699b62bcb0000', '日志管理-系统登录', '2018-10-22 10:59:04', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '134', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b6699ba03016699babe560000', '日志管理-系统登录', '2018-10-22 11:04:04', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '100', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b6777179c01677717f3c00000', '日志管理-系统登录', '2018-12-04 10:41:57', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b6777179c0167771815b20001', '日志管理-系统登录', '2018-12-04 10:42:06', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '135', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677753a60167775489770000', '日志管理-系统登录', '2018-12-04 11:48:08', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677753a601677754adb80001', '日志管理-系统登录', '2018-12-04 11:48:17', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677753a601677754c9860002', '日志管理-系统登录', '2018-12-04 11:48:24', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677753a601677754fc2e0003', '日志管理-系统登录', '2018-12-04 11:48:37', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '95', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b6777590a01677759707e0000', '日志管理-系统登录', '2018-12-04 11:53:29', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '124', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b6777edac016777eeabb60000', '日志管理-系统登录', '2018-12-04 14:36:29', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '124', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b6777fa26016777faa5390000', '日志管理-系统登录', '2018-12-04 14:49:34', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '115', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b6778191601677819a8990000', '日志管理-系统登录', '2018-12-04 15:23:26', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '129', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67784df901677850192d0000', '日志管理-系统登录', '2018-12-04 16:22:54', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '146', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677888cf016778894c2f0000', '日志管理-系统登录', '2018-12-04 17:25:22', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '114', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677c152a01677c158a3d0000', '日志管理-系统登录', '2018-12-05 09:57:25', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677c152a01677c15a1720001', '日志管理-系统登录', '2018-12-05 09:57:31', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677c152a01677c15c3ab0002', '日志管理-系统登录', '2018-12-05 09:57:40', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '88', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677c2ee901677c304ea70000', '日志管理-系统登录', '2018-12-05 10:26:39', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '95', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677c2ee901677c5926f10004', '日志管理-系统登录', '2018-12-05 11:11:16', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677c2ee901677c65f2740005', '日志管理-系统登录', '2018-12-05 11:25:15', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677c2ee901677c65f6740006', '日志管理-系统登录', '2018-12-05 11:25:16', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677c2ee901677c65f9b30007', '日志管理-系统登录', '2018-12-05 11:25:17', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677c2ee901677c6602bf0008', '日志管理-系统登录', '2018-12-05 11:25:19', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b677c6b6b01677c6bd2780000', '日志管理-系统登录', '2018-12-05 11:31:40', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '154', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67df5a9c0167df5b1dbc0000', '日志管理-系统登录', '2018-12-24 16:35:49', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '174', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e2ebff0167e2eca8ff0000', '日志管理-系统登录', '2018-12-25 09:13:39', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '132', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e2ebff0167e30260cb0011', '日志管理-系统登录', '2018-12-25 09:37:23', 'admin1', '192.168.31.70', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e2ebff0167e3027f680012', '日志管理-系统登录', '2018-12-25 09:37:30', 'admin', '192.168.31.70', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e2ebff0167e30ee2b5002e', '日志管理-系统登录', '2018-12-25 09:51:02', 'admin', '192.168.31.149', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e2ebff0167e30eef5a002f', '日志管理-系统登录', '2018-12-25 09:51:06', 'admin', '192.168.31.149', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e2ebff0167e30f037c0030', '日志管理-系统登录', '2018-12-25 09:51:11', 'admin', '192.168.31.149', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e356250167e356d7910000', '日志管理-系统登录', '2018-12-25 11:09:38', 'admin', '192.168.31.70', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '83', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e356250167e356e43f0001', '日志管理-系统登录', '2018-12-25 11:09:41', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '8', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e3710f0167e37166650000', '日志管理-系统登录', '2018-12-25 11:38:38', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '105', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e3710f0167e37368ef0001', '日志管理-系统登录', '2018-12-25 11:40:50', 'admin', '192.168.31.70', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e426940167e42748450000', '日志管理-系统登录', '2018-12-25 14:57:18', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '165', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e4284d0167e428a46a0000', '日志管理-系统登录', '2018-12-25 14:58:47', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '141', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e4284d0167e42bf26e0001', '日志管理-系统登录', '2018-12-25 15:02:24', 'admin', '192.168.31.70', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '4', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e4284d0167e42bf26f0002', '日志管理-系统登录', '2018-12-25 15:02:24', 'admin', '192.168.31.70', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '4', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e4284d0167e42bf2750003', '日志管理-系统登录', '2018-12-25 15:02:24', 'admin', '192.168.31.70', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e4284d0167e42bf2850004', '日志管理-系统登录', '2018-12-25 15:02:24', 'admin', '192.168.31.70', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '18', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289f5b67e44c560167e44d05a70000', '日志管理-系统登录', '2018-12-25 15:38:32', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '130', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06694757001669477b31c0000', '日志管理-系统登录', '2018-10-21 10:32:44', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '128', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06694757001669480a7dc0001', '日志管理-系统登录', '2018-10-21 10:42:31', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '9', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0669475700166948de9970005', '日志管理-系统登录', '2018-10-21 10:57:00', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '8', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066a4a8fb0166a4aa4f3a0000', '日志管理-系统登录', '2018-10-24 14:01:56', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '133', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066a4a8fb0166a4af613e0001', '日志管理-系统登录', '2018-10-24 14:07:29', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066a4a8fb0166a4c923f30002', '日志管理-系统登录', '2018-10-24 14:35:37', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '9', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066a5faf20166a5fb62280000', '日志管理-系统登录', '2018-10-24 20:10:07', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '166', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ae16e90166ae17facd0000', '日志管理-系统登录', '2018-10-26 09:58:18', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '211', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ae262b0166ae2699f50000', '日志管理-系统登录', '2018-10-26 10:14:17', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '127', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066cce5b40166cce7c2340000', '日志管理-系统登录', '2018-11-01 09:33:52', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '125', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ccf8300166ccf8a4260000', '日志管理-系统登录', '2018-11-01 09:52:18', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '147', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066e2d9d10166e2dc9ecc0000', '日志管理-系统登录', '2018-11-05 15:53:21', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '132', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066e3018f0166e30b41240000', '日志管理-系统登录', '2018-11-05 16:44:17', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '128', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066e33acc0166e33b968b0000', '日志管理-系统登录', '2018-11-05 17:37:05', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '132', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066e33acc0166e376f37c0001', '日志管理-系统登录', '2018-11-05 18:41:55', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066e7bb430166e7bf21300000', '日志管理-系统登录', '2018-11-06 14:39:14', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '314', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ebd3b40166ebd486850000', '日志管理-系统登录', '2018-11-07 09:41:05', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '148', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ec72b90166ec7569100000', '日志管理-系统登录', '2018-11-07 12:36:49', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '157', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ec72b90166ecb7c4b20001', '日志管理-系统登录', '2018-11-07 13:49:18', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ec72b90166ecdbe4ba0002', '日志管理-系统登录', '2018-11-07 14:28:45', NULL, '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '16', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ec72b90166ecdc7e440003', '日志管理-系统登录', '2018-11-07 14:29:25', NULL, '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ec72b90166ece088030004', '日志管理-系统登录', '2018-11-07 14:33:49', NULL, '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ec72b90166ece1b72d0005', '日志管理-系统登录', '2018-11-07 14:35:07', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ec72b90166ece325340006', '日志管理-系统登录', '2018-11-07 14:35:55', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '45369', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ec72b90166ece422b40007', '日志管理-系统登录', '2018-11-07 14:37:19', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '26869', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ec72b90166ece58db70008', '日志管理-系统登录', '2018-11-07 14:39:13', NULL, '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5219', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ec72b90166ece799670009', '日志管理-系统登录', '2018-11-07 14:40:28', NULL, '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '64878', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ec72b90166eceff583000a', '日志管理-系统登录', '2018-11-07 14:50:23', NULL, '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '16967', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ec72b90166ecf0b218000b', '日志管理-系统登录', '2018-11-07 14:51:18', NULL, '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '10371', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066ec72b90166ecf30351000c', '日志管理-系统登录', '2018-11-07 14:54:01', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '11', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066f0dc3a0166f0dd635b0000', '日志管理-系统登录', '2018-11-08 09:08:52', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '212', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066f0fb730166f0fc3bf90000', '日志管理-系统登录', '2018-11-08 09:42:34', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '180', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066f226150166f22ad19f0000', '日志管理-系统登录', '2018-11-08 15:13:04', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '227', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066f226150166f24448fc0001', '日志管理-系统登录', '2018-11-08 15:40:53', 'admin', '192.168.31.197', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '10', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066f226150166f313c9730002', '日志管理-系统登录', '2018-11-08 19:27:32', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066f62d200166f62ef45d0000', '日志管理-系统登录', '2018-11-09 09:56:04', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '240', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066f768ac0166f76a16de0000', '日志管理-系统登录', '2018-11-09 15:40:16', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '228', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa066f7a8690166f7aedb140000', '日志管理-系统登录', '2018-11-09 16:55:23', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '126', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067057d7d0167057e16a10000', '日志管理-系统登录', '2018-11-12 09:16:48', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '356', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06706a099016706c3942d0000', '日志管理-系统登录', '2018-11-12 15:12:19', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '134', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06707400401670740d7a80000', '日志管理-系统登录', '2018-11-12 17:29:09', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '144', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06707421a01670743154b0000', '日志管理-系统登录', '2018-11-12 17:31:35', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '156', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670775dc01670778f7700000', '日志管理-系统登录', '2018-11-12 18:30:27', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '162', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670793a6016707943f8b0000', '日志管理-系统登录', '2018-11-12 19:00:15', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '150', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06707dae7016707fc37280000', '日志管理-系统登录', '2018-11-12 20:53:48', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '196', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06708038f01670804b7160000', '日志管理-系统登录', '2018-11-12 21:03:05', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '173', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670be99a01670bea728d0000', '日志管理-系统登录', '2018-11-13 15:12:53', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '129', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670bf0ad01670bf103a80000', '日志管理-系统登录', '2018-11-13 15:20:03', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '185', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670c102301670c10917f0000', '日志管理-系统登录', '2018-11-13 15:54:31', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '128', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670c274001670c27a6010000', '日志管理-系统登录', '2018-11-13 16:19:44', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '229', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670c38ad01670c41b0910000', '日志管理-系统登录', '2018-11-13 16:48:10', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '218', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670c4d5e01670c4ea8770000', '日志管理-系统登录', '2018-11-13 17:02:20', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '125', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670c621601670c62e2950000', '日志管理-系统登录', '2018-11-13 17:24:26', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '131', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670c8d2001670c8da0150000', '日志管理-系统登录', '2018-11-13 18:11:07', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '136', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670c9b8401670c9be4050000', '日志管理-系统登录', '2018-11-13 18:26:42', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '130', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670caa5301670cabaa0f0000', '日志管理-系统登录', '2018-11-13 18:43:55', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '154', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670caa5301670cabb9380001', '日志管理-系统登录', '2018-11-13 18:43:59', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '8', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670cb43201670cb5ef7a0000', '日志管理-系统登录', '2018-11-13 18:55:08', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '197', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670ce3c301670ce42a720000', '日志管理-系统登录', '2018-11-13 19:45:38', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '139', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0670d105d01670d10b4910000', '日志管理-系统登录', '2018-11-13 20:34:17', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '174', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0671039790167103b1a3f0000', '日志管理-系统登录', '2018-11-14 11:19:27', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '335', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0671066c2016710672fcb0000', '日志管理-系统登录', '2018-11-14 12:07:36', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '131', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06714d7e8016714d847c00000', '日志管理-系统登录', '2018-11-15 08:49:37', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '139', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0671501b101671503d0120000', '日志管理-系统登录', '2018-11-15 09:37:10', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '166', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06716f717016716f7ca350000', '日志管理-系统登录', '2018-11-15 18:43:17', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '137', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0671a594001671a5a94c60000', '日志管理-系统登录', '2018-11-16 10:30:03', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '138', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0671bacd701671bad61170000', '日志管理-系统登录', '2018-11-16 16:40:06', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '156', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06752f614016752fb78fb0000', '日志管理-系统登录', '2018-11-27 10:24:31', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '149', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06753d24d0167540812f30000', '日志管理-系统登录', '2018-11-27 15:17:54', NULL, '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '15', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06753d24d016754081cdc0001', '日志管理-系统登录', '2018-11-27 15:17:57', NULL, '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06753d24d0167540ac2870002', '日志管理-系统登录', '2018-11-27 15:20:50', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '144', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06753d24d016754108c6c0003', '日志管理-系统登录', '2018-11-27 15:27:09', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06753d24d01675410a12f0004', '日志管理-系统登录', '2018-11-27 15:27:15', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06753d24d016754110b6d0005', '日志管理-系统登录', '2018-11-27 15:27:42', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '8', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06753d24d0167541ceaab0006', '日志管理-系统登录', '2018-11-27 15:40:40', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06753d24d01675424a1440007', '日志管理-系统登录', '2018-11-27 15:49:05', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067548f28016754976bb20000', '日志管理-系统登录', '2018-11-27 17:54:28', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '162', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06758544d01675854add00000', '日志管理-系统登录', '2018-11-28 11:20:03', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '151', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0675915ba01675916c1f30000', '日志管理-系统登录', '2018-11-28 14:52:02', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '125', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067593af20167593c40f10000', '日志管理-系统登录', '2018-11-28 15:32:59', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '272', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06759b37a016759b3f0a10000', '日志管理-系统登录', '2018-11-28 17:43:43', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '266', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06759c60f016759c691840000', '日志管理-系统登录', '2018-11-28 18:04:04', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '245', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06759c60f016759c69fe20001', '日志管理-系统登录', '2018-11-28 18:04:08', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '10', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0675a07e101675a0a00800000', '日志管理-系统登录', '2018-11-28 19:17:43', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '189', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067676e6f0167676f019b0000', '日志管理-系统登录', '2018-12-01 09:43:07', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '181', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067678df8016767cd2c830000', '日志管理-系统登录', '2018-12-01 11:25:58', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '204', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06767e094016767e1bba90000', '日志管理-系统登录', '2018-12-01 11:48:25', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '200', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06768716b01676871dc340000', '日志管理-系统登录', '2018-12-01 14:25:51', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '185', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06768838f016768ac56f10000', '日志管理-系统登录', '2018-12-01 15:29:43', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '177', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0676911690167691290ea0000', '日志管理-系统登录', '2018-12-01 17:21:23', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '271', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067691d280167691dff9b0000', '日志管理-系统登录', '2018-12-01 17:33:52', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '243', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06769228f01676922fc780000', '日志管理-系统登录', '2018-12-01 17:39:19', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '130', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06769432a0167694380ee0000', '日志管理-系统登录', '2018-12-01 18:14:50', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '140', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06769462f01676946839d0000', '日志管理-系统登录', '2018-12-01 18:18:08', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '134', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067694f0201676950a2940000', '日志管理-系统登录', '2018-12-01 18:29:11', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '234', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06771a603016771a7cfbe0000', '日志管理-系统登录', '2018-12-03 09:21:22', ' admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '96', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06771a8df016771a939d90000', '日志管理-系统登录', '2018-12-03 09:22:54', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '135', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06771a8df016771b272cf0001', '日志管理-系统登录', '2018-12-03 09:32:59', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '4', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06771e51d016771e731980000', '日志管理-系统登录', '2018-12-03 10:30:36', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '134', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0677204b20167720601580000', '日志管理-系统登录', '2018-12-03 11:04:15', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0677204b20167720630450001', '日志管理-系统登录', '2018-12-03 11:04:27', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '121', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0677232aa0167723311ec0000', '日志管理-系统登录', '2018-12-03 11:53:28', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '145', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06772f4b2016772f5147b0000', '日志管理-系统登录', '2018-12-03 15:25:23', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '165', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06776d645016776d78db20000', '日志管理-系统登录', '2018-12-04 09:31:37', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '162', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06776d645016776daab260002', '日志管理-系统登录', '2018-12-04 09:35:01', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06777004301677700953e0000', '日志管理-系统登录', '2018-12-04 10:16:26', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06777004301677700a52b0001', '日志管理-系统登录', '2018-12-04 10:16:30', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '107', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06777488c0167774ce1910000', '日志管理-系统登录', '2018-12-04 11:39:46', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '212', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06777f530016777f642df0000', '日志管理-系统登录', '2018-12-04 14:44:46', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '215', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06778178e01677817e3de0000', '日志管理-系统登录', '2018-12-04 15:21:30', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '168', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067781a080167781a68730000', '日志管理-系统登录', '2018-12-04 15:24:15', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '9', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067781a080167781a797a0001', '日志管理-系统登录', '2018-12-04 15:24:20', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '112', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067781f830167781fe47a0000', '日志管理-系统登录', '2018-12-04 15:30:15', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '180', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06778210d01677821b7e50000', '日志管理-系统登录', '2018-12-04 15:32:14', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '285', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0677823be016778240f6a0000', '日志管理-系统登录', '2018-12-04 15:34:48', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '132', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06778283a01677828c4f00000', '日志管理-系统登录', '2018-12-04 15:39:56', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '263', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067782e860167782ee8040000', '日志管理-系统登录', '2018-12-04 15:46:38', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '211', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06778308101677830d88a0000', '日志管理-系统登录', '2018-12-04 15:48:46', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '149', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0677868d10167786ae95f0000', '日志管理-系统登录', '2018-12-04 16:52:11', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '367', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067788d35016778b85ac90000', '日志管理-系统登录', '2018-12-04 18:16:46', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '569', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0677bfba901677bfc19bf0000', '日志管理-系统登录', '2018-12-05 09:29:38', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '248', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0677c329d01677c35a64c0000', '日志管理-系统登录', '2018-12-05 10:32:29', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '159', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0677c6cae01677c6d27bd0000', '日志管理-系统登录', '2018-12-05 11:33:07', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '170', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067975c2601679760b8c10000', '日志管理-系统登录', '2018-12-10 17:09:17', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '178', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0679b2dc401679b2fe3bb0000', '日志管理-系统登录', '2018-12-11 10:54:26', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '151', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0679b736c01679b73d0190000', '日志管理-系统登录', '2018-12-11 12:08:37', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '265', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0679b751e01679b7571570000', '日志管理-系统登录', '2018-12-11 12:10:24', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '187', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0679ba1c801679ba2e1080000', '日志管理-系统登录', '2018-12-11 13:00:01', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '219', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0679beaef01679beb51be0000', '日志管理-系统登录', '2018-12-11 14:19:09', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '267', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0679bf18d01679bf20e8d0000', '日志管理-系统登录', '2018-12-11 14:26:31', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '10', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0679bf18d01679bf22dd70001', '日志管理-系统登录', '2018-12-11 14:26:39', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '122', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0679bf74e01679bf7ad840000', '日志管理-系统登录', '2018-12-11 14:32:39', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '8', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0679bf74e01679bf7c0e80001', '日志管理-系统登录', '2018-12-11 14:32:44', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0679bf74e01679bf7d3170002', '日志管理-系统登录', '2018-12-11 14:32:49', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '125', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0679c6d4301679c6db08b0000', '日志管理-系统登录', '2018-12-11 16:41:33', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '186', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067a00adf0167a00c7a580000', '日志管理-系统登录', '2018-12-12 09:33:51', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '185', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067c578420167c578c5df0000', '日志管理-系统登录', '2018-12-19 15:58:05', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '147', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067ca49d70167ca4a64be0000', '日志管理-系统登录', '2018-12-20 14:25:31', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '242', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067cadde00167cade6e630000', '日志管理-系统登录', '2018-12-20 17:07:13', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '189', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067e30a600167e30aff230000', '日志管理-系统登录', '2018-12-25 09:46:47', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '152', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067e42a200167e42a9a9a0000', '日志管理-系统登录', '2018-12-25 15:00:56', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '209', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067e42c490167e42ca1d60000', '日志管理-系统登录', '2018-12-25 15:03:09', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '242', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067e42fe90167e43487120000', '日志管理-系统登录', '2018-12-25 15:11:46', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '217', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067e832120167e832881e0000', '日志管理-系统登录', '2018-12-26 09:48:04', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067e832120167e8329d380001', '日志管理-系统登录', '2018-12-26 09:48:10', 'admin', '0:0:0:0:0:0:0:1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '267', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa067e832120167e832ad6c0002', '日志管理-系统登录', '2018-12-26 09:48:14', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '121', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06811bc63016811bcfa9e0000', '日志管理-系统登录', '2019-01-03 11:23:43', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '328', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa06811c32b016811c42fa60000', '日志管理-系统登录', '2019-01-03 11:31:36', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '194', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0681222420168122335ef0000', '日志管理-系统登录', '2019-01-03 13:15:23', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '275', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0681243ac016812440bfe0000', '日志管理-系统登录', '2019-01-03 13:51:15', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '231', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa068125d340168125dce300000', '日志管理-系统登录', '2019-01-03 14:19:23', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '157', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0681269ef0168126b84070000', '日志管理-系统登录', '2019-01-03 14:34:22', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '225', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa068126db90168126e129e0000', '日志管理-系统登录', '2019-01-03 14:37:09', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '202', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0682425a10168242852fc0000', '日志管理-系统登录', '2019-01-07 01:14:08', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '347', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa068242f7a01682431c3e30000', '日志管理-系统登录', '2019-01-07 01:24:27', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '461', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0683aa2c901683aace7c50000', '日志管理-系统登录', '2019-01-11 10:10:36', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '242', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0683ab01501683ab0a7510000', '日志管理-系统登录', '2019-01-11 10:14:41', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '231', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0683acd2f01683acd93b40000', '日志管理-系统登录', '2019-01-11 10:46:17', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '223', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0683ad7c101683ad85b230000', '日志管理-系统登录', '2019-01-11 10:58:03', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '220', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289fa0683aeabd01683aeb2edf0000', '日志管理-系统登录', '2019-01-11 11:18:37', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '498', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667ee87d01667ef3d1050001', '日志管理-系统登录', '2018-10-17 06:16:39', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '13', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f0bd401667f0c221b0000', '日志管理-系统登录', '2018-10-17 06:43:13', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '140', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f10f901667f11412a0000', '日志管理-系统登录', '2018-10-17 06:48:49', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '139', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f1ad901667f1b61730000', '日志管理-系统登录', '2018-10-17 06:59:52', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '137', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f39f901667f3a5c320000', '日志管理-系统登录', '2018-10-17 07:33:42', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '251', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f42b601667f4319e00000', '日志管理-系统登录', '2018-10-17 07:43:15', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '289', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f450401667f4569980000', '日志管理-系统登录', '2018-10-17 07:45:47', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '182', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f4bda01667f4dd9c40000', '日志管理-系统登录', '2018-10-17 07:55:00', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '47', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f4ebe01667f4f1fa90000', '日志管理-系统登录', '2018-10-17 07:56:23', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '145', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f556901667f55c6100000', '日志管理-系统登录', '2018-10-17 08:03:39', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '152', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f597d01667f59d7890000', '日志管理-系统登录', '2018-10-17 08:08:06', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '250', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f625a01667f62bdc10000', '日志管理-系统登录', '2018-10-17 08:17:49', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '59', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f6aad01667f6b3f980000', '日志管理-系统登录', '2018-10-17 08:27:06', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '137', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f828d01667f82ebe60000', '日志管理-系统登录', '2018-10-17 08:52:58', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '154', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f8c1001667f8c7b200000', '日志管理-系统登录', '2018-10-17 09:03:24', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '158', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f98b301667f9909220000', '日志管理-系统登录', '2018-10-17 09:17:07', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '178', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667f9cee01667f9d575c0000', '日志管理-系统登录', '2018-10-17 09:21:49', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '154', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667fa06701667fa26cb10000', '日志管理-系统登录', '2018-10-17 09:27:22', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '175', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667fa8b401667fa8fa670000', '日志管理-系统登录', '2018-10-17 09:34:32', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '130', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667fb33b01667fb420fc0000', '日志管理-系统登录', '2018-10-17 09:46:43', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '251', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667fc57801667fc5db8e0000', '日志管理-系统登录', '2018-10-17 10:06:05', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '135', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7667fc578016680266c490001', '日志管理-系统登录', '2018-10-17 11:51:33', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '10', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff76680311e01668031727d0000', '日志管理-系统登录', '2018-10-17 12:03:35', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '178', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff76680426d01668042a9350000', '日志管理-系统登录', '2018-10-17 12:22:24', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '121', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff76685188201668518eb3b0000', '日志管理-系统登录', '2018-10-18 10:54:54', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '143', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668530b20166853132450000', '日志管理-系统登录', '2018-10-18 11:21:25', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '168', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668a237701668a25601a0000', '日志管理-系统登录', '2018-10-19 10:26:37', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '111', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668a337d01668a33d79e0000', '日志管理-系统登录', '2018-10-19 10:42:25', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '140', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668a36f301668a3882790000', '日志管理-系统登录', '2018-10-19 10:47:31', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '96', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668a574101668a57f4cd0000', '日志管理-系统登录', '2018-10-19 11:21:51', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '132', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668a730a01668a7348d40000', '日志管理-系统登录', '2018-10-19 11:51:42', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '102', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668a8b4301668a8ba7e00000', '日志管理-系统登录', '2018-10-19 12:18:20', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '127', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668a980401668a9a7f630000', '日志管理-系统登录', '2018-10-19 12:34:32', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '145', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668a9f9901668aa016770000', '日志管理-系统登录', '2018-10-19 12:40:39', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '102', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668aa78b01668aa7d07d0000', '日志管理-系统登录', '2018-10-19 12:49:05', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '147', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668aac0101668aaf21780000', '日志管理-系统登录', '2018-10-19 12:57:05', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '118', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668acaf501668acbe4170000', '日志管理-系统登录', '2018-10-19 13:28:29', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '162', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668ace5801668ace986a0000', '日志管理-系统登录', '2018-10-19 13:31:27', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '124', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668ad09901668ad12c950000', '日志管理-系统登录', '2018-10-19 13:34:16', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '122', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668ad32001668ad363af0000', '日志管理-系统登录', '2018-10-19 13:36:41', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '188', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff7668ad85701668ad8bede0000', '日志管理-系统登录', '2018-10-19 13:42:32', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '119', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766a4892b0166a4898d070000', '日志管理-系统登录', '2018-10-24 13:26:09', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '159', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766a500f80166a502b82e0000', '日志管理-系统登录', '2018-10-24 15:38:30', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '190', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766a5f02c0166a5f0a6440000', '日志管理-系统登录', '2018-10-24 19:58:23', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '130', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766a5f0e80166a5f121f20000', '日志管理-系统登录', '2018-10-24 19:58:55', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '158', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766a8e1ff0166a8e266570000', '日志管理-系统登录', '2018-10-25 09:41:41', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '123', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766a9cbd40166a9cc68080000', '日志管理-系统登录', '2018-10-25 13:57:17', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '139', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766a9f9ec0166a9fb8bdf0000', '日志管理-系统登录', '2018-10-25 14:48:46', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '142', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766a9ffc50166aa001fb80000', '日志管理-系统登录', '2018-10-25 14:53:46', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '175', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766aa068c0166aa06c6d70000', '日志管理-系统登录', '2018-10-25 15:01:02', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '137', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766aa0a190166aa0a65af0000', '日志管理-系统登录', '2018-10-25 15:04:59', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '182', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766aa364f0166aa3686a10000', '日志管理-系统登录', '2018-10-25 15:53:11', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '286', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766aa44e50166aa453d490000', '日志管理-系统登录', '2018-10-25 16:09:16', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '133', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766aa46830166aa46f2270000', '日志管理-系统登录', '2018-10-25 16:11:07', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '193', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766aa55a80166aa55e4880000', '日志管理-系统登录', '2018-10-25 16:27:27', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '162', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766aa753e0166aa7633310000', '日志管理-系统登录', '2018-10-25 17:02:44', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '196', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766ae022d0166ae0273940000', '日志管理-系统登录', '2018-10-26 09:34:48', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '123', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766af025e0166af02989a0000', '日志管理-系统登录', '2018-10-26 14:14:34', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '167', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766af04060166af06eddd0000', '日志管理-系统登录', '2018-10-26 14:19:18', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '119', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766af28b60166af28fcb10000', '日志管理-系统登录', '2018-10-26 14:56:30', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '205', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766af4da80166af5171320000', '日志管理-系统登录', '2018-10-26 15:40:42', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '132', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766af5efd0166af5f35ad0000', '日志管理-系统登录', '2018-10-26 15:55:44', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '137', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766af6e2d0166af6e64e50000', '日志管理-系统登录', '2018-10-26 16:12:19', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '119', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766af8d3b0166af8d80f60000', '日志管理-系统登录', '2018-10-26 16:46:18', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '131', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766af97010166af9744cc0000', '日志管理-系统登录', '2018-10-26 16:56:58', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '214', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c8916f0166c891c86b0000', '日志管理-系统登录', '2018-10-31 13:21:29', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '122', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c8916f0166c891f7660001', '日志管理-系统登录', '2018-10-31 13:21:41', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '12', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c8b4f50166c8b528980000', '日志管理-系统登录', '2018-10-31 14:00:07', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '145', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c8b8010166c8b854d50000', '日志管理-系统登录', '2018-10-31 14:03:35', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '119', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c8bfab0166c8bffb740000', '日志管理-系统登录', '2018-10-31 14:11:56', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '120', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c8c22d0166c8c2a40f0000', '日志管理-系统登录', '2018-10-31 14:14:50', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '118', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c8de310166c8e12ddc0000', '日志管理-系统登录', '2018-10-31 14:48:12', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '142', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c8f38a0166c8f3c3ab0000', '日志管理-系统登录', '2018-10-31 15:08:30', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '106', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c8f6290166c8f6914d0000', '日志管理-系统登录', '2018-10-31 15:11:34', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '111', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c8f8390166c8f880190000', '日志管理-系统登录', '2018-10-31 15:13:40', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '134', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c8fba80166c8fc74370000', '日志管理-系统登录', '2018-10-31 15:17:59', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '126', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c8fd220166c8ff20a30000', '日志管理-系统登录', '2018-10-31 15:20:55', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '147', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c945b50166c9477dac0000', '日志管理-系统登录', '2018-10-31 16:39:57', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '34', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c9482f0166c948612e0000', '日志管理-系统登录', '2018-10-31 16:40:55', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '154', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c949470166c949a5630000', '日志管理-系统登录', '2018-10-31 16:42:18', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '132', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c94bb50166c94c06870000', '日志管理-系统登录', '2018-10-31 16:44:54', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '163', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c960a40166c960f6940000', '日志管理-系统登录', '2018-10-31 17:07:46', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '142', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c962a90166c962ea5b0000', '日志管理-系统登录', '2018-10-31 17:09:54', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '192', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766c97f6f0166c98105930000', '日志管理-系统登录', '2018-10-31 17:42:47', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '239', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766ccd0660166ccd0f14a0000', '日志管理-系统登录', '2018-11-01 09:08:57', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '124', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766ccd66e0166ccd6ed5f0000', '日志管理-系统登录', '2018-11-01 09:15:29', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '163', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766ccf2690166ccf2b2780000', '日志管理-系统登录', '2018-11-01 09:45:49', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '130', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766ccfc490166ccfca2090000', '日志管理-系统登录', '2018-11-01 09:56:40', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '118', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766cd06b00166cd06ef910000', '日志管理-系统登录', '2018-11-01 10:07:55', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '136', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766cd0e9c0166cd0ede150000', '日志管理-系统登录', '2018-11-01 10:16:35', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '132', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766cd25f20166cd26785f0000', '日志管理-系统登录', '2018-11-01 10:42:22', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '119', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766cd4f440166cd4f77a30000', '日志管理-系统登录', '2018-11-01 11:27:09', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '101', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766cd51770166cd51ad740000', '日志管理-系统登录', '2018-11-01 11:29:33', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '149', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766cd63fd0166cd644e4a0000', '日志管理-系统登录', '2018-11-01 11:49:54', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '117', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766cd6d500166cd6d8d4e0000', '日志管理-系统登录', '2018-11-01 12:00:00', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '199', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766cd7c560166cd7c93900000', '日志管理-系统登录', '2018-11-01 12:16:25', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '130', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766cd82e50166cd8368fb0000', '日志管理-系统登录', '2018-11-01 12:23:53', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '155', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766cdee820166cdef057f0000', '日志管理-系统登录', '2018-11-01 14:21:25', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '125', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766ce00b50166ce26fb060000', '日志管理-系统登录', '2018-11-01 15:22:32', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '114', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766d211b00166d2120e040000', '日志管理-系统登录', '2018-11-02 09:38:10', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '141', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766d211b00166d2e7d8b90032', '日志管理-系统登录', '2018-11-02 13:31:41', 'X0009', '127.0.0.1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '22', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766d211b00166d2ea1b020033', '日志管理-系统登录', '2018-11-02 13:34:09', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '26', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766d211b00166d2ebbbc80035', '日志管理-系统登录', '2018-11-02 13:35:56', 'X0009', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '23', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766d211b00166d2ec06cc0036', '日志管理-系统登录', '2018-11-02 13:36:15', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766d211b00166d2ec791f0037', '日志管理-系统登录', '2018-11-02 13:36:44', 'X0009', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '17', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766d2efd20166d2f02aea0000', '日志管理-系统登录', '2018-11-02 13:40:46', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '207', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766d2efd20166d2f09fa80001', '日志管理-系统登录', '2018-11-02 13:41:16', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '8', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766d2efd20166d2f0e7c60002', '日志管理-系统登录', '2018-11-02 13:41:35', 'X0009', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766d2efd20166d30981220003', '日志管理-系统登录', '2018-11-02 14:08:27', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766d2efd20166d335aa640004', '日志管理-系统登录', '2018-11-02 14:56:41', 'X0009', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766d342ac0166d342f7570000', '日志管理-系统登录', '2018-11-02 15:11:13', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '112', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766d342ac0166d34331630001', '日志管理-系统登录', '2018-11-02 15:11:28', 'X0009', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '8', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff766d3450a0166d345d3c40000', '日志管理-系统登录', '2018-11-02 15:14:20', 'X0009', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '159', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767c602cc0167c60387450000', '日志管理-系统登录', '2018-12-19 18:29:39', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '157', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767c6c60c0167c6c692350000', '日志管理-系统登录', '2018-12-19 22:02:41', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '188', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767c92fb30167c9302b850000', '日志管理-系统登录', '2018-12-20 09:17:16', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '120', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767c97bde0167c97c52c20000', '日志管理-系统登录', '2018-12-20 10:40:27', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '119', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767c97f290167c97f75300000', '日志管理-系统登录', '2018-12-20 10:43:52', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '160', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767c987610167c9879b000000', '日志管理-系统登录', '2018-12-20 10:52:46', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '126', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767c98a400167c98dcc9c0000', '日志管理-系统登录', '2018-12-20 10:59:32', 'admin', '127.0.0.1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '4', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767c98a400167c98debca0001', '日志管理-系统登录', '2018-12-20 10:59:40', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '69', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767c98f230167c98f63910000', '日志管理-系统登录', '2018-12-20 11:01:16', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '99', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767c99bda0167c99c14bc0000', '日志管理-系统登录', '2018-12-20 11:15:08', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '136', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767c99e930167c99ed5800000', '日志管理-系统登录', '2018-12-20 11:18:08', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '150', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767c99fdb0167c9a01ab40000', '日志管理-系统登录', '2018-12-20 11:19:32', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '105', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767ca538d0167ca54771d0000', '日志管理-系统登录', '2018-12-20 14:36:32', 'admin', '127.0.0.1', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '6', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767ca538d0167ca54913b0001', '日志管理-系统登录', '2018-12-20 14:36:39', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '61', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767cab7110167cab765c30000', '日志管理-系统登录', '2018-12-20 16:24:35', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '117', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767cad2880167cad2bcd10000', '日志管理-系统登录', '2018-12-20 16:54:27', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '132', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767cb01e40167cb0227430000', '日志管理-系统登录', '2018-12-20 17:46:15', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '99', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767cb0f050167cb0f4ab80000', '日志管理-系统登录', '2018-12-20 18:00:36', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '122', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767cb53180167cb5405660000', '日志管理-系统登录', '2018-12-20 19:15:40', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '120', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767cb71930167cb71e7670000', '日志管理-系统登录', '2018-12-20 19:48:18', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '96', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767ce4f660167ce5225fd0000', '日志管理-系统登录', '2018-12-21 09:12:29', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '158', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767ce923a0167ce927d8f0000', '日志管理-系统登录', '2018-12-21 10:22:46', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '117', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767cf71a20167cf71ef210000', '日志管理-系统登录', '2018-12-21 14:26:49', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '109', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767cfb3c70167cfb41d730000', '日志管理-系统登录', '2018-12-21 15:39:06', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '109', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767cfe3660167cfe3d0550000', '日志管理-系统登录', '2018-12-21 16:31:12', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '176', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767df49390167df585b4f0000', '日志管理-系统登录', '2018-12-24 16:32:48', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '171', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767df679e0167df681b3e0000', '日志管理-系统登录', '2018-12-24 16:50:00', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '169', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767df73720167df73ca810000', '日志管理-系统登录', '2018-12-24 17:02:46', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '148', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767e2eda80167e2ee28a00000', '日志管理-系统登录', '2018-12-25 09:15:17', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '163', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767e36be40167e36c1b3a0000', '日志管理-系统登录', '2018-12-25 11:32:52', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '123', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767e380a70167e38241ab0000', '日志管理-系统登录', '2018-12-25 11:57:03', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '172', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767e46c050167e46c53880000', '日志管理-系统登录', '2018-12-25 16:12:43', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '136', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767e46f600167e46fcfdb0000', '日志管理-系统登录', '2018-12-25 16:16:32', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '177', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767e4736e0167e473c4800000', '日志管理-系统登录', '2018-12-25 16:20:51', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '170', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767e475df0167e47648ff0000', '日志管理-系统登录', '2018-12-25 16:23:36', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '199', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('40289ff767e47b620167e47b9bae0000', '日志管理-系统登录', '2018-12-25 16:29:25', 'admin', '127.0.0.1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '181', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('5308dbc4569c492eb7f82ec8242a658d', '移动端系统登录', '2018-12-31 15:24:35', 'Admin', '122.234.223.205', '执行成功', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('6f886350b2ba4dba8ed38e6d7dff9a84', '移动端系统登录', '2018-12-24 16:29:52', 'zy', '125.120.172.104', '执行失败', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('78dda974a3c74e79a524d56f39d29da1', '移动端系统登录', '2018-12-24 16:29:47', 'zy', '125.120.172.104', '执行失败', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('89fc5ae9c6a146338746be01e8075dfc', '移动端系统登录', '2018-12-31 15:38:14', 'admin', '122.234.223.205', '执行成功', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('a5de90aa07b848858a0dab4a8eb9f2bb', '移动端系统登录', '2018-12-31 14:58:46', 'admin', '122.234.223.205', '执行成功', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('baf72e56cdda46ad8e2e505b0fc1574f', '移动端系统登录', '2018-12-31 15:24:18', '145', '122.234.223.205', '执行失败', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('eef6218462d14c478a9529ab5991e1fd', '移动端系统登录', '2018-12-31 15:35:02', 'Admin', '122.234.223.205', '执行成功', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('f7dd90cd3fe446169898583c6c1cd9a4', '移动端系统登录', '2018-12-24 16:29:58', 'zy', '125.120.172.104', '执行失败', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167656bec0167657f38300000', '日志管理-系统登录', '2018-12-01 00:41:35', 'admin', '0:0:0:0:0:0:0:1', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '439', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167de1a9d0167de1ae0ab0000', '日志管理-系统登录', '2018-12-24 10:46:02', 'admin', '42.92.191.29', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '85', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167de1a9d0167dee1d1090001', '日志管理-系统登录', '2018-12-24 14:23:20', 'admin', '42.92.191.29', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167de1a9d0167defb52540002', '日志管理-系统登录', '2018-12-24 14:51:11', 'admin', '42.92.191.29', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167de1a9d0167df4af87c0046', '日志管理-系统登录', '2018-12-24 16:18:11', 'admin', '42.92.191.29', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167de1a9d0167df4b21400047', '日志管理-系统登录', '2018-12-24 16:18:22', 'admin', '42.92.191.29', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e482a20167e482fe830000', '日志管理-系统登录', '2018-12-25 16:37:29', 'admin', '42.92.191.101', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '99', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e482a20167e483c3aa0001', '日志管理-系统登录', '2018-12-25 16:38:19', 'admin', '42.92.191.101', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '4', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e491590167e49245f70000', '日志管理-系统登录', '2018-12-25 16:54:10', 'admin', '42.92.191.101', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '141', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e494ab0167e49583ef0000', '日志管理-系统登录', '2018-12-25 16:57:43', 'admin', '42.92.191.101', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '90', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e494ab0167e4b73dc70001', '日志管理-系统登录', '2018-12-25 17:34:33', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '16', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e494ab0167e4b75de50002', '日志管理-系统登录', '2018-12-25 17:34:41', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '20', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e494ab0167e4b773a00003', '日志管理-系统登录', '2018-12-25 17:34:47', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '13', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e494ab0167e80d1c070004', '日志管理-系统登录', '2018-12-26 09:07:12', 'admin', '42.92.178.107', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '14', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e494ab0167e80dc0560005', '日志管理-系统登录', '2018-12-26 09:07:54', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '4', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e494ab0167e80e1cfd0006', '日志管理-系统登录', '2018-12-26 09:08:18', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e494ab0167e80e30800007', '日志管理-系统登录', '2018-12-26 09:08:23', 'admin', '42.92.178.107', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e494ab0167e81ff2c80008', '日志管理-系统登录', '2018-12-26 09:27:47', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e494ab0167e82f6de0000b', '日志管理-系统登录', '2018-12-26 09:44:41', 'admin', '42.92.178.107', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e494ab0167e89d0f63000c', '日志管理-系统登录', '2018-12-26 11:44:26', 'admin', '42.92.178.107', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e998480167e99888450000', '日志管理-系统登录', '2018-12-26 16:19:06', 'admin', '42.92.178.107', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '103', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e998480167e9af2be20003', '日志管理-系统登录', '2018-12-26 16:43:50', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167e9b5d3d10000', '日志管理-系统登录', '2018-12-26 16:51:06', 'admin', '42.92.178.107', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '113', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167e9b692f10001', '日志管理-系统登录', '2018-12-26 16:51:55', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167ed2ce8320006', '日志管理-系统登录', '2018-12-27 09:00:02', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '11', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167ed33994f0008', '日志管理-系统登录', '2018-12-27 09:07:21', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167ed33c37b0009', '日志管理-系统登录', '2018-12-27 09:07:31', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167ed33d62a000a', '日志管理-系统登录', '2018-12-27 09:07:36', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167ed369c18000c', '日志管理-系统登录', '2018-12-27 09:10:38', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167ed36b609000d', '日志管理-系统登录', '2018-12-27 09:10:44', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167ed36e643000e', '日志管理-系统登录', '2018-12-27 09:10:57', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167eeb71a6a0140', '日志管理-系统登录', '2018-12-27 16:10:36', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167f2727c6b016b', '日志管理-系统登录', '2018-12-28 09:34:08', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167f2729536016c', '日志管理-系统登录', '2018-12-28 09:34:14', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167f273eceb016f', '日志管理-系统登录', '2018-12-28 09:35:42', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167f2816bdb0187', '日志管理-系统登录', '2018-12-28 09:50:27', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167f2fa1c8301de', '日志管理-系统登录', '2018-12-28 12:02:16', 'admin', '42.92.181.84', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167e9b59b0167f48af1bd0250', '日志管理-系统登录', '2018-12-28 19:20:05', 'admin', '101.66.229.7', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab900167f7af395b0000', '日志管理-系统登录', '2018-12-29 09:58:34', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '366', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab900167f7b401f50002', '日志管理-系统登录', '2018-12-29 10:03:48', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab900167f7c782410015', '日志管理-系统登录', '2018-12-29 10:25:06', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab900167f7e0418d0034', '日志管理-系统登录', '2018-12-29 10:52:08', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab900167f7e961310041', '日志管理-系统登录', '2018-12-29 11:02:06', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab900167f8a86be8009a', '日志管理-系统登录', '2018-12-29 14:30:46', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab900167fd1b42df017a', '日志管理-系统登录', '2019-12-30 11:14:41', 'admin', '111.121.76.208', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab900167fd1b5e5a017b', '日志管理-系统登录', '2019-12-30 11:14:48', 'admin', '111.121.76.208', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '3', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab900167fd39df02017c', '日志管理-系统登录', '2019-12-30 11:48:07', 'admin', '111.121.76.208', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab900167fd39f82f017d', '日志管理-系统登录', '2019-12-30 11:48:13', 'admin', '111.121.76.208', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab900167fd3a1ba6017e', '日志管理-系统登录', '2019-12-30 11:48:23', 'admin', '111.121.76.208', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab900167fee14a05017f', '日志管理-系统登录', '2019-12-30 19:30:36', 'admin', '1.204.113.205', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab900168026d224d0180', '日志管理-系统登录', '2019-12-31 12:02:13', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '9', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680850e49b0181', '日志管理-系统登录', '2019-01-01 15:29:05', 'admin', '125.75.19.178', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '35', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680bf877b20182', '日志管理-系统登录', '2019-01-02 08:30:59', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '7', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680c3358810183', '日志管理-系统登录', '2019-01-02 09:35:18', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '0', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680c34a47e0184', '日志管理-系统登录', '2019-01-02 09:36:43', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680c3971870185', '日志管理-系统登录', '2019-01-02 09:41:57', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680c3f70650186', '日志管理-系统登录', '2019-01-02 09:48:30', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680c464aa7018a', '日志管理-系统登录', '2019-01-02 09:55:59', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680c56863201ab', '日志管理-系统登录', '2019-01-02 10:13:43', 'admin', '42.92.181.84', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680c92319b0217', '日志管理-系统登录', '2019-01-02 11:18:54', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680cbcb83102c7', '日志管理-系统登录', '2019-01-02 12:05:21', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680d2a6deb02c8', '日志管理-系统登录', '2019-01-02 14:05:11', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680d5ceb1002c9', '日志管理-系统登录', '2019-01-02 15:00:19', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680de3a78302ca', '日志管理-系统登录', '2019-01-02 17:27:29', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680de3d65f02cb', '日志管理-系统登录', '2019-01-02 17:27:41', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001680decb6fe02cc', '日志管理-系统登录', '2019-01-02 17:37:23', 'admin', '42.92.181.84', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001681138591e02cd', '日志管理-系统登录', '2019-01-03 08:58:52', 'admin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '12', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001681138791f02ce', '日志管理-系统登录', '2019-01-03 08:59:00', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab90016811619bf502cf', '日志管理-系统登录', '2019-01-03 09:43:56', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001681166680702d0', '日志管理-系统登录', '2019-01-03 09:49:10', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001681170c96c02d1', '日志管理-系统登录', '2019-01-03 10:00:30', 'aimin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '5', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001681170d1d002d2', '日志管理-系统登录', '2019-01-03 10:00:32', 'aimin', '222.85.133.251', '执行失败！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab9001681170eac002d3', '日志管理-系统登录', '2019-01-03 10:00:39', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab90016811879a6102d4', '日志管理-系统登录', '2019-01-03 10:25:26', 'admin', '222.85.147.87', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab900168119c8d8c02d5', '日志管理-系统登录', '2019-01-03 10:48:19', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_log` VALUES ('ff80808167f7ab90016811a99dfb02d6', '日志管理-系统登录', '2019-01-03 11:02:35', 'admin', '222.85.133.251', '执行成功！', '系统管理', NULL, NULL, NULL, NULL, NULL, '2', NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `createtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createuser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `permission` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `priority` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `updatetime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `updateuser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_iframe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `p_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`menuid`) USING BTREE,
  INDEX `FK_4mryse4we16s40fdeff06fkrl`(`pid`) USING BTREE,
  CONSTRAINT `FK_4mryse4we16s40fdeff06fkrl` FOREIGN KEY (`pid`) REFERENCES `sys_menu` (`menuid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('0', '2018-01-01', NULL, '顶级', NULL, NULL, '顶级菜单', '1', '1', NULL, NULL, NULL, NULL, 'layui-icon-home', NULL, NULL);
INSERT INTO `sys_menu` VALUES ('0000000065a25e0f0165a7b5789d000e', '2018-09-05 11:10:12', 'admin', '文档管理', '', '5', '', '1', '1', NULL, NULL, '', '0', 'layui-icon-form', '1', NULL);
INSERT INTO `sys_menu` VALUES ('05d404cdad0d11e88bc100e04c1a78e0', '2018-09-03 13:22:46', NULL, '员工信息维护', 'sysUser:pageList', NULL, '对员工的个人属性信息、所属部门信息、岗位信息进行维护，建立员工信息档案，可以根据部门、岗位等信息快速检索员工详细信息', '1', '1', '2018-09-02 20:54:43', 'admin', 'route/manage/sys/sys_userList', '793b80e9ad0c11e88bc100e04c1a78e0', 'layui-icon-user', '0', NULL);
INSERT INTO `sys_menu` VALUES ('2a90ff16ad0d11e88bc100e04c1a78e0', '2018-09-03 13:22:45', NULL, '岗位信息设置', 'sysProfession:pageList', '1', '设置工种信息，对生产现场的操作人员按工作分类管理。可能会出现一人操作不同工序设备的情况，需要可以灵活配置', '1', '1', '2018-09-19 10:00:41', 'admin', 'route/manage/sys/sys_professionList', '793b80e9ad0c11e88bc100e04c1a78e0', 'layui-icon-star-fill', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880a265d1ab790165d1db5c100003', '2018-09-13 15:35:38', 'admin', '子级查看', 'sysParam:sonParam', '4', '用于在系统参数列表查看子级参数列表的按钮', '1', '0', NULL, NULL, '', '40289fa065ace0960165acf42ff10001', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880a265d7073f0165d73565ea0008', '2018-09-14 16:32:05', 'admin', '文件上传', 'fileManage:importFile', '1', '文件上传按钮', '1', '0', NULL, NULL, '', '40289fa065b20b0c0165b23f1ea20013', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880a265d7073f0165d73b07de0009', '2018-09-14 16:38:14', 'admin', '文件锁定', 'fileManage:lockFile', '2', '文件锁定按钮', '1', '0', NULL, NULL, '', '40289fa065b20b0c0165b23f1ea20013', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880a265d7073f0165d73b7492000a', '2018-09-14 16:38:42', 'admin', '文件解锁', 'fileManage:unLockFile', '3', '文件解锁按钮', '1', '0', NULL, NULL, '', '40289fa065b20b0c0165b23f1ea20013', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880a265d7073f0165d73bd6f8000b', '2018-09-14 16:39:07', 'admin', '文件失效', 'fileManage:loseFile', '4', '文件失效按钮', '1', '0', NULL, NULL, '', '40289fa065b20b0c0165b23f1ea20013', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880a265d7073f0165d73c32a1000c', '2018-09-14 16:39:31', 'admin', '文件恢复', 'fileManage:recoverFile', '5', '文件恢复按钮', '1', '0', NULL, NULL, '', '40289fa065b20b0c0165b23f1ea20013', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880a265d7073f0165d73c83ce000d', '2018-09-14 16:39:52', 'admin', '文件删除', 'fileManage:deleteFile', '6', '文件删除按钮', '1', '0', NULL, NULL, '', '40289fa065b20b0c0165b23f1ea20013', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880e860e5d5b40160e5dfee730003', '2018-01-11 23:39:06', 'admin', '新增', 'sysDept:saveDept', NULL, '', '1', '0', '2018-09-04 17:08:50', 'admin', 'sysDept/saveDept', '4a0a10c6ad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880e860f534020160f54e5dbc0000', '2018-01-14 23:34:01', 'admin', '修改密码', 'sysUser:updatePassword', NULL, '', '1', '0', '2018-09-04 17:10:51', 'admin', '', '05d404cdad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e13d840160e13dd5970000', '2018-01-11 02:03:34', NULL, '系统设置', '', '8', '', '1', '1', '2018-09-05 17:17:22', 'admin', '', '0', 'layui-icon-set-sm', '1', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e13d840160e14269650003', '2018-01-11 02:08:34', NULL, '新增', 'sysUser:saveUser', '1', '', '1', '0', '2018-09-06 11:43:23', 'admin', 'sysUser/saveUser', '05d404cdad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e13d840160e1486800000a', '2018-01-11 02:15:06', NULL, '修改', 'sysUser:updateUser', NULL, '', '1', '0', '2018-09-04 17:00:59', 'admin', 'sysUser/updateUser', '05d404cdad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e152afec0000', '2018-01-11 02:26:20', NULL, '删除', 'sysUser:deleteUser', NULL, '', '1', '0', '2018-09-04 17:01:13', 'admin', 'sysUser/deleteUser', '05d404cdad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e15353ed0001', '2018-01-11 02:27:02', NULL, '详情', 'sysUser:detailUser', NULL, '', '1', '0', '2018-09-04 16:59:24', 'admin', 'sysUser/detailUser', '05d404cdad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e15431460002', '2018-01-11 02:27:59', NULL, '初始化密码', 'sysUser:initPassword', NULL, '', '1', '0', '2018-09-04 17:04:34', 'admin', 'sysUser/initPassword', '05d404cdad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e166900f000a', '2018-01-11 02:48:03', NULL, '修改', 'sysDept:updateDept', NULL, '', '1', '0', '2018-09-04 17:02:19', 'admin', 'sysDept/updateDept', '4a0a10c6ad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e167f912000c', '2018-01-11 02:49:35', NULL, '删除', 'sysDept:deleteDept', NULL, '', '1', '0', '2018-09-04 17:02:32', 'admin', 'sysDept/deleteDept', '4a0a10c6ad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e1691009000f', '2018-01-11 02:50:47', NULL, '详情', 'sysDept:detailDept', NULL, '', '1', '0', '2018-09-04 17:02:46', 'admin', 'sysDept/detailDept', '4a0a10c6ad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e17bb349001b', '2018-01-11 03:11:08', NULL, '新增', 'sysRole:saveRole', NULL, '', '1', '0', '2018-09-04 17:03:13', 'admin', 'sysRole/saveRole', '84bb87acad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e17cfddf001c', '2018-01-11 03:12:33', NULL, '修改', 'sysRole:updateRole', NULL, '', '1', '0', '2018-09-04 17:03:32', 'admin', 'sysRole/updateRole', '84bb87acad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e17d8d0e001d', '2018-01-11 03:13:09', NULL, '删除', 'sysRole:deleteRole', NULL, '', '1', '0', '2018-09-04 17:03:42', 'admin', 'sysRole/deleteRole', '84bb87acad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e17eba37001e', '2018-01-11 03:14:26', NULL, '详情', 'sysRole:detailRole', NULL, '', '1', '0', '2018-09-04 17:05:15', 'admin', 'sysRole/detailRole', '84bb87acad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e1802af0001f', '2018-01-11 03:16:01', NULL, '权限设置', 'sysRole:powerRole', NULL, '', '1', '0', '2018-09-04 17:05:37', 'admin', 'sysRole/powerRole', '84bb87acad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e1841c470021', '2018-01-11 03:20:19', NULL, '新增', 'sysMenu:saveMenu', NULL, '', '1', '0', '2018-09-04 17:07:35', 'admin', 'sysMenu/saveMenu', '8828132dad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e184dcb50022', '2018-01-11 03:21:09', NULL, '修改', 'sysMenu:updateMenu', NULL, '', '1', '0', '2018-09-04 17:07:48', 'admin', 'sysMenu/updateMenu', '8828132dad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e18561150023', '2018-01-11 03:21:42', NULL, '删除', 'sysMenu:deleteMenu', NULL, '', '1', '0', '2018-09-04 17:08:01', 'admin', 'sysMenu/deleteMenu', '8828132dad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('402880f760e14fc90160e18601b40024', '2018-01-11 03:22:24', NULL, '详情', 'sysMenu:detailMenu', NULL, '', '1', '0', '2018-09-04 17:08:15', 'admin', 'sysMenu/detailMenu', '8828132dad0d11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289f5b659ae04701659ae6ca5a0000', '2018-09-02 23:29:00', 'admin', '新增', 'sysProfession:saveProfession', NULL, '', '1', '0', NULL, NULL, 'sysProfession/saveProfession', '2a90ff16ad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289f5b659af09601659af6b96f0001', '2018-09-02 23:46:25', 'admin', '修改', 'sysProfession:updateProfession', NULL, '修改工种', '1', '0', NULL, NULL, 'sysProfession/updateProfession', '2a90ff16ad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289f5b659af09601659af785a90002', '2018-09-02 23:47:17', 'admin', '删除', 'sysProfession:deleteProfession', NULL, '删除工种', '1', '0', NULL, NULL, 'sysProfession/deleteProfession', '2a90ff16ad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289f5b659af09601659af8ed030003', '2018-09-02 23:48:49', 'admin', '详情', 'sysProfession:detailProfession', NULL, '工种详情', '1', '0', NULL, NULL, 'sysProfession/detailProfession', '2a90ff16ad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289f5b65ce006d0165ce0399950001', '2018-09-12 21:41:07', 'admin', '导出', 'sysUser:exportUser', '11', '员工信息导出按钮', '1', '0', NULL, NULL, '', '05d404cdad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289f5b65ce58250165ce5b68280001', '2018-09-12 23:17:01', 'admin', '导入', 'sysUser:importUser', '11', '导入用户数据按钮', '1', '0', NULL, NULL, '', '05d404cdad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289f5b667af16f01667bb432b70001', '2018-10-16 15:08:18', 'admin', '邮件管理', 'email:emailPage', '10', '邮件管理菜单', '1', '1', NULL, NULL, 'email/emailPage', '402880f760e13d840160e13dd5970000', 'layui-icon-release', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa065ace0960165acf42ff10001', '2018-09-06 11:36:48', 'admin', '系统参数管理', 'sysParam:pageList', '4', '系统参数配置管理', '1', '1', '2018-09-06 11:39:17', 'admin', 'route/manage/sys/sys_paramList', '402880f760e13d840160e13dd5970000', 'layui-icon-util', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa065ace0960165acf8d7960003', '2018-09-06 11:41:53', 'admin', '新增', 'sysParam:saveParam', '1', '系统参数新增', '1', '0', NULL, NULL, 'sysParam/saveParam', '40289fa065ace0960165acf42ff10001', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa065ace0960165acf9aedd0004', '2018-09-06 11:42:49', 'admin', '详情', 'sysParam:detailParam', '2', '系统参数详情', '1', '0', '2018-09-06 11:45:26', 'admin', 'sysParam/detailParam', '40289fa065ace0960165acf42ff10001', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa065ace0960165acfcb5280005', '2018-09-06 11:46:07', 'admin', '修改', 'sysParam:updateParam', '3', '系统参数修改', '1', '0', NULL, NULL, 'sysParam/updateParam', '40289fa065ace0960165acf42ff10001', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa065ace0960165acfdb17e0006', '2018-09-06 11:47:11', 'admin', '删除', 'sysParam:deleteParam', '4', '系统参数删除', '1', '0', NULL, NULL, 'sysParam/deleteParam', '40289fa065ace0960165acf42ff10001', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa065b20b0c0165b23ee0010012', '2018-09-07 12:16:29', 'admin', '文档目录', '', '1', '文档管理文档目录菜单', '1', '1', '2018-09-07 18:39:22', 'admin', 'route/manage/filemng/file_catalog_list', '0000000065a25e0f0165a7b5789d000e', 'layui-icon-file', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa065b20b0c0165b23f1ea20013', '2018-09-07 12:16:45', 'admin', '文档列表', 'fileManage:pageList', '2', '文档管理文档列表菜单', '1', '1', '2018-09-10 10:41:10', 'admin', 'fileManage/pageList', '0000000065a25e0f0165a7b5789d000e', 'layui-icon-list', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa065b20b0c0165b23f94ef0014', '2018-09-07 12:17:16', 'admin', '文档历史列表', 'fileManage:pageHisList', '3', '文档管理文档历史列表菜单', '1', '1', NULL, NULL, 'fileManage/pageHisList', '0000000065a25e0f0165a7b5789d000e', 'layui-icon-file-b', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa0667579a101667589accd0001', '2018-10-15 10:24:08', 'admin', '文档下载', 'fileManage:downFile', '7', '文档下载按钮', '1', '0', NULL, NULL, '', '40289fa065b20b0c0165b23f1ea20013', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa0667579a101667592856e0002', '2018-10-15 10:33:48', 'admin', '文件预览', 'fileManage:fileYl', '1', '文件历史列表文件预览按钮', '1', '0', NULL, NULL, '', '40289fa065b20b0c0165b23f94ef0014', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa0667d99a801667da81c8e0001', '2018-10-17 00:14:21', 'admin', '新增', 'sysGroup:saveGroup', '1', '班组新增', '1', '0', NULL, NULL, '', '4dc8ebdbad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa0667d99a801667da93d570002', '2018-10-17 00:15:35', 'admin', '修改', 'sysGroup:updateGroup', '2', '班组信息修改', '1', '0', NULL, NULL, '', '4dc8ebdbad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa0667d99a801667da9a4870003', '2018-10-17 00:16:01', 'admin', '详情', 'sysGroup:detailGroup', '3', '班组信息详情', '1', '0', NULL, NULL, '', '4dc8ebdbad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa0667d99a801667da9fb7d0004', '2018-10-17 00:16:23', 'admin', '删除', 'sysGroup:deleteGroup', '4', '班组信息删除', '1', '0', NULL, NULL, '', '4dc8ebdbad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa0667d99a801667daa941d0005', '2018-10-17 00:17:02', 'admin', '设备配置', 'sysGroup:cfgDevice', '5', '设备配置按钮', '1', '0', NULL, NULL, '', '4dc8ebdbad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa0667d99a801667dab1cec0006', '2018-10-17 00:17:38', 'admin', '配置人员', 'sysGroup:cfgUser', '6', '班组配置人员', '1', '0', NULL, NULL, '', '4dc8ebdbad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289fa066ae16e90166ae1925c00001', '2018-10-26 09:59:35', 'admin', '文件批量删除', 'fileManage:deletes', '8', '文件批量删除按钮', '1', '0', NULL, NULL, '', '40289fa065b20b0c0165b23f1ea20013', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289ff7659ad6a401659ae017b20000', '2018-09-02 23:21:42', 'admin', '新增', 'sysComp:saveComp', '1', '', '1', '0', '2018-09-18 20:46:55', 'admin', '', '4549901bad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289ff7659aee1401659af792a70001', '2018-09-02 23:47:20', 'admin', '修改', 'sysComp:updateComp', '1', '', '1', '0', '2018-09-18 20:46:43', 'admin', '', '4549901bad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289ff7659aee1401659af7f9670002', '2018-09-02 23:47:47', 'admin', '删除', 'sysComp:deleteComp', '0', '', '1', '0', '2018-09-18 20:46:30', 'admin', '', '4549901bad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289ff7659aee1401659af8a1c10003', '2018-09-02 23:48:30', 'admin', '详情', 'sysComp:detailComp', '0', '', '1', '0', '2018-09-18 20:46:12', 'admin', '', '4549901bad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289ff7659de05d01659de21e990000', '2018-09-03 13:22:46', 'admin', '组织', 'sysComp:orgComp', '0', '', '1', '0', '2018-09-18 20:43:47', 'admin', '${ctx}/sys/departmentTableList', '4549901bad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289ff766ae022d0166ae2002060002', '2018-10-26 10:07:05', 'admin', '顶部删除', 'sysUser:delUser', '2', '顶部删除按钮', '1', '0', NULL, NULL, '', '05d404cdad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289ff766af04060166af1208ea0001', '2018-10-26 14:31:26', 'admin', '顶部删除', 'sysDept:delDept', '2', '部门列表，顶部批量删除按钮', '1', '0', NULL, NULL, '', '4a0a10c6ad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289ff766af4da80166af5420890001', '2018-10-26 15:43:38', 'admin', '顶部删除', 'sysMenu:delMenu', '2', '顶部批量删除按钮', '1', '0', NULL, NULL, '', '8828132dad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('40289ff766af4da80166af5d230d0002', '2018-10-26 15:53:28', 'admin', '顶部删除', 'sysRole:delRole', '2', '顶部批量删除按钮', '1', '0', NULL, NULL, '', '84bb87acad0d11e88bc100e04c1a78e0', '', '0', NULL);
INSERT INTO `sys_menu` VALUES ('4549901bad0d11e88bc100e04c1a78e0', '2018-09-03 13:22:44', NULL, '公司信息设置', 'company:editCompany', '1', '公司基本信息', '1', '1', '2018-09-18 21:13:52', 'admin', 'company/editCompany', 'd21a5f17ad0c11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('4a0a10c6ad0d11e88bc100e04c1a78e0', '2018-09-03 13:22:45', NULL, '部门信息设置', 'sysDept:pageList', '2', '', '1', '1', '2018-09-02 20:50:49', 'admin', 'route/manage/sys/sys_deptList', 'd21a5f17ad0c11e88bc100e04c1a78e0', 'layui-icon-app', '0', NULL);
INSERT INTO `sys_menu` VALUES ('4dc8ebdbad0d11e88bc100e04c1a78e0', '2018-09-03 13:22:46', NULL, '班组信息设置', 'sysGroup:pageMain', '3', '', '1', '1', '2018-10-15 21:14:24', 'admin', 'sysGroup/main', 'd21a5f17ad0c11e88bc100e04c1a78e0', '0', '0', NULL);
INSERT INTO `sys_menu` VALUES ('793b80e9ad0c11e88bc100e04c1a78e0', NULL, NULL, '人员管理', '', '1', '', '1', '1', '2018-09-05 12:40:35', 'admin', '', '402880f760e13d840160e13dd5970000', 'layui-icon-group', '0', NULL);
INSERT INTO `sys_menu` VALUES ('84bb87acad0d11e88bc100e04c1a78e0', NULL, NULL, '角色管理', 'sysRole:pageList', '2', '', '1', '1', '2018-11-07 16:51:47', 'admin', 'route/manage/sys/sys_roleList', 'dfe7a481ad0c11e88bc100e04c1a78e0', 'layui-icon-tree', '0', NULL);
INSERT INTO `sys_menu` VALUES ('8828132dad0d11e88bc100e04c1a78e0', NULL, NULL, '菜单管理', 'sysMenu:pageList', '1', '所有菜单资源管理', '1', '1', '2018-11-07 16:51:32', 'admin', 'route/manage/sys/sys_menuList', 'dfe7a481ad0c11e88bc100e04c1a78e0', 'layui-icon-templeate-1', '0', NULL);
INSERT INTO `sys_menu` VALUES ('d21a5f17ad0c11e88bc100e04c1a78e0', NULL, NULL, '组织机构管理', '', '2', '机构组织菜单', '1', '1', '2018-09-02 20:42:03', 'admin', '', '402880f760e13d840160e13dd5970000', 'layui-icon-align-left', '0', NULL);
INSERT INTO `sys_menu` VALUES ('dfe7a481ad0c11e88bc100e04c1a78e0', NULL, NULL, '权限管理', NULL, '3', NULL, '1', '1', NULL, NULL, NULL, '402880f760e13d840160e13dd5970000', 'layui-icon-auz', NULL, NULL);
INSERT INTO `sys_menu` VALUES ('e92aec10ad0c11e88bc100e04c1a78e0', NULL, NULL, '日志管理', 'sysLog:pageList', '10', '日志管理菜单', '1', '1', '2018-10-14 13:17:28', 'admin', 'route/manage/sys/sys_logList', '402880f760e13d840160e13dd5970000', 'layui-icon-read', '0', NULL);

-- ----------------------------
-- Table structure for sys_param
-- ----------------------------
DROP TABLE IF EXISTS `sys_param`;
CREATE TABLE `sys_param`  (
  `param_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数主键',
  `param_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数编码',
  `param_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数名称',
  `order_num` int(40) NULL DEFAULT NULL COMMENT '排序序号',
  `parent_code` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数父级编码',
  `create_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改人',
  `update_time` varchar(19) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改时间',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据状态(1：有效；0无效)',
  PRIMARY KEY (`param_id`) USING BTREE,
  INDEX `param_code`(`param_code`) USING BTREE,
  INDEX `FK_forparamcode`(`parent_code`) USING BTREE,
  CONSTRAINT `FK_forparamcode` FOREIGN KEY (`parent_code`) REFERENCES `sys_param` (`param_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_param
-- ----------------------------
INSERT INTO `sys_param` VALUES ('0', '0', '顶级', 1, NULL, NULL, NULL, NULL, NULL, '1');
INSERT INTO `sys_param` VALUES ('40289fa065c691de0165c6aae1db0009', 'fileType', '文件类型', 4, '0', 'admin', '2018-09-11 11:26:52', 'admin', '2018-11-09 15:45:13', '1');
INSERT INTO `sys_param` VALUES ('40289fa065c691de0165c6ab90a9000a', 'wjlx1', '文件类型一', 1, '40289fa065c691de0165c6aae1db0009', 'admin', '2018-09-11 11:27:37', 'admin', '2018-11-09 15:43:29', '1');
INSERT INTO `sys_param` VALUES ('40289fa065c691de0165c6abc5e6000b', 'wjlx2', '文件类型2', 2, '40289fa065c691de0165c6aae1db0009', 'admin', '2018-09-11 11:27:50', 'admin', '2018-11-09 15:43:44', '1');
INSERT INTO `sys_param` VALUES ('40289fa06675c1ce016676b640f80002', 'yjtzlx', '邮件通知类型', 3, '0', 'admin', '2018-10-15 15:52:27', 'admin', '2018-12-03 15:35:31', '1');
INSERT INTO `sys_param` VALUES ('40289fa06675c1ce016676b981e30003', 'tzlx1', '通知类型一', 1, '40289fa06675c1ce016676b640f80002', 'admin', '2018-10-15 15:56:00', 'admin', '2018-11-09 15:42:00', '1');
INSERT INTO `sys_param` VALUES ('40289fa06675c1ce016676b9d30b0004', 'tzlx2', '通知类型二', 2, '40289fa06675c1ce016676b640f80002', 'admin', '2018-10-15 15:56:21', 'admin', '2018-11-09 15:42:17', '1');
INSERT INTO `sys_param` VALUES ('40289fa066947570016694812f160002', 'qtwj', '其他', 3, '40289fa065c691de0165c6aae1db0009', 'admin', '2018-10-21 10:43:06', '', '', '1');

-- ----------------------------
-- Table structure for sys_profession
-- ----------------------------
DROP TABLE IF EXISTS `sys_profession`;
CREATE TABLE `sys_profession`  (
  `id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '主键',
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `pid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上级组织',
  `dept_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门id',
  `dept_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属部门名称',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建日期',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `comp_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属公司',
  `comp_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属公司名称',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  CONSTRAINT `sys_profession_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `sys_profession` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '岗位表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_profession
-- ----------------------------
INSERT INTO `sys_profession` VALUES ('ff8080816610e22d016614650b22002c', '0001', '总经理', NULL, 'ff8080816610e22d01661463779b0029', '总经办', '', '2018-09-26 13:40:58', '1', NULL, NULL);
INSERT INTO `sys_profession` VALUES ('ff8080816610e22d01661468b1290030', '0005', '财务总监', NULL, 'ff8080816610e22d01661463779b0029', '总经办', '', '2018-09-26 13:44:57', '1', NULL, NULL);
INSERT INTO `sys_profession` VALUES ('ff8080816610e22d0166146969070031', '0003', '营销总监', 'ff8080816610e22d016614650b22002c', 'ff8080816610e22d01661463779b0029', '总经办', '', '2018-09-26 13:45:44', '1', NULL, NULL);
INSERT INTO `sys_profession` VALUES ('ff8080816610e22d0166146e66420033', '0002', '副总经理', 'ff8080816610e22d016614650b22002c', 'ff8080816610e22d01661463779b0029', '总经办', '', '2018-09-26 13:51:11', '1', NULL, NULL);
INSERT INTO `sys_profession` VALUES ('ff8080816610e22d01661470227c0034', '0006', '总经理助理兼制造部经理', 'ff8080816610e22d016614650b22002c', 'ff8080816610e22d01661463779b0029', '总经办', '', '2018-09-26 13:53:05', '1', NULL, NULL);
INSERT INTO `sys_profession` VALUES ('ff8080816610e22d0166147118850035', '0004', '研发总工程师', 'ff8080816610e22d016614650b22002c', 'ff8080816610e22d01661463779b0029', '总经办', '', '2018-09-26 13:54:08', '1', NULL, NULL);
INSERT INTO `sys_profession` VALUES ('ff8080816610e22d0166151b806b003e', '0017', '研发中心副主任', 'ff8080816610e22d0166147118850035', 'ff8080816610e22d016613ee110d0005', '研发中心', '', '2018-09-26 17:00:15', '1', NULL, NULL);
INSERT INTO `sys_profession` VALUES ('ff8080816610e22d01661528798c0045', '0024', '产品工程师', 'ff8080816610e22d0166147118850035', 'ff8080816610e22d016613ee110d0005', '研发中心', '', '2018-09-26 17:14:26', '1', NULL, NULL);
INSERT INTO `sys_profession` VALUES ('ff8080816610e22d0166152c6f080047', '0025', '助理技师', 'ff8080816610e22d01661528798c0045', 'ff8080816610e22d016613ee110d0005', '研发中心', '', '2018-09-26 17:18:45', '1', NULL, NULL);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `roleid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `createtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createuser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `updatetime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `updateuser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`roleid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('402880e860dc7bb70160dc7c6c2d0002', '2018-01-10 03:53:49', NULL, '管理员', '管理员', '2018-11-08 11:13:45', NULL);
INSERT INTO `sys_role` VALUES ('402880e860f555c20160f58478880001', '2018-01-15 00:33:07', NULL, '系统维护员', '系统维护员', '2018-11-08 10:58:54', NULL);
INSERT INTO `sys_role` VALUES ('402880e860f555c20160f584af0c0002', '2018-01-15 00:33:21', NULL, '软件开发工程师', '软件开发工程师', '2018-11-08 15:26:14', NULL);
INSERT INTO `sys_role` VALUES ('8a929c0c60dda9f10160ddaecae00006', '2018-01-10 09:28:28', NULL, '超级管理员', '超级管理员', '2019-01-11 10:26:37', NULL);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `userid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工号',
  `rolename` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `dept_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门id',
  `dept_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `prcdure` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工序',
  `post_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '岗位id',
  `post_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '岗位名称',
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `brithday` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '出生日期',
  `age` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '年龄',
  `education` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '学历',
  `major` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '专业',
  `graduate_school` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '毕业院校',
  `graduate_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '毕业时间',
  `is_student` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否实习学生',
  `edu_mode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '就读形式',
  `mar_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '婚姻状况',
  `fet_status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '生育情况',
  `minority` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名族',
  `idcardno` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号码',
  `domicile` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '户口所在地',
  `dmc_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '户别',
  `jobstatus` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工状态    在岗/离职状态',
  `is_regular` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '转正情况',
  `regular_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '转正日期',
  `phone_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `shoe_size` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '鞋码',
  `joindate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '入职日期',
  `signcontract_num` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同类型 合同签订次数',
  `contract_signing_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同起 劳动合同签订日期',
  `contract_expiration_date` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '合同止 劳动合同到期时间',
  `is_socialsecurity` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '社保 是否缴纳社保',
  `is_accumulationfund` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '公积金 是否缴纳公积金',
  `sos_remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '社保备注',
  `sos_jobdate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '社会工龄入职日期',
  `linkman` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '紧急联系人',
  `linkman_rtp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '关系 紧急联系人',
  `linkman_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '紧急联系人电话',
  `introducer` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '介绍人',
  `is_communist` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否党员',
  `is_member` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '政治面貌 是否团员',
  `leaving_reasons` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '离职原因',
  `leaving_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '离职时间',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户图片',
  `is_visual` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createuser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createtime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `updateuser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `updatetime` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `jobtitle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职称',
  `usercode` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `locked` tinyint(1) NULL DEFAULT NULL COMMENT '是否锁定',
  `skill` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '技能标签',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  PRIMARY KEY (`userid`) USING BTREE,
  INDEX `FK_tl3iuocieaertwsilae1xc7m3`(`dept_id`) USING BTREE,
  CONSTRAINT `FK_tl3iuocieaertwsilae1xc7m3` FOREIGN KEY (`dept_id`) REFERENCES `sys_dept` (`deptid`) ON DELETE SET NULL ON UPDATE SET NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('40289f5b6656b34201665799fd890001', 'X0005', '欧玉娟', 'ff8080816610e22d016613ee6a100007', '财务部', NULL, 'ff8080816610e22d01661468b1290030', '财务总监', '女', '1972-06-01', NULL, '本科', NULL, '贵州财经学院', '1998.7', NULL, NULL, '已婚', NULL, '汉', '520102197206015825', '贵州省贵阳市白云区都拉营车辆厂', NULL, NULL, NULL, NULL, '13511932152', NULL, '1991-07-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, '高海明', '同事', '13608554641', NULL, NULL, '党员', NULL, NULL, NULL, '4c7b2bba049b8ebe8ad47ad8df98a614', NULL, '1', NULL, NULL, 'admin', '2018-11-08 19:11:53', NULL, NULL, NULL, NULL, '4546@qq.com');
INSERT INTO `sys_user` VALUES ('40289f5b6656b34201665799fdc60002', 'X0006', '李洪涛', 'ff8080816610e22d016613e9a83c0004', '营销部', '办公室', 'ff8080816610e22d0166146969070031', '营销总监', '男', '1976-10-16', NULL, '本科', '机械制造', '重庆大学', '1999.7', NULL, NULL, '已婚', NULL, '汉', '522121197610160013', '贵州省贵阳市白云区都拉营车辆厂', '非农户', '在职', '已转正', '2003-03-01', '13595018946', '40', '1999-07-01', '续', '2016.06.01', '无固定期限', NULL, NULL, NULL, '36342', '范贤英', '夫妻', '13984806362', NULL, '是', '党员', NULL, NULL, NULL, '4c7b2bba049b8ebe8ad47ad8df98a614', NULL, '1', 'admin', '2018-10-09 14:53:21', 'admin', '2018-10-09 14:53:21', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('40289f5b6656b34201665799fdea0003', 'X0007', '张俊伟', 'ff8080816610e22d01661463779b0029', '总经办', '办公室', 'ff8080816610e22d0166146e66420033', '副总经理', '男', '1970-01-27', NULL, '本科', '机械制造', '西南交大', '1992.7', NULL, NULL, '已婚', NULL, '汉', '510103197001277375', '贵州省贵阳市白云区都拉营车辆厂', '非农户', '在职', '已转正', '2003-03-01', '13985585077', '38', '1992-07-01', '续', '2016.06.01', '无固定期限', NULL, NULL, NULL, '1992-07-01', '邹常丽', '夫妻', '15985007071', NULL, '是', '党员', NULL, NULL, NULL, '4c7b2bba049b8ebe8ad47ad8df98a614', NULL, '1', 'admin', '2018-10-09 14:53:21', 'admin', '2018-10-09 14:53:21', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('40289f5b6656b34201665799fe2a0005', 'X0010', '龙滔', 'ff8080816610e22d016613e9a83c0004', '营销部', NULL, 'ff8080816610e22d0166146969070031', '营销总监', '男', '1977-03-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4c7b2bba049b8ebe8ad47ad8df98a614', NULL, '1', NULL, NULL, 'admin', '2018-11-08 18:23:03', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('40289f5b6656b34201665799fe4c0006', 'X0011', '刘丽雅', 'ff8080816610e22d016613eeeac00009', '综合部', NULL, 'ff8080816610e22d0166146969070031', '营销总监', '女', '1973-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '4c7b2bba049b8ebe8ad47ad8df98a614', NULL, '1', NULL, NULL, 'admin', '2018-11-08 18:22:39', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('40289f5b6656b34201665799fe700007', 'X0012', '周仕红', 'ff8080816610e22d016613e9a83c0004', '营销部', '办公室', 'ff8080816610e22d016618c9340900af', '原材料管库员', '女', '1973-09-08', NULL, '中专', '', '贵州机械工业学校', '1993.7', '', '', '已婚', '', '汉', '520102197309085869', '贵州省贵阳市白云区都拉营车辆厂', '非农户', '在职', '已转正', '2009-01-01', '15985115809', '39', '1993-07-01', '续', '2015.04.01', '无固定期限', '', '', '', '1993-07-01', '周仕菊', '姐妹', '15329695578', '', '否', '', '', '', '', '4c7b2bba049b8ebe8ad47ad8df98a614', NULL, '1', NULL, NULL, 'admin', '2018-10-15 11:47:04', '', NULL, 0, 'Java,安卓,IOS', 'dasda');
INSERT INTO `sys_user` VALUES ('40289f5b6656b34201665799febd0009', 'X0046', '罗敏', 'ff8080816610e22d016613ef18b7000a', '人事行政部', '办公室', 'ff8080816610e22d016618ca82c900b2', '部门经理', '女', '1975-08-15', NULL, '本科', '工商行政管理', '贵州财经学院', '1996.7', NULL, NULL, '已婚', NULL, '汉', '52010219750815242X', '贵州省贵阳市白云区都拉营车辆厂', '非农户', '在职', '已转正', NULL, '13765059098', '34', '35612', '新', '2015.04.01', '无固定期限', '已参保', '已参保', NULL, '1996-7-1', '黄柯', '夫妻', '13885059680', NULL, '是', '党员', NULL, NULL, NULL, '4c7b2bba049b8ebe8ad47ad8df98a614', NULL, '1', 'admin', '2018-10-09 14:53:21', 'admin', '2018-10-09 14:53:21', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('40289f5b6656b34201665799fee5000a', 'X0048', '李青', 'ff8080816610e22d016613ee110d0005', '研发中心', '办公室', NULL, '研发总工', '男', '1974-11-13', NULL, '硕士', '电子与通信工程领域工程', '重庆大学', '2006.7', NULL, NULL, '已婚', NULL, '汉', '520203197411130859', '贵州省贵阳市白云区都拉营车辆厂', '非农户', '在职', '已转正', '2002-09-01', '13985493965', '40', '1997-07-01', '续', '2016.06.01', '无固定期限', NULL, NULL, NULL, '1997-07-01', '宋伟', '夫妻', '15180878687', NULL, '是', '党员', NULL, NULL, NULL, '4c7b2bba049b8ebe8ad47ad8df98a614', NULL, '1', 'admin', '2018-10-09 14:53:22', 'admin', '2018-10-09 14:53:22', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES ('8a929c0c60dda9f10160ddafb4b7000a', 'admin', '金龙', 'ff8080816610e22d01661463779b0029', NULL, NULL, NULL, NULL, '男', '2018-01-12', NULL, '小学', '', '', '', NULL, NULL, NULL, NULL, NULL, '', NULL, NULL, '', NULL, NULL, '', NULL, '', '', '', '', 'false', 'false', NULL, NULL, NULL, NULL, '', NULL, '否', '否', '', '', '', '4c7b2bba049b8ebe8ad47ad8df98a614', '5234423.jfif', '1', 'admin', '2018-01-10 09:29:27', 'admin', '2018-09-13 10:51:34', '', '00', 0, NULL, NULL);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role`  (
  `userid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `roleid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`userid`, `roleid`) USING BTREE,
  INDEX `FK_jpkvqqgndeonhr2alguthv64e`(`roleid`) USING BTREE,
  INDEX `FK_jwv62hhuqojjk7pot7kaex3e1`(`userid`) USING BTREE,
  CONSTRAINT `FK_jpkvqqgndeonhr2alguthv64e` FOREIGN KEY (`roleid`) REFERENCES `sys_role` (`roleid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_jwv62hhuqojjk7pot7kaex3e1` FOREIGN KEY (`userid`) REFERENCES `sys_user` (`userid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_role
-- ----------------------------
INSERT INTO `user_role` VALUES ('40289f5b6656b34201665799fd890001', '402880e860f555c20160f584af0c0002');
INSERT INTO `user_role` VALUES ('40289f5b6656b34201665799fe700007', '402880e860dc7bb70160dc7c6c2d0002');
INSERT INTO `user_role` VALUES ('8a929c0c60dda9f10160ddafb4b7000a', '8a929c0c60dda9f10160ddaecae00006');

SET FOREIGN_KEY_CHECKS = 1;
