/*
 Navicat Premium Data Transfer

 Source Server         : zsk
 Source Server Type    : MySQL
 Source Server Version : 50722
 Source Host           : localhost:3306
 Source Schema         : shelldb

 Target Server Type    : MySQL
 Target Server Version : 50722
 File Encoding         : 65001

 Date: 24/04/2019 18:33:50
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for qrcode_config
-- ----------------------------
DROP TABLE IF EXISTS `qrcode_config`;
CREATE TABLE `qrcode_config`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qrcode_height` int(11) NOT NULL COMMENT '生成二维码高度',
  `qrcode_width` int(11) NOT NULL COMMENT '生成二维码宽度',
  `qrcode_font_size` int(11) NOT NULL COMMENT '文字大小',
  `qrcode_font_height` int(11) NOT NULL COMMENT '文字高度',
  `qrcode_index_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '扫描二维码待跳转页面',
  `qrcode_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二维码生成后存放的地址',
  `is_del` int(10) NULL DEFAULT 0 COMMENT '是否删除：0=未删除，1=已经删除',
  `qrcode_config_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '该二维码设置名称',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '说明',
  `qrcode_shape` int(10) NOT NULL COMMENT '码的形状，0=圆形码，1=方形码',
  `qrcode_type_id` int(11) NULL DEFAULT NULL COMMENT '码类型id',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '二维码配置信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrcode_config
-- ----------------------------
INSERT INTO `qrcode_config` VALUES (1, 680, 680, 19, 90, 'pages/index/main', '/home/', 0, '测试位置码', '用于生成测试的位置码', 0, 1, '2019-04-16 17:55:37', '2019-04-16 17:55:40');
INSERT INTO `qrcode_config` VALUES (2, 430, 430, 19, 90, 'pages/index/main', '/home/', 0, '测试导购码', '用于生成测试的导购码', 0, 1, '2019-04-16 17:55:37', '2019-04-16 17:55:40');

-- ----------------------------
-- Table structure for qrcode_info
-- ----------------------------
DROP TABLE IF EXISTS `qrcode_info`;
CREATE TABLE `qrcode_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mall_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商店类型',
  `mall_code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商店编码',
  `mall_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商店名称',
  `dept_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `dept_id` int(11) NULL DEFAULT NULL COMMENT '对应部门id',
  `dept_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门推广码',
  `user_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户id',
  `user_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名称',
  `user_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户手机号',
  `img_path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图片路径',
  `img_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图片名称',
  `img_time` datetime(0) NULL DEFAULT NULL COMMENT '生成日期',
  `enterprise_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '企业名称',
  `enterprise_id` int(10) NULL DEFAULT NULL COMMENT '对应企业id',
  `is_create_qrcode` int(10) NULL DEFAULT NULL COMMENT '是否已经创建过二维码；0=未创建，1=已创建',
  `is_del` int(10) NULL DEFAULT NULL COMMENT '0=未删除，1=已经删除',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dept_id_index`(`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存放二维码信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrcode_info
-- ----------------------------
INSERT INTO `qrcode_info` VALUES (1, '便利店', '0115', '地质中学店', NULL, NULL, NULL, '0115_M0001', NULL, NULL, 'data0/uploads\\员工码\\地质中学店\\null\\0115_M0001.png', '0115_M0001.png', '2018-08-13 15:49:58', NULL, NULL, 1, 0, '2019-04-18 15:00:53', '2019-04-18 15:00:58');
INSERT INTO `qrcode_info` VALUES (2, '便利店1', '0116', '地质中学店', NULL, NULL, NULL, '0115_M0001', NULL, NULL, 'data0/uploads\\员工码\\地质中学店\\null\\0115_M0001.png', '0115_M0001.png', '2018-08-13 15:49:58', NULL, NULL, 1, 0, '2019-04-18 15:00:56', '2019-04-18 15:01:04');

-- ----------------------------
-- Table structure for qrcode_type
-- ----------------------------
DROP TABLE IF EXISTS `qrcode_type`;
CREATE TABLE `qrcode_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qrcode_type_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '二维码类型名称',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '最后修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '二维码类型' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrcode_type
-- ----------------------------
INSERT INTO `qrcode_type` VALUES (1, '导购码', '2019-04-18 15:00:13', '2019-04-18 15:00:15');

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BLOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TRIG_INST_NAME`(`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`SCHED_NAME`, `INSTANCE_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_FT_J_G`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_T_G`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TG`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_REQ_RECOVERY`(`SCHED_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_J_GRP`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('MasterScheduler', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('MasterScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('MasterScheduler', 'DESKTOP-CUD9MR51556101909284', 1556102018361, 15000);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `INT_PROP_1` int(11) NULL DEFAULT NULL,
  `INT_PROP_2` int(11) NULL DEFAULT NULL,
  `LONG_PROP_1` bigint(20) NULL DEFAULT NULL,
  `LONG_PROP_2` bigint(20) NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PRIORITY` int(11) NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) NULL DEFAULT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_J`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_C`(`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_G`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_STATE`(`SCHED_NAME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_STATE`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_G_STATE`(`SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME`(`SCHED_NAME`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST`(`SCHED_NAME`, `TRIGGER_STATE`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for schedule_job
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job`;
CREATE TABLE `schedule_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务id',
  `bean_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `cron_expression` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'cron表达式',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '任务状态  0：正常  1：暂停',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for schedule_job_log
-- ----------------------------
DROP TABLE IF EXISTS `schedule_job_log`;
CREATE TABLE `schedule_job_log`  (
  `log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志id',
  `job_id` bigint(20) NOT NULL COMMENT '任务id',
  `bean_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'spring bean名称',
  `method_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `params` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数',
  `status` tinyint(4) NOT NULL COMMENT '任务状态    0：成功    1：失败',
  `error` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '失败信息',
  `times` int(11) NOT NULL COMMENT '耗时(单位：毫秒)',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `job_id`(`job_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1098462319601569855 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '定时任务日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of schedule_job_log
-- ----------------------------
INSERT INTO `schedule_job_log` VALUES (1087620886778900507, 3, 'testTask333', 'test2eee333', '1111111111', 1, 'org.springframework.beans.factory.NoSuchBeanDefinitionException: No bean named \'testTask333\' available', 46, '2019-01-24 18:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900526, 3, 'testTask', 'test', '1111111111', 0, NULL, 1004, '2019-01-24 18:41:35');
INSERT INTO `schedule_job_log` VALUES (1087620886778900594, 3, 'testTask', 'test', '1111111111', 0, NULL, 1037, '2019-01-30 14:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900595, 3, 'testTask', 'test', '1111111111', 0, NULL, 1022, '2019-01-30 14:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900596, 3, 'testTask', 'test', '1111111111', 0, NULL, 1006, '2019-01-30 15:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900597, 3, 'testTask', 'test', '1111111111', 0, NULL, 1024, '2019-01-30 15:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900598, 3, 'testTask', 'test', '1111111111', 0, NULL, 1034, '2019-01-30 16:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900599, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 0, '2019-01-30 16:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900600, 3, 'testTask', 'test', '1111111111', 0, NULL, 1008, '2019-01-30 16:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900601, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-01-30 17:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900602, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 4, '2019-01-30 17:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900603, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-01-30 18:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900604, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 4, '2019-01-30 18:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900605, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 37, '2019-02-12 10:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900606, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-12 10:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900607, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-12 11:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900608, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-12 11:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900609, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 0, '2019-02-12 12:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900610, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-12 12:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900611, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-12 13:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900612, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-12 13:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900613, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-12 14:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900614, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 45, '2019-02-12 14:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900615, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 5, '2019-02-12 15:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900616, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-12 15:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900617, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-12 16:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900618, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 14, '2019-02-12 16:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900619, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-12 17:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900620, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-12 17:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900621, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-12 18:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900622, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 127, '2019-02-13 10:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900623, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-13 11:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900624, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-13 11:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900625, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-13 12:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900626, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-13 12:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900627, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-13 13:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900628, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-13 13:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900629, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-13 14:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900630, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-13 14:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900631, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-13 15:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900632, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-13 15:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900633, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-13 16:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900634, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-13 16:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900635, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-13 17:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900636, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-13 18:00:22');
INSERT INTO `schedule_job_log` VALUES (1087620886778900637, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 28, '2019-02-14 10:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900638, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-14 10:33:05');
INSERT INTO `schedule_job_log` VALUES (1087620886778900639, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-14 11:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900640, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-14 12:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900641, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-14 12:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900642, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-14 13:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900643, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-14 13:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900644, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-14 14:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900645, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-14 14:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900646, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 29, '2019-02-14 15:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900647, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-14 15:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900648, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 42, '2019-02-14 16:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900649, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-14 16:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900650, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-14 17:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900651, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 22, '2019-02-14 17:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900652, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 4, '2019-02-14 18:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900653, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 6, '2019-02-15 10:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900654, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 39, '2019-02-15 10:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900655, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-15 11:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900656, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 6, '2019-02-15 11:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900657, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-15 12:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900658, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-15 12:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900659, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-15 13:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900660, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-15 13:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900661, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-15 14:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900662, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-15 14:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900663, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 6, '2019-02-15 15:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900664, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-15 16:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900665, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-15 16:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900666, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-15 17:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900667, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-15 17:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900668, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 72, '2019-02-15 18:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900669, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-15 18:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900670, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 19, '2019-02-18 11:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900671, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 30, '2019-02-18 11:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900672, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 15, '2019-02-18 12:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900673, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 6, '2019-02-18 12:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900674, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-18 13:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900675, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-18 13:30:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900676, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-18 14:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900677, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 4, '2019-02-18 15:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900678, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 5, '2019-02-18 16:00:00');
INSERT INTO `schedule_job_log` VALUES (1087620886778900679, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 25, '2019-02-18 16:30:00');
INSERT INTO `schedule_job_log` VALUES (1097428004486828033, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 18, '2019-02-18 17:30:00');
INSERT INTO `schedule_job_log` VALUES (1097435554171113473, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-18 18:00:00');
INSERT INTO `schedule_job_log` VALUES (1097782843171418114, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 59, '2019-02-19 17:00:00');
INSERT INTO `schedule_job_log` VALUES (1098152780935233537, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 9, '2019-02-20 17:30:00');
INSERT INTO `schedule_job_log` VALUES (1098160329696849922, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-20 18:00:00');
INSERT INTO `schedule_job_log` VALUES (1098409472142966785, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 25, '2019-02-21 10:30:00');
INSERT INTO `schedule_job_log` VALUES (1098417021319761922, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-21 11:00:00');
INSERT INTO `schedule_job_log` VALUES (1098424570764972033, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-21 11:30:00');
INSERT INTO `schedule_job_log` VALUES (1098454771121049601, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 28, '2019-02-21 13:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569794, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-02-21 14:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569795, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-02-21 14:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569796, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 6, '2019-02-21 15:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569797, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-02-21 15:30:01');
INSERT INTO `schedule_job_log` VALUES (1098462319601569798, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 23, '2019-02-21 17:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569799, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 78, '2019-02-21 18:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569800, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 39, '2019-03-20 11:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569801, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-03-20 11:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569802, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 36, '2019-03-20 12:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569803, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-03-20 12:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569804, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-03-20 13:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569805, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-03-20 13:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569806, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-03-20 15:00:01');
INSERT INTO `schedule_job_log` VALUES (1098462319601569807, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-03-20 15:30:01');
INSERT INTO `schedule_job_log` VALUES (1098462319601569808, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 7, '2019-04-15 14:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569809, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 6, '2019-04-15 15:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569810, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-15 15:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569811, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-15 16:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569812, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-04-15 16:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569813, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-04-15 17:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569814, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-15 17:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569815, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-15 18:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569816, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 6, '2019-04-15 18:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569817, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 297, '2019-04-16 11:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569818, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-04-16 11:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569819, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-16 12:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569820, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-16 12:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569821, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-16 13:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569822, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-04-16 13:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569823, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-16 14:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569824, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-16 14:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569825, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-16 15:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569826, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-16 15:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569827, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-16 16:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569828, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-16 16:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569829, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-16 17:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569830, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-16 17:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569831, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-16 18:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569832, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 5, '2019-04-17 10:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569833, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 6, '2019-04-17 11:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569834, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-17 11:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569835, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-17 12:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569836, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-17 12:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569837, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-04-17 13:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569838, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-04-17 13:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569839, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-17 14:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569840, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-04-17 14:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569841, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-17 15:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569842, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-17 15:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569843, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-17 16:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569844, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 209, '2019-04-17 17:00:01');
INSERT INTO `schedule_job_log` VALUES (1098462319601569845, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-04-17 18:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569846, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-17 18:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569847, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-04-18 15:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569848, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 5, '2019-04-18 16:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569849, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 5, '2019-04-19 11:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569850, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-19 11:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569851, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 2, '2019-04-19 12:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569852, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-19 12:30:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569853, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 1, '2019-04-19 13:00:00');
INSERT INTO `schedule_job_log` VALUES (1098462319601569854, 4, 'testTask', 'test2', 'xsxasxasxsx', 1, 'java.lang.NoSuchMethodException: com.winnerdt.modules.job.task.TestTask.test2(java.lang.String)', 3, '2019-04-19 13:30:00');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `param_key` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'key',
  `param_value` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'value',
  `status` tinyint(4) NULL DEFAULT 1 COMMENT '状态   0：隐藏   1：显示',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `param_key`(`param_key`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统配置信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 'CLOUD_STORAGE_CONFIG_KEY', '{\"type\":0,\"qiniuDomain\":\"http://pm2vkbv1m.bkt.clouddn.com\",\"qiniuPrefix\":\"upload\",\"qiniuAccessKey\":\"qg1BFsLRVadWHtyGYW2yVzz0ZVJGzLFmwTqhi0ZU\",\"qiniuSecretKey\":\"LGyVEEN_DL1M_NIydnCZlXXifPlE2Ng1RuEvsxkg\",\"qiniuBucketName\":\"master-test\"}', 0, '云存储配置信息');
INSERT INTO `sys_config` VALUES (3, '323233', '33333232', 1, '323');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '上级部门ID，一级部门为0',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `dept_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '推广码',
  `del_flag` tinyint(4) NULL DEFAULT 0 COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, 0, '人人开源集团', 0, NULL, 0);
INSERT INTO `sys_dept` VALUES (2, 1, '长沙分公司', 1, NULL, 0);
INSERT INTO `sys_dept` VALUES (3, 1, '上海分公司', 2, NULL, 0);
INSERT INTO `sys_dept` VALUES (4, 3, '技术部', 0, NULL, 0);
INSERT INTO `sys_dept` VALUES (5, 3, '销售部', 1, NULL, 0);
INSERT INTO `sys_dept` VALUES (6, 1, '是否', 1, NULL, 0);
INSERT INTO `sys_dept` VALUES (7, 1, 'haha', 8, NULL, 0);

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典名称',
  `type` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典类型',
  `code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典码',
  `value` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '字典值',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '排序',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` tinyint(4) NULL DEFAULT 0 COMMENT '删除标记  -1：已删除  0：正常',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `type`(`type`, `code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '数据字典表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES (2, '性别', 'sex', '1', '男', 1, '性别', 0);
INSERT INTO `sys_dict` VALUES (3, '性别', 'sex', '2', '未知', 3, '性别', 0);
INSERT INTO `sys_dict` VALUES (4, '34', '43', '43', '43', 43, '443', 0);

-- ----------------------------
-- Table structure for sys_icon
-- ----------------------------
DROP TABLE IF EXISTS `sys_icon`;
CREATE TABLE `sys_icon`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标代码',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标类型',
  `status` int(10) NULL DEFAULT NULL COMMENT '0：不启用，1：启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 299 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_icon
-- ----------------------------
INSERT INTO `sys_icon` VALUES (1, 'step-forward', '图标', 1);
INSERT INTO `sys_icon` VALUES (2, 'step-backward', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (3, 'forward', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (4, 'backward', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (5, 'caret-right', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (6, 'caret-left', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (7, 'caret-down', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (8, 'caret-up', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (9, 'right-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (10, 'left-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (11, 'up-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (12, 'down-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (13, 'right-circle-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (14, 'left-circle-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (15, 'up-circle-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (16, 'down-circle-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (17, 'vertical-left', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (18, 'vertical-right', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (19, 'back', '常用图标', 0);
INSERT INTO `sys_icon` VALUES (20, 'retweet', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (21, 'shrink', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (22, 'arrow-salt', '常用图标', 0);
INSERT INTO `sys_icon` VALUES (23, 'double-right', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (24, 'double-left', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (25, 'arrow-down', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (26, 'arrow-up', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (27, 'arrow-right', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (28, 'arrow-left', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (29, 'down', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (30, 'up', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (31, 'right', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (32, 'left', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (33, 'minus-square-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (34, 'minus-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (35, 'minus-circle-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (36, 'minus', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (37, 'plus-circle-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (38, 'plus-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (39, 'plus', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (40, 'info-cirlce', '常用图标', 0);
INSERT INTO `sys_icon` VALUES (41, 'info-cirlce-o', '常用图标', 0);
INSERT INTO `sys_icon` VALUES (42, 'info', '常用图标', 0);
INSERT INTO `sys_icon` VALUES (43, 'exclamation', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (44, 'exclamation-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (45, 'exclamation-circle-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (46, 'close-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (47, 'close-circle-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (48, 'check-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (49, 'check-circle-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (50, 'check', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (51, 'close', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (52, 'customer-service', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (53, 'credit-card', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (54, 'code-square-o', '常用图标', 0);
INSERT INTO `sys_icon` VALUES (55, 'book', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (56, 'barschart', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (57, 'bars', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (58, 'question', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (59, 'question-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (60, 'question-circle-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (61, 'pause', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (62, 'pause-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (63, 'pause-circle-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (64, 'clock-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (65, 'clock-circle-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (66, 'swap', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (67, 'swap-left', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (68, 'swap-right', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (69, 'pluss-quare-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (70, 'frown', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (71, 'menufold', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (72, 'mail', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (73, 'link', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (74, 'area-chart', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (75, 'line-chart', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (76, 'home', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (77, 'laptop', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (78, 'star', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (79, 'staro', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (80, 'filter', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (81, 'meho', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (82, 'meh', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (83, 'shoppingcart', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (84, 'save', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (85, 'user', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (86, 'videocamera', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (87, 'totop', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (88, 'team', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (89, 'sharealt', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (90, 'setting', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (91, 'picture', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (92, 'phone', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (93, 'paperclip', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (94, 'notification', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (95, 'menuunfold', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (96, 'inbox', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (97, 'lock', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (98, 'qrcode', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (99, 'tags', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (100, 'tagso', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (101, 'cloudo', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (102, 'cloud', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (103, 'cloud-upload', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (104, 'cloud-download', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (105, 'cloud-downloado', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (106, 'cloud-uploado', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (107, 'enviroment', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (108, 'enviromento', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (109, 'eye', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (110, 'eye-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (111, 'camera', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (112, 'camera-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (113, 'windows', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (114, 'export2', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (115, 'export', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (116, 'circle-downo', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (117, 'circle-down', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (118, 'hdd', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (119, 'ie', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (120, 'delete', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (121, 'enter', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (122, 'pushpino', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (123, 'pushpin', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (124, 'heart', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (125, 'hearto', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (126, 'smile-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (127, 'smileo', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (128, 'frowno', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (129, 'calculator', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (130, 'chrome', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (131, 'github', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (132, 'iconfont-desktop', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (133, 'caret-circle-o-up', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (134, 'upload', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (135, 'download', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (136, 'piechart', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (137, 'lock1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (138, 'unlock', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (139, 'windows-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (140, 'dotchart', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (141, 'barchart', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (142, 'code-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (143, 'plus-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (144, 'minus-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (145, 'close-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (146, 'closes-quare-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (147, 'check-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (148, 'checks-quare-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (149, 'fast-backward', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (150, 'fast-forward', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (151, 'up-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (152, 'down-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (153, 'lefts-quare', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (154, 'right-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (155, 'right-square-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (156, 'left-square-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (157, 'down-square-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (158, 'up-square-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (159, 'play', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (160, 'play-circle-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (161, 'tag', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (162, 'tago', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (163, 'addfile', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (164, 'folder1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (165, 'file1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (166, 'switcher', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (167, 'add-folder', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (168, 'fold-eropen', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (169, 'search1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (170, 'ellipsis1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (171, 'calendar', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (172, 'filetext1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (173, 'copy1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (174, 'jpgfile1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (175, 'pdffile1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (176, 'exclefile1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (177, 'pptfile1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (178, 'unknowfile1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (179, 'wordfile1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (180, 'dingding', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (181, 'dingding-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (182, 'mobile1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (183, 'tablet1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (184, 'bells', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (185, 'disconnect', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (186, 'database', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (187, 'barcode', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (188, 'hourglass', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (189, 'key', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (190, 'flag', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (191, 'layout', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (192, 'printer', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (193, 'USB', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (194, 'skin', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (195, 'tool', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (196, 'car', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (197, 'addusergroup', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (198, 'carryout', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (199, 'deleteuser', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (200, 'deleteusergroup', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (201, 'man', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (202, 'isv', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (203, 'gift', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (204, 'idcard', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (205, 'medicinebox', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (206, 'redenvelopes', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (207, 'rest', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (208, 'Safety', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (209, 'wallet', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (210, 'woman', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (211, 'adduser', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (212, 'bank', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (213, 'Trophy', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (214, 'loading1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (215, 'loading2', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (216, 'like2', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (217, 'dislike2', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (218, 'like1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (219, 'dislike1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (220, 'bulb1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (221, 'rocket1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (222, 'select1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (223, 'apple1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (224, 'apple-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (225, 'android1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (226, 'android', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (227, 'aliwangwang-o1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (228, 'aliwangwang', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (229, 'pay-circle1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (230, 'pay-circle-o1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (231, 'poweroff', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (232, 'trademark', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (233, 'find', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (234, 'copyright', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (235, 'sound', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (236, 'earth', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (237, 'wifi', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (238, 'sync', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (239, 'login', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (240, 'logout', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (241, 'reload1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (242, 'message1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (243, 'shake', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (244, 'API', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (245, 'appstore-o', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (246, 'appstore1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (247, 'scan1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (248, 'exception1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (249, 'contacts', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (250, 'solution1', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (251, 'fork', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (252, 'edit', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (253, 'form', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (254, 'warning', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (255, 'table', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (256, 'profile', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (257, 'dashboard', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (258, 'indent-left', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (259, 'indent-right', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (260, 'menu-unfold', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (261, 'menu-fold', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (262, 'antdesign', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (263, 'alipay-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (264, 'codepen-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (265, 'google', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (266, 'amazon', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (267, 'codepen', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (268, 'facebook-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (269, 'dropbox', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (270, 'googleplus', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (271, 'linkedin-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (272, 'medium-monogram', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (273, 'gitlab', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (274, 'medium-wordmark', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (275, 'QQ', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (276, 'skype', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (277, 'taobao-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (278, 'alipay-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (279, 'youtube', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (280, 'wechat', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (281, 'twitter', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (282, 'weibo', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (283, 'HTML', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (284, 'taobao-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (285, 'weibo-circle', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (286, 'weibo-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (287, 'Code-Sandbox', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (288, 'aliyun', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (289, 'zhihu', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (290, 'behance', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (291, 'dribbble', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (292, 'dribbble-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (293, 'behance-square', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (294, 'file-markdown', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (295, 'instagram', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (296, 'yuque', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (297, 'slack', '常用图标', 1);
INSERT INTO `sys_icon` VALUES (298, 'slack-square', '常用图标', 1);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户操作',
  `method` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `time` bigint(20) NOT NULL COMMENT '执行时长(毫秒)',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1098431558701871128 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (1, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1,\"roleName\":\"test\",\"deptId\":2,\"deptName\":\"长沙分公司\",\"menuIdList\":[1,2,15,16,17,18,3,19,20,21,22,4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,31,32,33,34,35,36,37,38,39,40],\"deptIdList\":[],\"createTime\":\"Jan 7, 2019 6:28:32 PM\"}', 341, '0:0:0:0:0:0:0:1', '2019-01-07 18:28:33');
INSERT INTO `sys_log` VALUES (2, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleId\":2,\"roleName\":\"testone\",\"remark\":\"你好\",\"deptId\":4,\"deptName\":\"技术部\",\"menuIdList\":[1,2,15,16,17,18,3,19,20,21,22,4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,31,32,33,34,35,36,37,38,39,40],\"deptIdList\":[],\"createTime\":\"Jan 14, 2019 10:49:02 AM\"}', 260, '0:0:0:0:0:0:0:1', '2019-01-14 10:49:03');
INSERT INTO `sys_log` VALUES (3, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":3,\"username\":\"wenbin\",\"password\":\"11783beb5df0a36ecbc528d065bf770a41b3f9ed3b8d5eedee52293766f0e16b\",\"salt\":\"AFoFb1JPfe1Pjw0aDSWI\",\"email\":\"we@qq.com\",\"mobile\":\"13333333333\",\"status\":0,\"roleIdList\":[1,2],\"createTime\":\"Jan 16, 2019 2:38:21 PM\",\"deptId\":4}', 2846, '192.168.199.192', '2019-01-16 14:38:22');
INSERT INTO `sys_log` VALUES (4, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":4,\"username\":\"we\",\"password\":\"e6f5531e21e8361f013262a414da5ec9f78ae5e0d3c46cc143751de93ca6f190\",\"salt\":\"IQcUwEmdXnfVmK2zK37P\",\"email\":\"we@qq.com\",\"mobile\":\"13333333333\",\"status\":1,\"roleIdList\":[2],\"createTime\":\"Jan 16, 2019 2:41:11 PM\",\"deptId\":1}', 155, '192.168.199.192', '2019-01-16 14:41:12');
INSERT INTO `sys_log` VALUES (5, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[4]', 3425, '192.168.199.192', '2019-01-16 17:05:44');
INSERT INTO `sys_log` VALUES (6, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":5,\"username\":\"5454\",\"password\":\"b700b7a585143d4011604abd0b39b2090a3a7eda20d91c1a9bfa361e51a4fc0c\",\"salt\":\"fRBUsbLPzAeI4VGsZC8K\",\"email\":\"wb@qq.com\",\"mobile\":\"13333333333\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"Jan 16, 2019 5:06:29 PM\",\"deptId\":1}', 224, '192.168.199.192', '2019-01-16 17:06:30');
INSERT INTO `sys_log` VALUES (7, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[1]', 748, '192.168.199.192', '2019-01-16 17:37:09');
INSERT INTO `sys_log` VALUES (8, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[3]', 8155, '192.168.199.192', '2019-01-16 17:39:57');
INSERT INTO `sys_log` VALUES (9, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":6,\"username\":\"vrfitz\",\"password\":\"7aa3c0121c0e15625dd4a01b3c104ca11378c873e52e65e27328fdd207ceaab6\",\"salt\":\"E4fKgh2PFz8w2uys1vdk\",\"email\":\"303316861@qq.com\",\"mobile\":\"18838987007\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"Jan 16, 2019 5:44:30 PM\",\"deptId\":1}', 208, '0:0:0:0:0:0:0:1', '2019-01-16 17:44:31');
INSERT INTO `sys_log` VALUES (10, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":7,\"username\":\"444\",\"password\":\"37d9d4a321e28ecf3e3dac697d0cf5aae3e0b57e338b834b9d444cb8db9fccbf\",\"salt\":\"KRjekSc8TxNhzWG8hf9o\",\"email\":\"e@qq.com\",\"mobile\":\"44444\",\"status\":1,\"roleIdList\":[1,2],\"createTime\":\"Jan 16, 2019 5:45:04 PM\",\"deptId\":1}', 93, '192.168.199.192', '2019-01-16 17:45:05');
INSERT INTO `sys_log` VALUES (11, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":9,\"username\":\"10110\",\"password\":\"40f946cdb52ff116c2564a6f30588417cad68ff5dbc4e45622f3911eef3be38f\",\"salt\":\"3QRrook7TBEnstEBWfLj\",\"email\":\"303316861@qq.com\",\"mobile\":\"13354782455\",\"status\":1,\"roleIdList\":[2],\"createTime\":\"Jan 16, 2019 5:50:07 PM\",\"deptId\":1}', 302, '0:0:0:0:0:0:0:1', '2019-01-16 17:50:08');
INSERT INTO `sys_log` VALUES (12, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":10,\"username\":\"额外\",\"password\":\"3d01fb9722966cd20019dcdbb901df8ad75b1543c973dd6a49ac0fe3c0e25858\",\"salt\":\"FEQnjt2jqc6ya6vuGIJb\",\"email\":\"w@qq.com\",\"mobile\":\"13333333333\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"Jan 16, 2019 5:53:33 PM\",\"deptId\":1}', 90, '192.168.199.192', '2019-01-16 17:53:33');
INSERT INTO `sys_log` VALUES (13, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[10]', 5718, '0:0:0:0:0:0:0:1', '2019-01-17 10:20:10');
INSERT INTO `sys_log` VALUES (14, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[2]', 49, '0:0:0:0:0:0:0:1', '2019-01-17 10:22:47');
INSERT INTO `sys_log` VALUES (15, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[5]', 42, '0:0:0:0:0:0:0:1', '2019-01-17 10:22:53');
INSERT INTO `sys_log` VALUES (16, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[6]', 40, '0:0:0:0:0:0:0:1', '2019-01-17 10:23:28');
INSERT INTO `sys_log` VALUES (17, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":11,\"username\":\"test\",\"password\":\"1c5d92efa82f4a86362aba89f027de55a3d387a77c8f3ef81e8478a09ca29471\",\"salt\":\"E0yVJqRxX3yj2FOJG22W\",\"email\":\"980680177@qq.com\",\"mobile\":\"13354782455\",\"status\":1,\"roleIdList\":[2],\"createTime\":\"Jan 17, 2019 10:28:04 AM\",\"deptId\":2}', 226, '0:0:0:0:0:0:0:1', '2019-01-17 10:28:05');
INSERT INTO `sys_log` VALUES (18, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":12,\"username\":\"2222222222\",\"password\":\"fafd4fe36803a70890270ebc4bc3298b8bbae5bf8bb59362bb62ce450f3ecfdd\",\"salt\":\"6JTjdbIGuM8RE208d7CI\",\"email\":\"we@qq.com\",\"mobile\":\"22222\",\"status\":1,\"roleIdList\":[1,2],\"createTime\":\"Jan 17, 2019 10:42:20 AM\",\"deptId\":1}', 147, '192.168.199.192', '2019-01-17 10:42:21');
INSERT INTO `sys_log` VALUES (19, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":13,\"username\":\"role\",\"password\":\"111656e0142498622f922b87f221ca2806544461c99c2f2c16c2aebe43fc8a45\",\"salt\":\"94jjeqYjkdwciGGaDRLA\",\"email\":\"wenbin@qq.com\",\"mobile\":\"13333333333\",\"status\":1,\"roleIdList\":[1,2],\"createTime\":\"Jan 17, 2019 11:20:57 AM\",\"deptId\":1}', 166, '192.168.199.192', '2019-01-17 11:20:58');
INSERT INTO `sys_log` VALUES (20, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":16,\"username\":\"re\",\"password\":\"5fb776e77188274de62bff5eb75d4e07384cf88b6d0791400849363d5a52b692\",\"salt\":\"Xs7FKHdpcuvESDuzn5Cj\",\"email\":\"rr2@qq.com\",\"mobile\":\"13333333333\",\"status\":1,\"roleIdList\":[1,2],\"createTime\":\"Jan 17, 2019 11:55:10 AM\",\"deptId\":1}', 49, '192.168.199.192', '2019-01-17 11:55:11');
INSERT INTO `sys_log` VALUES (21, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":17,\"username\":\"4555555555\",\"password\":\"fb22651b04152d65e706ba506cee4e7a85be9fdcf40abf498346e9a6f728ef9a\",\"salt\":\"9EjTbk7h6OYg5qJ8Lhah\",\"email\":\"we@11.VOM\",\"mobile\":\"EEEEEEEEEEEEE\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"Jan 17, 2019 12:03:58 PM\",\"deptId\":1}', 60, '192.168.199.192', '2019-01-17 12:03:59');
INSERT INTO `sys_log` VALUES (22, 'admin', '修改用户', 'io.renren.modules.sys.controller.SysUserController.update()', '{\"userId\":17,\"username\":\"4555555555\",\"password\":\"1facc402b7d81be1fa3f6091f140ea5de67772756b8eca195e8400162e852858\",\"email\":\"we@11.VOM\",\"mobile\":\"EEEEEEEEEEEEE\",\"status\":0,\"roleIdList\":[1],\"deptId\":3}', 21111, '192.168.199.192', '2019-01-17 13:05:30');
INSERT INTO `sys_log` VALUES (23, 'admin', '修改用户', 'io.renren.modules.sys.controller.SysUserController.update()', '{\"userId\":16,\"username\":\"88888\",\"password\":\"136b74dba70da246ceb60e725476d1ac0cbac6ac772307a43bd8cb6f5fa1d7ca\",\"email\":\"rr2@qq.com\",\"mobile\":\"13333333333\",\"status\":1,\"roleIdList\":[1,2],\"deptId\":1}', 60, '192.168.199.192', '2019-01-17 13:06:10');
INSERT INTO `sys_log` VALUES (24, 'admin', '修改用户', 'io.renren.modules.sys.controller.SysUserController.update()', '{\"userId\":17,\"username\":\"4555555555\",\"password\":\"45e81d8107ee55b129de751ff38aaf0b92a851de8a42a79886ed56f6f995d164\",\"email\":\"we@11.com\",\"mobile\":\"EEEEEEEEEEEEE\",\"status\":1,\"roleIdList\":[1,2],\"deptId\":4}', 157, '192.168.199.192', '2019-01-17 13:06:58');
INSERT INTO `sys_log` VALUES (25, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[1]', 2, '192.168.199.192', '2019-01-17 13:07:35');
INSERT INTO `sys_log` VALUES (26, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[7]', 33, '192.168.199.192', '2019-01-17 13:26:28');
INSERT INTO `sys_log` VALUES (27, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[12]', 45, '192.168.199.192', '2019-01-17 13:26:35');
INSERT INTO `sys_log` VALUES (28, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[17]', 39, '192.168.199.192', '2019-01-17 13:29:16');
INSERT INTO `sys_log` VALUES (29, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":18,\"username\":\"2222222\",\"password\":\"3d0ba82f8401fb44a9b9d50b26717e2478c335abd98b2b327538dca307894c9d\",\"salt\":\"Uxrj9kaovoYd5pFH1l8M\",\"email\":\"2222222222222@qq.com\",\"mobile\":\"13333333333\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"Jan 17, 2019 1:31:34 PM\",\"deptId\":1}', 58, '192.168.199.192', '2019-01-17 13:31:34');
INSERT INTO `sys_log` VALUES (30, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[16]', 31, '192.168.199.192', '2019-01-17 13:45:58');
INSERT INTO `sys_log` VALUES (31, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":19,\"username\":\"ssssssssssssss\",\"password\":\"8099d37bae56ef33fa407d57d26e615dd6ff38e98f195fc07abe8324171c55aa\",\"salt\":\"DLdaBHZB9IC10gzM9yXt\",\"email\":\"we@qq.com\",\"mobile\":\"1333333333333333\",\"status\":1,\"roleIdList\":[1,2],\"createTime\":\"Jan 17, 2019 1:46:50 PM\",\"deptId\":1}', 72, '192.168.199.192', '2019-01-17 13:46:51');
INSERT INTO `sys_log` VALUES (32, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":20,\"username\":\"233333333333\",\"password\":\"681859eb2f4f672cf332ebdd2042be2bb8c5d97873205ca8f13f7af5e6c7c1ba\",\"salt\":\"eHGxfLDdZMRxTzAq9iVg\",\"email\":\"3222222222222@qq.com\",\"mobile\":\"23333\",\"status\":1,\"roleIdList\":[1,2],\"createTime\":\"Jan 17, 2019 1:47:43 PM\",\"deptId\":1}', 84, '192.168.199.192', '2019-01-17 13:47:44');
INSERT INTO `sys_log` VALUES (33, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":21,\"username\":\"1222222\",\"password\":\"c2e970fad3805937fc8538db4a88e3d267ee3c562b5828fba789108ac1852d50\",\"salt\":\"L4ceOhpascuPvwEFaQlS\",\"email\":\"4444444444@qq.com\",\"mobile\":\"444444\",\"status\":1,\"roleIdList\":[1,2],\"createTime\":\"Jan 17, 2019 1:55:29 PM\",\"deptId\":1}', 64, '192.168.199.192', '2019-01-17 13:55:30');
INSERT INTO `sys_log` VALUES (34, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[20]', 12713, '192.168.199.192', '2019-01-17 14:53:53');
INSERT INTO `sys_log` VALUES (35, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[13]', 34, '192.168.199.192', '2019-01-17 14:55:18');
INSERT INTO `sys_log` VALUES (36, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[1]', 1, '192.168.199.192', '2019-01-17 14:58:52');
INSERT INTO `sys_log` VALUES (37, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[18]', 35, '192.168.199.192', '2019-01-17 14:59:02');
INSERT INTO `sys_log` VALUES (38, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[9]', 57, '192.168.199.192', '2019-01-17 15:01:18');
INSERT INTO `sys_log` VALUES (39, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":22,\"username\":\"322222222222222\",\"password\":\"c20892092cce2f76d92d5d58e755537549bc83066e9cde27be6d584fe1d18932\",\"salt\":\"V2xy87xLtPeDzE9H1Q5M\",\"email\":\"wenbin@qq.com\",\"mobile\":\"wenbin111\",\"status\":1,\"roleIdList\":[1,2],\"createTime\":\"Jan 17, 2019 3:01:51 PM\",\"deptId\":1}', 181, '192.168.199.192', '2019-01-17 15:01:52');
INSERT INTO `sys_log` VALUES (40, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[19]', 58, '192.168.199.192', '2019-01-17 15:08:07');
INSERT INTO `sys_log` VALUES (41, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[22]', 34, '192.168.199.192', '2019-01-17 15:09:52');
INSERT INTO `sys_log` VALUES (42, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":23,\"username\":\"2333333333333\",\"password\":\"e47d65470233fd5f4568e05d749e8d06332641dd3d66d33c15448585f918c22f\",\"salt\":\"45LGefBkC3QhTbomCzvp\",\"email\":\"W2@qq.com\",\"mobile\":\"wwwwwwwwwwww\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"Jan 17, 2019 3:10:26 PM\",\"deptId\":1}', 191, '192.168.199.192', '2019-01-17 15:10:26');
INSERT INTO `sys_log` VALUES (43, 'admin', '删除用户', 'io.renren.modules.sys.controller.SysUserController.delete()', '[23]', 50, '192.168.199.192', '2019-01-17 15:11:05');
INSERT INTO `sys_log` VALUES (44, 'admin', '修改用户', 'io.renren.modules.sys.controller.SysUserController.update()', '{\"userId\":1,\"username\":\"admin1\",\"email\":\"root@renren.io\",\"mobile\":\"13612345678\",\"status\":1,\"roleIdList\":[],\"deptId\":1}', 237, '192.168.199.192', '2019-01-18 16:58:49');
INSERT INTO `sys_log` VALUES (45, 'admin', '修改用户', 'io.renren.modules.sys.controller.SysUserController.update()', '{\"userId\":1,\"username\":\"admin\",\"email\":\"root@renren.io\",\"mobile\":\"13612345678\",\"status\":1,\"roleIdList\":[],\"deptId\":1}', 46, '192.168.199.192', '2019-01-18 17:02:33');
INSERT INTO `sys_log` VALUES (1087285106692923393, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":1087285105996668930,\"username\":\"11111\",\"password\":\"320594afee0773bc6619d9169f9aae080a7a33288cc4daf9f3f2954ae42afa01\",\"salt\":\"tduZkruunFp26f6KXFXz\",\"email\":\"980680177@qq.com\",\"mobile\":\"18838987007\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"Jan 21, 2019 5:45:44 PM\",\"deptId\":1}', 456, '192.168.199.109', '2019-01-21 17:45:45');
INSERT INTO `sys_log` VALUES (1087285137487503361, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087285136321486849,\"roleName\":\"32\",\"remark\":\"32\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41],\"deptIdList\":[1,2,3,4,5],\"createTime\":\"Jan 21, 2019 5:45:51 PM\"}', 3891, '192.168.199.192', '2019-01-21 17:45:52');
INSERT INTO `sys_log` VALUES (1087285828201291777, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":1087285827949633538,\"username\":\"222222\",\"password\":\"793c619d3458968f0e83df9cdb54f274b02a6132fa2654f9777d1eb9a1307f0d\",\"salt\":\"440bBqVfa2ZZpyzdKda6\",\"email\":\"980680177@qq.com\",\"mobile\":\"13354782455\",\"status\":1,\"roleIdList\":[2,1],\"createTime\":\"Jan 21, 2019 5:48:36 PM\",\"deptId\":1}', 60, '192.168.199.109', '2019-01-21 17:48:37');
INSERT INTO `sys_log` VALUES (1087285979733106689, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":1087285979368202242,\"username\":\"323\",\"password\":\"9746f83f0e18509065a856c9a07c42999e598418605523654d2e857ebc024708\",\"salt\":\"ykh88znZgL4GCuqDiOOh\",\"email\":\"11111@qq.com\",\"mobile\":\"11111111111\",\"status\":1,\"roleIdList\":[1087285136321486800,2],\"createTime\":\"Jan 21, 2019 5:49:12 PM\",\"deptId\":2}', 89, '192.168.199.192', '2019-01-21 17:49:13');
INSERT INTO `sys_log` VALUES (1087286174797602818, 'admin', '修改用户', 'io.renren.modules.sys.controller.SysUserController.update()', '{\"userId\":1087285979368202200,\"email\":\"11111@qq.com\",\"mobile\":\"11111111111\",\"status\":1,\"roleIdList\":[2,1087285136321486800],\"deptId\":2}', 68, '192.168.199.192', '2019-01-21 17:50:00');
INSERT INTO `sys_log` VALUES (1087287784919646209, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":1087287784269529090,\"username\":\"1111\",\"password\":\"4a74dade8466d1e241f63f7f290621dacaf0dad7d21055842d8675eb7a17bdbe\",\"salt\":\"iuLmo7i9pG5MUv4pZ8uS\",\"email\":\"303316861@qq.com\",\"mobile\":\"13354782455\",\"status\":1,\"roleIdList\":[1087285136321486800,2],\"createTime\":\"Jan 21, 2019 5:56:23 PM\",\"deptId\":1}', 393, '192.168.199.109', '2019-01-21 17:56:23');
INSERT INTO `sys_log` VALUES (1087288267323277314, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087288266488610817,\"roleName\":\"43\",\"remark\":\"43\",\"deptId\":2,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41],\"deptIdList\":[1,2,3,4,5],\"createTime\":\"Jan 21, 2019 5:58:18 PM\"}', 366, '192.168.199.192', '2019-01-21 17:58:18');
INSERT INTO `sys_log` VALUES (1087288986608631810, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"username\":\"111\",\"password\":\"e787cad246f0498096e887e3b0b6bbee9e455e599d94dbd7c198b7fbbd1639b8\",\"salt\":\"xLhaxr3Ty0kMg4pY48CQ\",\"email\":\"980680177@qq.com\",\"mobile\":\"13354782455\",\"status\":1,\"roleIdList\":[2,1],\"createTime\":\"Jan 21, 2019 6:01:09 PM\",\"deptId\":1}', 376, '192.168.199.109', '2019-01-21 18:01:10');
INSERT INTO `sys_log` VALUES (1087289141986623490, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"username\":\"32\",\"password\":\"e1643229b02e9c68de5cb38299f876475ad5b00f913dbeba5e71062f38df6f10\",\"salt\":\"0AwkwXbV0pKgIS0f8CkT\",\"email\":\"qq@337.com\",\"mobile\":\"11111111111\",\"status\":1,\"roleIdList\":[2],\"createTime\":\"Jan 21, 2019 6:01:46 PM\",\"deptId\":2}', 81, '192.168.199.192', '2019-01-21 18:01:47');
INSERT INTO `sys_log` VALUES (1087289374523031554, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"username\":\"1232222\",\"password\":\"292c5c9508e67e714709ce60c665e3905ab530a439f52327a7a5418029710ea7\",\"salt\":\"JBIo2xrUASMRJVYcu4Ff\",\"email\":\"980680177@qq.com\",\"mobile\":\"13354782455\",\"status\":1,\"roleIdList\":[2],\"createTime\":\"Jan 21, 2019 6:02:42 PM\",\"deptId\":1}', 48, '192.168.199.109', '2019-01-21 18:02:42');
INSERT INTO `sys_log` VALUES (1087290458645757953, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"username\":\"00001\",\"password\":\"b692589a028bcfe91ede435f9c63850d504679fdd397d122c53ad7001cd5a0a7\",\"salt\":\"wVP86OUu7a5p6ANRJZuw\",\"email\":\"980680177@qq.com\",\"mobile\":\"13354782455\",\"status\":1,\"roleIdList\":[2],\"createTime\":\"Jan 21, 2019 6:06:29 PM\",\"deptId\":1}', 39308, '192.168.199.109', '2019-01-21 18:07:01');
INSERT INTO `sys_log` VALUES (1087290815669108738, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"username\":\"2221\",\"password\":\"aef18414b812f15b51796b09199764cb15ee93af076527c16847aecb08e6c297\",\"salt\":\"LyDVtwSlArEOOtdgkALH\",\"email\":\"980680177@qq.com\",\"mobile\":\"18838987007\",\"status\":1,\"roleIdList\":[2],\"createTime\":\"Jan 21, 2019 6:08:25 PM\",\"deptId\":1}', 5634, '192.168.199.109', '2019-01-21 18:08:26');
INSERT INTO `sys_log` VALUES (1087291914710974465, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"username\":\"13112\",\"password\":\"dbc0a806e3c39ec1333146c958b71686cf5cf5679922b0dab7d2f3333795a5f3\",\"salt\":\"tRS2ScQKYjHpMbycOlLt\",\"email\":\"980680177@qq.com\",\"mobile\":\"18838987007\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"Jan 21, 2019 6:12:47 PM\",\"deptId\":1}', 78, '192.168.199.109', '2019-01-21 18:12:48');
INSERT INTO `sys_log` VALUES (1087292147373211649, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"username\":\"00024\",\"password\":\"80f5fd00e9a78446cffa7dde9c49cf73ecd55bd00cefe322f8984cebe85f18d8\",\"salt\":\"wGrli2wUe188lZ7CD5uL\",\"email\":\"980680177@qq.com\",\"mobile\":\"18801474720\",\"status\":1,\"roleIdList\":[1087285136321486800],\"createTime\":\"Jan 21, 2019 6:13:43 PM\",\"deptId\":3}', 100, '192.168.199.109', '2019-01-21 18:13:44');
INSERT INTO `sys_log` VALUES (1087292289195212802, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087292288461209601,\"roleName\":\"43444\",\"remark\":\"444\",\"deptId\":4,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41],\"deptIdList\":[1,2,3,4,5],\"createTime\":\"Jan 21, 2019 6:14:17 PM\"}', 181, '192.168.199.192', '2019-01-21 18:14:17');
INSERT INTO `sys_log` VALUES (1087293656399994882, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":1087293655963787265,\"username\":\"101\",\"password\":\"555d015beb89d3e826686dbd8916a252979e8d8ccadfd1a0de7f58ed9db5dea9\",\"salt\":\"aenbCmDexth7YPoVkdoY\",\"email\":\"980680177@qq.com\",\"mobile\":\"13354782455\",\"status\":1,\"roleIdList\":[1087285136321486800],\"createTime\":\"Jan 21, 2019 6:19:43 PM\",\"deptId\":1}', 353, '192.168.199.109', '2019-01-21 18:19:43');
INSERT INTO `sys_log` VALUES (1087294954386087937, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":1087294953782108161,\"username\":\"4343\",\"password\":\"2a75a09848fed0d5e9479b37397fa093b93ee63413c19aa1e323fda9b73e0f44\",\"salt\":\"ZtAHRGEsFJzIaKZ6IZnZ\",\"email\":\"wenbin@qq.com\",\"mobile\":\"11111111111\",\"status\":1,\"roleIdList\":[2,1087285136321486800],\"createTime\":\"Jan 21, 2019 6:24:52 PM\",\"deptId\":2}', 145, '192.168.199.192', '2019-01-21 18:24:53');
INSERT INTO `sys_log` VALUES (1087295186016526337, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":1087295185181859842,\"username\":\"11111111\",\"password\":\"79aaaa5ea187b4e2df1a224a21ef4a88644c5f128ea3e8d0b0e711eac944ea04\",\"salt\":\"rQv9LLM1Ets07R0NmxoZ\",\"email\":\"111111@qq.com\",\"mobile\":\"32323333333\",\"status\":1,\"roleIdList\":[2],\"createTime\":\"Jan 21, 2019 6:25:47 PM\",\"deptId\":1}', 199, '192.168.199.192', '2019-01-21 18:25:48');
INSERT INTO `sys_log` VALUES (1087530556087865346, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087530554628247553,\"roleName\":\"3333\",\"remark\":\"3333\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41],\"deptIdList\":[1,2,3,4,5],\"createTime\":\"Jan 22, 2019 10:01:04 AM\"}', 434, '192.168.199.192', '2019-01-22 10:01:05');
INSERT INTO `sys_log` VALUES (1087538766165364738, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":1087538765888540674,\"username\":\"123\",\"password\":\"0c5fc843d6824ded941319ffe6bff0296b274c0e5c21efc9d0712ede39416e1a\",\"salt\":\"mdABojOln8PFyn3RvCuC\",\"email\":\"980680177@qq.com\",\"mobile\":\"13354782455\",\"status\":1,\"roleIdList\":[2],\"createTime\":\"Jan 22, 2019 10:33:41 AM\",\"deptId\":1}', 290, '192.168.199.109', '2019-01-22 10:33:42');
INSERT INTO `sys_log` VALUES (1087545051510263809, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":1087545051317325825,\"username\":\"111\",\"password\":\"e77756a2072aeacf53ad9ac8cab09364097871e42773c827aae13b8e7f4192c9\",\"salt\":\"s5EcUsAowNtRnmkA2TW1\",\"email\":\"980680177@qq.com\",\"mobile\":\"13354782455\",\"status\":1,\"roleIdList\":[2],\"createTime\":\"Jan 22, 2019 10:58:40 AM\",\"deptId\":1}', 45, '192.168.199.109', '2019-01-22 10:58:41');
INSERT INTO `sys_log` VALUES (1087587445597323265, 'admin', '修改角色', 'io.renren.modules.sys.controller.SysRoleController.update()', '{\"roleId\":1087530554628247600,\"roleName\":\"666\",\"remark\":\"6666\",\"deptId\":2,\"menuIdList\":[3,5,19,20,21,22,29,30,36,37,38,39,40,41],\"deptIdList\":[]}', 341, '192.168.199.192', '2019-01-22 13:47:08');
INSERT INTO `sys_log` VALUES (1087588029243113473, 'admin', '修改角色', 'io.renren.modules.sys.controller.SysRoleController.update()', '{\"roleId\":1087530554628247600,\"roleName\":\"666\",\"remark\":\"666\",\"deptId\":1,\"menuIdList\":[4,5,6,7,8,9,10,11,12,13,14,23,24,25,26,27,29,30,36,37,38,39,40,41],\"deptIdList\":[2]}', 79532, '192.168.199.192', '2019-01-22 13:49:27');
INSERT INTO `sys_log` VALUES (1087588313549815809, 'admin', '修改角色', 'io.renren.modules.sys.controller.SysRoleController.update()', '{\"roleId\":1087530554628247600,\"roleName\":\"3333\",\"remark\":\"3333999\",\"deptId\":1,\"menuIdList\":[],\"deptIdList\":[1,2,3,4,5]}', 27171, '192.168.199.192', '2019-01-22 13:50:35');
INSERT INTO `sys_log` VALUES (1087588771383263233, 'admin', '修改角色', 'io.renren.modules.sys.controller.SysRoleController.update()', '{\"roleId\":1,\"roleName\":\"test\",\"remark\":\"767676\",\"deptId\":2,\"menuIdList\":[1,2,15,16,17,18,3,19,20,21,22,4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,31,32,33,34,35,36,37,38,39,40],\"deptIdList\":[1,2,3,4,5]}', 20358, '192.168.199.192', '2019-01-22 13:52:24');
INSERT INTO `sys_log` VALUES (1087588952598167554, 'admin', '修改角色', 'io.renren.modules.sys.controller.SysRoleController.update()', '{\"roleId\":1,\"roleName\":\"test\",\"remark\":\"65656\",\"deptId\":2,\"menuIdList\":[],\"deptIdList\":[1,2,3,4,5]}', 166, '192.168.199.192', '2019-01-22 13:53:07');
INSERT INTO `sys_log` VALUES (1087589032549990401, 'admin', '修改角色', 'io.renren.modules.sys.controller.SysRoleController.update()', '{\"roleId\":2,\"roleName\":\"testone\",\"remark\":\"878787\",\"deptId\":4,\"menuIdList\":[1,2,15,16,17,18,3,19,20,21,22,4,23,24,25,26,5,6,7,8,9,10,11,12,13,14,27,29,30,31,32,33,34,35,36,37,38,39,40],\"deptIdList\":[1,2,3,4,5]}', 227, '192.168.199.192', '2019-01-22 13:53:26');
INSERT INTO `sys_log` VALUES (1087589069673775106, 'admin', '修改角色', 'io.renren.modules.sys.controller.SysRoleController.update()', '{\"roleId\":1087285136321486800,\"roleName\":\"32\",\"remark\":\"878787\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41],\"deptIdList\":[]}', 48, '192.168.199.192', '2019-01-22 13:53:35');
INSERT INTO `sys_log` VALUES (1087608018847211522, 'admin', '保存用户', 'io.renren.modules.sys.controller.SysUserController.save()', '{\"userId\":1087608018549415937,\"username\":\"1111\",\"password\":\"eadd0b6a12515072b7a2bc458277358f21e53297f824396b010ac36c0ecb0276\",\"salt\":\"myH6s48LiPKyQ7dhWcA7\",\"email\":\"980680177@qq.com\",\"mobile\":\"13354782455\",\"status\":1,\"roleIdList\":[2],\"createTime\":\"Jan 22, 2019 3:08:52 PM\",\"deptId\":1}', 299, '192.168.199.109', '2019-01-22 15:08:53');
INSERT INTO `sys_log` VALUES (1087609022770630657, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleName\":\"123\",\"remark\":\"123\",\"deptId\":1,\"menuIdList\":[2,15,16,17,18],\"deptIdList\":[1,2,3,4,5],\"createTime\":\"Jan 22, 2019 3:12:52 PM\"}', 281, '192.168.199.109', '2019-01-22 15:12:52');
INSERT INTO `sys_log` VALUES (1087611769905545218, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087611769540640769,\"roleName\":\"11111\",\"remark\":\"11111\",\"deptId\":1,\"menuIdList\":[],\"deptIdList\":[1,2,3,4,5],\"createTime\":\"Jan 22, 2019 3:23:47 PM\"}', 274, '192.168.199.109', '2019-01-22 15:23:47');
INSERT INTO `sys_log` VALUES (1087611769905545219, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087611769540640770,\"roleName\":\"111\",\"remark\":\"111\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41],\"deptIdList\":[1,2,3,4,5],\"createTime\":\"Jan 22, 2019 3:32:12 PM\"}', 194, '192.168.199.109', '2019-01-22 15:32:13');
INSERT INTO `sys_log` VALUES (1087611769905545220, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087611769540640771,\"roleName\":\"121\",\"remark\":\"1222\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41],\"deptIdList\":[1,2,3,4,5],\"createTime\":\"Jan 22, 2019 3:33:42 PM\"}', 198, '192.168.199.109', '2019-01-22 15:33:43');
INSERT INTO `sys_log` VALUES (1087620602598027265, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087620602119876609,\"roleName\":\"123\",\"remark\":\"111\",\"deptId\":1,\"menuIdList\":[],\"deptIdList\":[1,2,3,4,5],\"createTime\":\"Jan 22, 2019 3:58:53 PM\"}', 299, '192.168.199.109', '2019-01-22 15:58:53');
INSERT INTO `sys_log` VALUES (1087620602598027266, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087620602119876610,\"roleName\":\"123222\",\"remark\":\"22222\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41],\"deptIdList\":[1,2,3,4,5],\"createTime\":\"Jan 22, 2019 4:01:47 PM\"}', 400, '192.168.199.109', '2019-01-22 16:01:48');
INSERT INTO `sys_log` VALUES (1087620602598027267, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087620602119876611,\"roleName\":\"0001\",\"remark\":\"11110\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41],\"deptIdList\":[1,2,3,4,5],\"createTime\":\"Jan 22, 2019 4:05:39 PM\"}', 182, '192.168.199.109', '2019-01-22 16:05:40');
INSERT INTO `sys_log` VALUES (1087620602598027268, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087620602119876612,\"roleName\":\"aa\",\"remark\":\"ssss\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41],\"deptIdList\":[1,2,3,4,5],\"createTime\":\"Jan 22, 2019 4:44:39 PM\"}', 213, '192.168.199.109', '2019-01-22 16:44:40');
INSERT INTO `sys_log` VALUES (1087620602598027269, 'admin', '修改角色', 'io.renren.modules.sys.controller.SysRoleController.update()', '{\"roleId\":1,\"roleName\":\"test\",\"remark\":\"65656\",\"deptId\":2,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41],\"deptIdList\":[1,2,3,4,5]}', 145, '192.168.199.192', '2019-01-22 17:45:50');
INSERT INTO `sys_log` VALUES (1087620602598027270, 'admin', '删除角色', 'io.renren.modules.sys.controller.SysRoleController.delete()', '[1087530554628247554]', 39, '192.168.199.192', '2019-01-22 17:46:00');
INSERT INTO `sys_log` VALUES (1087620602598027271, 'admin', '保存角色', 'io.renren.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087620602119876613,\"roleName\":\"54\",\"remark\":\"54\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41],\"deptIdList\":[1,2,3,4,5],\"createTime\":\"Jan 22, 2019 6:11:19 PM\"}', 126, '192.168.199.192', '2019-01-22 18:11:19');
INSERT INTO `sys_log` VALUES (1087620602598027272, 'admin', '修改角色', 'io.renren.modules.sys.controller.SysRoleController.update()', '{\"roleId\":1087620602119876613,\"roleName\":\"54\",\"remark\":\"54666\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41],\"deptIdList\":[]}', 96, '192.168.199.192', '2019-01-22 18:11:39');
INSERT INTO `sys_log` VALUES (1087620602598027273, 'admin', '保存定时任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.save()', '{\"jobId\":3,\"beanName\":\"testTask\",\"methodName\":\"test2\",\"params\":\"\",\"cronExpression\":\"0 0/30 * * * ?\",\"status\":0,\"remark\":\"无参数测试\",\"createTime\":\"Jan 24, 2019 5:47:56 PM\"}', 276, '192.168.199.239', '2019-01-24 17:47:57');
INSERT INTO `sys_log` VALUES (1087620602598027274, 'admin', '修改定时任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.update()', '{\"jobId\":3,\"beanName\":\"testTask\",\"methodName\":\"test2\",\"params\":\"1111111111\",\"cronExpression\":\"0 0/30 * * * ?\",\"status\":0,\"remark\":\"有参数测试\",\"createTime\":\"Jan 24, 2019 5:47:56 PM\"}', 340, '192.168.199.239', '2019-01-24 17:48:14');
INSERT INTO `sys_log` VALUES (1087620602598027275, 'admin', '修改定时任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.update()', '{\"jobId\":3,\"beanName\":\"testTask\",\"methodName\":\"test2eee\",\"params\":\"1111111111\",\"cronExpression\":\"0 0/30 * * * ?\",\"status\":0,\"remark\":\"有参数测试\",\"createTime\":\"Jan 24, 2019 5:47:56 PM\"}', 254, '192.168.199.239', '2019-01-24 17:57:01');
INSERT INTO `sys_log` VALUES (1087620602598027276, 'admin', '修改定时任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.update()', '{\"jobId\":3,\"beanName\":\"testTask333\",\"methodName\":\"test2eee333\",\"params\":\"1111111111\",\"cronExpression\":\"0 0/30 * * * ?\",\"status\":0,\"remark\":\"有参数测试\",\"createTime\":\"Jan 24, 2019 5:47:56 PM\"}', 159, '192.168.199.239', '2019-01-24 17:58:16');
INSERT INTO `sys_log` VALUES (1087620602598027277, 'admin', '修改定时任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.update()', '{\"jobId\":3,\"beanName\":\"testTask33354545\",\"methodName\":\"test2eee33354545\",\"params\":\"1111111111\",\"cronExpression\":\"0 0/30 * * * ?\",\"status\":0,\"remark\":\"有参数测试\",\"createTime\":\"Jan 24, 2019 5:47:56 PM\"}', 210, '192.168.199.239', '2019-01-24 18:00:36');
INSERT INTO `sys_log` VALUES (1087620602598027278, 'admin', '暂停定时任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.pause()', '[3]', 135, '192.168.199.239', '2019-01-24 18:35:30');
INSERT INTO `sys_log` VALUES (1087620602598027279, 'admin', '恢复定时任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.resume()', '[3]', 96, '192.168.199.239', '2019-01-24 18:36:25');
INSERT INTO `sys_log` VALUES (1087620602598027280, 'admin', '立即执行任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.run()', '[3]', 88, '192.168.199.239', '2019-01-24 18:36:46');
INSERT INTO `sys_log` VALUES (1087620602598027281, 'admin', '修改定时任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.update()', '{\"jobId\":3,\"beanName\":\"testTask\",\"methodName\":\"test\",\"params\":\"1111111111\",\"cronExpression\":\"0 0/30 * * * ?\",\"status\":0,\"remark\":\"有参数测试\",\"createTime\":\"Jan 24, 2019 5:47:56 PM\"}', 63, '192.168.199.239', '2019-01-24 18:37:49');
INSERT INTO `sys_log` VALUES (1087620602598027282, 'admin', '立即执行任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.run()', '[3]', 36, '192.168.199.239', '2019-01-24 18:38:01');
INSERT INTO `sys_log` VALUES (1087620602598027283, 'admin', '修改定时任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.update()', '{\"jobId\":3,\"beanName\":\"testTask\",\"methodName\":\"test\",\"params\":\"1111111111\",\"cronExpression\":\"0/5 * * * * ?\",\"status\":0,\"remark\":\"有参数测试\",\"createTime\":\"Jan 24, 2019 5:47:56 PM\"}', 157, '192.168.199.239', '2019-01-24 18:40:12');
INSERT INTO `sys_log` VALUES (1087620602598027284, 'admin', '修改定时任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.update()', '{\"jobId\":3,\"beanName\":\"testTask\",\"methodName\":\"test\",\"params\":\"1111111111\",\"cronExpression\":\"0 0/30 * * * ?\",\"status\":0,\"remark\":\"有参数测试\",\"createTime\":\"Jan 24, 2019 5:47:56 PM\"}', 123, '192.168.199.239', '2019-01-24 18:42:33');
INSERT INTO `sys_log` VALUES (1087620602598027285, 'admin', '修改菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.update()', '{\"menuId\":1,\"parentId\":0,\"name\":\"系统管理0\",\"path\":\"/system-manager\",\"type\":0,\"icon\":\"setting\",\"orderNum\":0}', 43, '192.168.199.239', '2019-01-24 18:43:00');
INSERT INTO `sys_log` VALUES (1087620602598027286, 'admin', '修改菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.update()', '{\"menuId\":1,\"parentId\":0,\"name\":\"系统管理\",\"path\":\"/system-manager\",\"type\":0,\"icon\":\"setting\",\"orderNum\":0}', 52, '0:0:0:0:0:0:0:1', '2019-01-25 16:48:24');
INSERT INTO `sys_log` VALUES (1087620602598027287, 'admin', '保存配置', 'com.winnerdt.modules.sys.controller.SysConfigController.save()', '{\"id\":3,\"paramKey\":\"323233\",\"paramValue\":\"33333232\",\"remark\":\"323\"}', 51, '192.168.199.192', '2019-01-28 15:10:43');
INSERT INTO `sys_log` VALUES (1087620602598027288, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087620602119876614,\"roleName\":\"65\",\"remark\":\"666\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41],\"deptIdList\":[1,2,3,4,5],\"createTime\":\"Jan 28, 2019 3:14:46 PM\"}', 302, '192.168.199.192', '2019-01-28 15:14:46');
INSERT INTO `sys_log` VALUES (1087620602598027289, 'admin', '保存用户', 'com.winnerdt.modules.sys.controller.SysUserController.save()', '{\"userId\":1087608018549415938,\"username\":\"111112\",\"password\":\"cac949cc797a864cd8f6e8a832817d827d42943f2e790ba76262808013105832\",\"salt\":\"X8f0wYhZDMMoKa1S1cuW\",\"email\":\"303314582@qq.com\",\"mobile\":\"12322548654\",\"status\":1,\"roleIdList\":[1],\"createTime\":\"Jan 29, 2019 3:01:22 PM\",\"deptId\":1}', 95, '0:0:0:0:0:0:0:1', '2019-01-29 15:01:23');
INSERT INTO `sys_log` VALUES (1087620602598027290, 'admin', '删除用户', 'com.winnerdt.modules.sys.controller.SysUserController.delete()', '[1087608018549415938]', 64, '0:0:0:0:0:0:0:1', '2019-01-29 15:01:53');
INSERT INTO `sys_log` VALUES (1087620602598027291, 'admin', '保存菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.save()', '{\"menuId\":42,\"parentId\":30,\"name\":\"查看\",\"perms\":\"sys:oss:list\",\"type\":2,\"orderNum\":1}', 50, '192.168.199.109', '2019-01-30 15:16:45');
INSERT INTO `sys_log` VALUES (1087620602598027292, 'admin', '保存菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.save()', '{\"menuId\":43,\"parentId\":30,\"name\":\"新增\",\"perms\":\"sys:oss:save\",\"type\":2,\"orderNum\":2}', 32, '192.168.199.109', '2019-01-30 15:17:20');
INSERT INTO `sys_log` VALUES (1087620602598027293, 'admin', '保存菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.save()', '{\"menuId\":44,\"parentId\":30,\"name\":\"上传\",\"perms\":\"sys:oss:upload\",\"type\":2,\"orderNum\":3}', 37, '192.168.199.109', '2019-01-30 15:17:51');
INSERT INTO `sys_log` VALUES (1087620602598027294, 'admin', '保存菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.save()', '{\"menuId\":45,\"parentId\":30,\"name\":\"删除\",\"perms\":\"sys:oss:delete\",\"type\":2,\"orderNum\":4}', 33, '192.168.199.109', '2019-01-30 15:18:19');
INSERT INTO `sys_log` VALUES (1087620602598027295, 'admin', '保存菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.save()', '{\"menuId\":46,\"parentId\":27,\"name\":\"查看\",\"perms\":\"sys:config:list,sys:config:info\",\"type\":2,\"orderNum\":1}', 49, '192.168.199.192', '2019-01-30 15:44:36');
INSERT INTO `sys_log` VALUES (1087620602598027296, 'admin', '保存菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.save()', '{\"menuId\":47,\"parentId\":27,\"name\":\"删除\",\"perms\":\"sys:config:delete\",\"type\":2,\"orderNum\":1}', 46, '192.168.199.192', '2019-01-30 15:45:21');
INSERT INTO `sys_log` VALUES (1087620602598027297, 'admin', '保存菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.save()', '{\"menuId\":48,\"parentId\":27,\"name\":\"修改\",\"perms\":\"sys:config:update\",\"type\":2,\"orderNum\":1}', 49, '192.168.199.192', '2019-01-30 15:45:56');
INSERT INTO `sys_log` VALUES (1087620602598027298, 'admin', '保存菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.save()', '{\"menuId\":49,\"parentId\":27,\"name\":\"添加\",\"perms\":\"sys:config:save\",\"type\":2,\"orderNum\":1}', 41, '192.168.199.192', '2019-01-30 15:46:30');
INSERT INTO `sys_log` VALUES (1087620602598027299, 'admin', '保存菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.save()', '{\"menuId\":50,\"parentId\":29,\"name\":\"查看\",\"perms\":\"sys:log:list\",\"type\":2,\"orderNum\":1}', 28, '192.168.199.192', '2019-01-30 15:53:10');
INSERT INTO `sys_log` VALUES (1087620602598027300, 'admin', '保存定时任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.save()', '{\"jobId\":4,\"beanName\":\"testTask\",\"methodName\":\"test2\",\"params\":\"xsxasxasxsx\",\"cronExpression\":\"0 0/30 * * * ?\",\"status\":0,\"remark\":\"dscsdcscs\",\"createTime\":\"Jan 30, 2019 4:22:37 PM\"}', 465, '192.168.199.192', '2019-01-30 16:22:38');
INSERT INTO `sys_log` VALUES (1087620602598027301, 'admin', '暂停定时任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.pause()', '[3]', 220, '192.168.199.192', '2019-01-30 16:55:02');
INSERT INTO `sys_log` VALUES (1087620602598027302, 'admin', '保存菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.save()', '{\"menuId\":51,\"parentId\":41,\"name\":\"查看\",\"perms\":\"sys:oss:list\",\"type\":2,\"icon\":\"step-forward\",\"orderNum\":12}', 111, '0:0:0:0:0:0:0:1', '2019-02-12 10:03:16');
INSERT INTO `sys_log` VALUES (1087620602598027303, 'admin', '保存菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.save()', '{\"menuId\":52,\"parentId\":41,\"name\":\"te\",\"perms\":\"ds\",\"type\":2,\"icon\":\"caret-up\",\"orderNum\":1}', 75, '192.168.199.192', '2019-02-12 10:13:24');
INSERT INTO `sys_log` VALUES (1087620602598027304, 'admin', '删除定时任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.delete()', '[3]', 345, '192.168.199.192', '2019-02-12 10:14:48');
INSERT INTO `sys_log` VALUES (1087620602598027305, 'admin', '修改菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.update()', '{\"menuId\":52,\"parentId\":41,\"name\":\"tetttt\",\"perms\":\"ds\",\"type\":2,\"icon\":\"caret-up\",\"orderNum\":1}', 45, '192.168.199.192', '2019-02-12 10:15:29');
INSERT INTO `sys_log` VALUES (1087620602598027306, 'admin', '删除菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.delete()', '51', 51, '0:0:0:0:0:0:0:1', '2019-02-12 10:19:26');
INSERT INTO `sys_log` VALUES (1087620602598027307, 'admin', '删除菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.delete()', '52', 47, '0:0:0:0:0:0:0:1', '2019-02-12 10:20:31');
INSERT INTO `sys_log` VALUES (1087620602598027308, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087620602119876615,\"roleName\":\"test\",\"deptId\":0,\"menuIdList\":[],\"deptIdList\":[],\"createTime\":\"Feb 14, 2019 1:40:41 PM\"}', 398, '192.168.199.192', '2019-02-14 13:40:42');
INSERT INTO `sys_log` VALUES (1087620602598027309, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087620602119876616,\"roleName\":\"test\",\"deptId\":0,\"menuIdList\":[],\"deptIdList\":[],\"createTime\":\"Feb 14, 2019 1:42:36 PM\"}', 83, '192.168.199.192', '2019-02-14 13:42:36');
INSERT INTO `sys_log` VALUES (1087620602598027310, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087620602119876617,\"roleName\":\"ctest\",\"deptId\":0,\"menuIdList\":[],\"deptIdList\":[],\"createTime\":\"Feb 14, 2019 1:46:10 PM\"}', 56, '192.168.199.192', '2019-02-14 13:46:11');
INSERT INTO `sys_log` VALUES (1087620602598027311, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087620602119876618,\"roleName\":\"tests\",\"deptId\":0,\"menuIdList\":[],\"deptIdList\":[],\"createTime\":\"Feb 14, 2019 1:46:47 PM\"}', 117, '192.168.199.192', '2019-02-14 13:46:48');
INSERT INTO `sys_log` VALUES (1087620602598027312, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"nickName\":\"master11\",\"password\":\"111111\",\"email\":\"root@renren.io11\",\"mobile\":\"11111111111\",\"signature\":\"今天也是充满希望的一天11\"}', 21780, '192.168.199.192', '2019-02-15 13:28:41');
INSERT INTO `sys_log` VALUES (1087620602598027313, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"nickName\":\"\",\"email\":\"\",\"mobile\":\"\",\"signature\":\"\"}', 10353, '192.168.199.192', '2019-02-15 13:31:43');
INSERT INTO `sys_log` VALUES (1087620602598027314, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"nickName\":\"\",\"email\":\"\",\"mobile\":\"\",\"signature\":\"\"}', 21467, '192.168.199.192', '2019-02-15 13:40:36');
INSERT INTO `sys_log` VALUES (1087620602598027315, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"nickName\":\"\",\"email\":\"\",\"mobile\":\"\",\"signature\":\"\"}', 24470, '192.168.199.192', '2019-02-15 13:45:05');
INSERT INTO `sys_log` VALUES (1087620602598027316, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"nickName\":\"\",\"email\":\"\",\"mobile\":\"\",\"signature\":\"\"}', 17967, '192.168.199.192', '2019-02-15 13:47:31');
INSERT INTO `sys_log` VALUES (1087620602598027317, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"email\":\"\"}', 25340, '192.168.199.192', '2019-02-15 13:53:23');
INSERT INTO `sys_log` VALUES (1087620602598027318, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"nickName\":\"\",\"email\":\"\",\"mobile\":\"\",\"signature\":\"\"}', 22914, '192.168.199.192', '2019-02-15 14:04:10');
INSERT INTO `sys_log` VALUES (1087620602598027319, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"nickName\":\"\",\"email\":\"\",\"mobile\":\"\",\"signature\":\"\"}', 31633, '192.168.199.192', '2019-02-15 14:06:55');
INSERT INTO `sys_log` VALUES (1087620602598027320, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"nickName\":\"\",\"email\":\"\",\"mobile\":\"\",\"signature\":\"\"}', 42547, '0:0:0:0:0:0:0:1', '2019-02-15 14:42:59');
INSERT INTO `sys_log` VALUES (1087620602598027321, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"nickName\":\"\",\"email\":\"\",\"mobile\":\"\",\"signature\":\"\"}', 5670, '0:0:0:0:0:0:0:1', '2019-02-15 14:44:56');
INSERT INTO `sys_log` VALUES (1087620602598027322, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"nickName\":\"\",\"email\":\"\",\"mobile\":\"456456\",\"signature\":\"\"}', 61653, '0:0:0:0:0:0:0:1', '2019-02-15 15:03:15');
INSERT INTO `sys_log` VALUES (1087620602598027323, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"nickName\":\"\",\"mobile\":\"456456\"}', 5676, '0:0:0:0:0:0:0:1', '2019-02-15 15:31:29');
INSERT INTO `sys_log` VALUES (1087620602598027324, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{}', 7932, '0:0:0:0:0:0:0:1', '2019-02-15 15:32:01');
INSERT INTO `sys_log` VALUES (1087620602598027325, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"nickName\":\"\",\"email\":\"\",\"mobile\":\"\"}', 15674, '0:0:0:0:0:0:0:1', '2019-02-15 15:32:36');
INSERT INTO `sys_log` VALUES (1087620602598027326, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"nickName\":\"\",\"email\":\"\"}', 14040, '0:0:0:0:0:0:0:1', '2019-02-15 15:36:25');
INSERT INTO `sys_log` VALUES (1087620602598027327, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.updateBasic()', '{\"userId\":1,\"email\":\"\",\"mobile\":\"\",\"signature\":\"\"}', 5890, '0:0:0:0:0:0:0:1', '2019-02-15 15:36:51');
INSERT INTO `sys_log` VALUES (1087620602598027328, 'admin', '保存用户', 'com.winnerdt.modules.sys.controller.SysUserController.save()', '{\"userId\":2,\"username\":\"test\",\"password\":\"d0d0a12ffccaf9da372cb8f66663326f321d76f97da87e63119527483064ee8d\",\"salt\":\"64WvfJ58L2YYNhVrLOD5\",\"email\":\"q@q.com\",\"mobile\":\"11111111111\",\"status\":1,\"roleIdList\":[\"1\",\"1087620602119876614\"],\"createTime\":\"Feb 15, 2019 6:23:37 PM\",\"deptId\":1}', 248, '192.168.199.192', '2019-02-15 18:23:38');
INSERT INTO `sys_log` VALUES (1087620602598027329, 'admin', '保存用户', 'com.winnerdt.modules.sys.controller.SysUserController.save()', '{\"userId\":3,\"username\":\"teywteyw\",\"password\":\"0a1ade81f7129dd4fa42ca8cd8adac668649cc88456d969b89de6601a1fa5f79\",\"salt\":\"QpW0JznfOZvuNG4hhB1W\",\"email\":\"q@q.com\",\"mobile\":\"11111111111\",\"status\":1,\"createTime\":\"Feb 15, 2019 6:26:07 PM\",\"deptId\":1}', 47, '192.168.199.192', '2019-02-15 18:26:08');
INSERT INTO `sys_log` VALUES (1087620602598027330, 'admin', '保存用户', 'com.winnerdt.modules.sys.controller.SysUserController.save()', '{\"userId\":4,\"username\":\"122222\",\"password\":\"c1a3ff99551ae2add13af41cd11899b05fd6eb2fe1eba58fe9fb1066a7568d17\",\"salt\":\"h9sZtXAWbtrd3NXyo8PB\",\"email\":\"q@q.com\",\"mobile\":\"11111111111\",\"status\":1,\"roleIdList\":[\"1\",\"1087620602119876614\"],\"createTime\":\"Feb 15, 2019 6:26:49 PM\",\"deptId\":1}', 52, '192.168.199.192', '2019-02-15 18:26:49');
INSERT INTO `sys_log` VALUES (1087620602598027331, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.update()', '{\"userId\":3,\"email\":\"q@q.com\",\"mobile\":\"11111111111\",\"status\":1,\"roleIdList\":[1,1087620602119876600],\"deptId\":1}', 54, '192.168.199.192', '2019-02-15 18:31:55');
INSERT INTO `sys_log` VALUES (1087620602598027332, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.update()', '{\"userId\":3,\"email\":\"q@q.com\",\"mobile\":\"11111111111\",\"status\":1,\"roleIdList\":[\"1\",\"1087620602119876614\"],\"deptId\":1}', 189, '192.168.199.192', '2019-02-15 18:37:51');
INSERT INTO `sys_log` VALUES (1087620602598027333, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1087620602119876619,\"roleName\":\"222\",\"remark\":\"12312\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],\"deptIdList\":[],\"createTime\":\"Feb 18, 2019 5:01:40 PM\"}', 376, '0:0:0:0:0:0:0:1', '2019-02-18 17:01:41');
INSERT INTO `sys_log` VALUES (1097422153789251586, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1097422153298518018,\"roleName\":\"dddf\",\"remark\":\"dddd\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],\"deptIdList\":[],\"createTime\":\"Feb 18, 2019 5:06:44 PM\"}', 316, '0:0:0:0:0:0:0:1', '2019-02-18 17:06:45');
INSERT INTO `sys_log` VALUES (1097426426174427138, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1097422153298518019,\"roleName\":\"333\",\"remark\":\"333\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],\"deptIdList\":[],\"createTime\":\"Feb 18, 2019 5:23:43 PM\"}', 381, '0:0:0:0:0:0:0:1', '2019-02-18 17:23:44');
INSERT INTO `sys_log` VALUES (1097426478708084738, 'admin', '删除角色', 'com.winnerdt.modules.sys.controller.SysRoleController.delete()', '[1097422153298518019]', 132, '0:0:0:0:0:0:0:1', '2019-02-18 17:23:56');
INSERT INTO `sys_log` VALUES (1097426504104595457, 'admin', '删除角色', 'com.winnerdt.modules.sys.controller.SysRoleController.delete()', '[1097422153298518018]', 59, '0:0:0:0:0:0:0:1', '2019-02-18 17:24:02');
INSERT INTO `sys_log` VALUES (1097426521934581762, 'admin', '删除角色', 'com.winnerdt.modules.sys.controller.SysRoleController.delete()', '[1087620602119876619]', 38, '0:0:0:0:0:0:0:1', '2019-02-18 17:24:07');
INSERT INTO `sys_log` VALUES (1097783262002032642, 'admin', '保存菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.save()', '{\"menuId\":1097783261695848449,\"parentId\":1,\"name\":\"试试\",\"path\":\"/system-manager/admin-manager\",\"perms\":\"sys:test\",\"type\":1,\"icon\":\"backward\",\"orderNum\":1,\"locale\":\"menu.systemMmanager.adminMmanager\"}', 57, '0:0:0:0:0:0:0:1', '2019-02-19 17:01:40');
INSERT INTO `sys_log` VALUES (1098154412725088258, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1098154412112719873,\"roleName\":\"12345\",\"remark\":\"3322\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],\"deptIdList\":[],\"createTime\":\"Feb 20, 2019 5:36:29 PM\"}', 342, '0:0:0:0:0:0:0:1', '2019-02-20 17:36:29');
INSERT INTO `sys_log` VALUES (1098415757022318594, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1098415756145709058,\"roleName\":\"332344\",\"remark\":\"222334\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],\"deptIdList\":[],\"createTime\":\"Feb 21, 2019 10:54:58 AM\"}', 459, '0:0:0:0:0:0:0:1', '2019-02-21 10:54:59');
INSERT INTO `sys_log` VALUES (1098431558701871106, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1098431558068531201,\"roleName\":\"1000\",\"remark\":\"1010\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],\"deptIdList\":[],\"createTime\":\"Feb 21, 2019 11:57:45 AM\"}', 351, '0:0:0:0:0:0:0:1', '2019-02-21 11:57:46');
INSERT INTO `sys_log` VALUES (1098431558701871107, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1098431558068531202,\"roleName\":\"1002\",\"remark\":\"2220\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],\"deptIdList\":[],\"createTime\":\"Feb 21, 2019 2:24:02 PM\"}', 269, '0:0:0:0:0:0:0:1', '2019-02-21 14:24:03');
INSERT INTO `sys_log` VALUES (1098431558701871108, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1098431558068531203,\"roleName\":\"112\",\"remark\":\"221\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],\"deptIdList\":[],\"createTime\":\"Feb 21, 2019 2:24:35 PM\"}', 96, '0:0:0:0:0:0:0:1', '2019-02-21 14:24:35');
INSERT INTO `sys_log` VALUES (1098431558701871109, 'admin', '保存菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.save()', '{\"menuId\":51,\"parentId\":1,\"name\":\"水电费\",\"path\":\"沙发\",\"perms\":\"阿阿斯顿\",\"type\":1,\"orderNum\":11,\"locale\":\"menu沙发\"}', 50, '0:0:0:0:0:0:0:1', '2019-02-21 14:25:51');
INSERT INTO `sys_log` VALUES (1098431558701871110, 'admin', '保存用户', 'com.winnerdt.modules.sys.controller.SysUserController.save()', '{\"userId\":4,\"username\":\"12313\",\"password\":\"575abe148ca8cac7dc1f9f09f29d791fefe079995537b25ed1e2056952416621\",\"salt\":\"XX8X9T3hfhfPzyCGzJfR\",\"email\":\"643935700@qq.con\",\"mobile\":\"13245685210\",\"status\":1,\"roleIdList\":[\"1098431558068531203\"],\"createTime\":\"Feb 21, 2019 2:27:02 PM\",\"deptId\":1}', 93, '0:0:0:0:0:0:0:1', '2019-02-21 14:27:02');
INSERT INTO `sys_log` VALUES (1098431558701871111, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1098431558068531204,\"roleName\":\"123123\",\"remark\":\"12122\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51],\"deptIdList\":[],\"createTime\":\"Feb 21, 2019 2:27:55 PM\"}', 71, '0:0:0:0:0:0:0:1', '2019-02-21 14:27:56');
INSERT INTO `sys_log` VALUES (1098431558701871112, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1098431558068531205,\"roleName\":\"打发\",\"remark\":\"是是是\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51],\"deptIdList\":[],\"createTime\":\"Feb 21, 2019 2:28:41 PM\"}', 127, '0:0:0:0:0:0:0:1', '2019-02-21 14:28:41');
INSERT INTO `sys_log` VALUES (1098431558701871113, 'admin', '保存角色', 'com.winnerdt.modules.sys.controller.SysRoleController.save()', '{\"roleId\":1,\"roleName\":\"请问\",\"remark\":\"啊啊啊\",\"deptId\":1,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51],\"deptIdList\":[],\"createTime\":\"Feb 21, 2019 2:30:04 PM\"}', 89, '0:0:0:0:0:0:0:1', '2019-02-21 14:30:04');
INSERT INTO `sys_log` VALUES (1098431558701871114, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.update()', '{\"userId\":3,\"email\":\"q@q.com\",\"mobile\":\"11111111111\",\"status\":1,\"roleIdList\":[],\"deptId\":1}', 136, '192.168.30.19', '2019-04-16 10:38:45');
INSERT INTO `sys_log` VALUES (1098431558701871115, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.update()', '{\"userId\":1,\"email\":\"123145@qq.com\",\"mobile\":\"12345698711\",\"status\":1,\"roleIdList\":[],\"deptId\":4}', 211, '0:0:0:0:0:0:0:1', '2019-04-17 17:57:02');
INSERT INTO `sys_log` VALUES (1098431558701871116, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.update()', '{\"userId\":3,\"email\":\"q@q.com\",\"mobile\":\"11111111111\",\"status\":1,\"roleIdList\":[\"1\"],\"deptId\":3}', 87, '0:0:0:0:0:0:0:1', '2019-04-17 18:01:07');
INSERT INTO `sys_log` VALUES (1098431558701871117, 'admin', '保存用户', 'com.winnerdt.modules.sys.controller.SysUserController.save()', '{\"userId\":5,\"username\":\"test1\",\"password\":\"7be0f9939da642910b6889b1787eb20245b420370151769d60787ca3a5e4fc2c\",\"salt\":\"g6IW3Oc9pW6Z9KzfygXv\",\"email\":\"123@qqq.com\",\"mobile\":\"12345678977\",\"status\":1,\"roleIdList\":[\"1\"],\"createTime\":\"Apr 17, 2019 6:01:54 PM\",\"deptId\":3}', 46, '0:0:0:0:0:0:0:1', '2019-04-17 18:01:54');
INSERT INTO `sys_log` VALUES (1098431558701871118, 'admin', '修改角色', 'com.winnerdt.modules.sys.controller.SysRoleController.update()', '{\"roleId\":1,\"roleName\":\"test1\",\"remark\":\"啊啊啊\",\"deptId\":4,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51],\"deptIdList\":[4]}', 98, '0:0:0:0:0:0:0:1', '2019-04-17 18:02:27');
INSERT INTO `sys_log` VALUES (1098431558701871119, 'admin', '保存菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.save()', '{\"menuId\":51,\"parentId\":1,\"name\":\"测试\",\"path\":\"/admin-test/admin-test\",\"type\":1,\"icon\":\"calculator\",\"locale\":\"menu.adminTtest.adminTtest\"}', 154, '192.168.30.19', '2019-04-17 18:05:20');
INSERT INTO `sys_log` VALUES (1098431558701871120, 'test1', '修改角色', 'com.winnerdt.modules.sys.controller.SysRoleController.update()', '{\"roleId\":1,\"roleName\":\"test1\",\"remark\":\"啊啊啊\",\"deptId\":4,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51],\"deptIdList\":[4,6,7]}', 147, '0:0:0:0:0:0:0:1', '2019-04-17 18:05:58');
INSERT INTO `sys_log` VALUES (1098431558701871121, 'admin', '修改角色', 'com.winnerdt.modules.sys.controller.SysRoleController.update()', '{\"roleId\":1,\"roleName\":\"test1\",\"remark\":\"啊啊啊\",\"deptId\":4,\"menuIdList\":[2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50],\"deptIdList\":[4]}', 102, '192.168.30.19', '2019-04-17 18:06:20');
INSERT INTO `sys_log` VALUES (1098431558701871122, 'test1', '修改角色', 'com.winnerdt.modules.sys.controller.SysRoleController.update()', '{\"roleId\":1,\"roleName\":\"test1\",\"remark\":\"啊啊啊\",\"deptId\":4,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51],\"deptIdList\":[4]}', 74, '0:0:0:0:0:0:0:1', '2019-04-17 18:07:09');
INSERT INTO `sys_log` VALUES (1098431558701871123, 'test1', '修改角色', 'com.winnerdt.modules.sys.controller.SysRoleController.update()', '{\"roleId\":1,\"roleName\":\"test1\",\"remark\":\"啊啊啊\",\"deptId\":4,\"menuIdList\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51],\"deptIdList\":[4,6]}', 58, '0:0:0:0:0:0:0:1', '2019-04-17 18:08:35');
INSERT INTO `sys_log` VALUES (1098431558701871124, 'admin', '修改菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.update()', '{\"menuId\":51,\"parentId\":1,\"name\":\"测试\",\"path\":\"/admin-test/admin-test\",\"type\":1,\"icon\":\"calculator\",\"orderNum\":1}', 45, '192.168.30.19', '2019-04-17 18:12:47');
INSERT INTO `sys_log` VALUES (1098431558701871125, 'admin', '修改菜单', 'com.winnerdt.modules.sys.controller.SysMenuController.update()', '{\"menuId\":51,\"parentId\":1,\"name\":\"测试操作\",\"path\":\"/admin-test/admin-test\",\"type\":1,\"icon\":\"calculator\",\"orderNum\":1}', 40, '192.168.30.19', '2019-04-17 18:13:09');
INSERT INTO `sys_log` VALUES (1098431558701871126, 'admin', '删除定时任务', 'com.winnerdt.modules.job.controller.ScheduleJobController.delete()', '[4]', 119, '0:0:0:0:0:0:0:1', '2019-04-19 14:13:52');
INSERT INTO `sys_log` VALUES (1098431558701871127, 'admin', '修改用户', 'com.winnerdt.modules.sys.controller.SysUserController.update()', '{\"userId\":5,\"password\":\"7be0f9939da642910b6889b1787eb20245b420370151769d60787ca3a5e4fc2c\",\"email\":\"123@qqq.com\",\"mobile\":\"12345678977\",\"status\":1,\"roleIdList\":[\"1\"],\"deptId\":3}', 169, '0:0:0:0:0:0:0:1', '2019-04-24 15:34:15');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NULL DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `path` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) NULL DEFAULT NULL COMMENT '排序',
  `locale` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '给前台使用的，具体作用不明',
  `exact` int(10) NULL DEFAULT 0 COMMENT '给前台使用的，具体作用不明,boolean类型',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 76 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '菜单管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, 0, '系统管理', '/system-manager', NULL, 0, 'setting', 3, 'menu.systemManager', 1);
INSERT INTO `sys_menu` VALUES (2, 0, '用户管理', '/admin-manager', NULL, 0, 'user', 1, 'menu.adminManager', 1);
INSERT INTO `sys_menu` VALUES (3, 1, '角色管理', '/system-manager/role-manager', NULL, 1, 'tool', 2, 'menu.systemManager.roleManager', 1);
INSERT INTO `sys_menu` VALUES (4, 1, '菜单管理', '/system-manager/menu-manager', NULL, 1, 'tool', 3, 'menu.systemManager.menuManager', 1);
INSERT INTO `sys_menu` VALUES (5, 1, 'SQL监控', '/system-manager/sql-manager', NULL, 1, 'tool', 4, 'menu.systemManager.sqlManager', 1);
INSERT INTO `sys_menu` VALUES (6, 1, '定时任务', '/system-manager/timing-manager', NULL, 1, 'tool', 5, 'menu.systemManager.timingManager', 1);
INSERT INTO `sys_menu` VALUES (7, 6, '查看', NULL, 'sys:schedule:list,sys:schedule:info', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (8, 6, '新增', NULL, 'sys:schedule:save', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (9, 6, '修改', NULL, 'sys:schedule:update', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (10, 6, '删除', NULL, 'sys:schedule:delete', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (11, 6, '暂停', NULL, 'sys:schedule:pause', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (12, 6, '恢复', NULL, 'sys:schedule:resume', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (13, 6, '立即执行', NULL, 'sys:schedule:run', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (14, 6, '日志列表', NULL, 'sys:schedule:log', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (15, 74, '查看', NULL, 'sys:user:list,sys:user:info', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (16, 74, '新增', NULL, 'sys:user:save,sys:role:select', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (17, 74, '修改', NULL, 'sys:user:update,sys:role:select', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (18, 74, '删除', NULL, 'sys:user:delete', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (19, 3, '查看', NULL, 'sys:role:list,sys:role:info', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (20, 3, '新增', NULL, 'sys:role:save,sys:menu:perms', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (21, 3, '修改', NULL, 'sys:role:update,sys:menu:perms', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (22, 3, '删除', NULL, 'sys:role:delete', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (23, 4, '查看', NULL, 'sys:menu:list,sys:menu:info', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (24, 4, '新增', NULL, 'sys:menu:save,sys:menu:select', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (25, 4, '修改', NULL, 'sys:menu:update,sys:menu:select', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (26, 4, '删除', NULL, 'sys:menu:delete', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (27, 1, '参数管理', '/system-manager/parameter-manager', 'sys:config:list,sys:config:info,sys:config:save,sys:config:update,sys:config:delete', 1, 'tool', 6, 'menu.systemManager.parameterManager', 1);
INSERT INTO `sys_menu` VALUES (29, 1, '系统日志', '/system-manager/system-log', 'sys:log:list', 1, 'tool', 7, 'menu.systemManager.systemLog', 1);
INSERT INTO `sys_menu` VALUES (30, 1, '文件上传', '/system-manager/file-upload', 'sys:oss:list', 1, 'tool', 6, 'menu.systemManager.fileUpload', 1);
INSERT INTO `sys_menu` VALUES (31, 0, '渠道管理', '/department-manager', NULL, 0, 'tool', 1, 'menu.departmentManager', 1);
INSERT INTO `sys_menu` VALUES (32, 75, '查看', NULL, 'sys:dept:list,sys:dept:info', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (33, 75, '新增', NULL, 'sys:dept:save,sys:dept:select', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (34, 75, '修改', NULL, 'sys:dept:update,sys:dept:select', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (35, 75, '删除', NULL, 'sys:dept:delete', 2, NULL, 0, NULL, 1);
INSERT INTO `sys_menu` VALUES (36, 1, '字典管理', '/system-manager/dictionary-manager', NULL, 1, 'tool', 6, 'menu.systemManager.dictionaryManager', 1);
INSERT INTO `sys_menu` VALUES (37, 36, '查看', NULL, 'sys:dict:list,sys:dict:info', 2, NULL, 6, NULL, 1);
INSERT INTO `sys_menu` VALUES (38, 36, '新增', NULL, 'sys:dict:save', 2, NULL, 6, NULL, 1);
INSERT INTO `sys_menu` VALUES (39, 36, '修改', NULL, 'sys:dict:update', 2, NULL, 6, NULL, 1);
INSERT INTO `sys_menu` VALUES (40, 36, '删除', NULL, 'sys:dict:delete', 2, NULL, 6, NULL, 1);
INSERT INTO `sys_menu` VALUES (41, 1, '测试页面', '/system-manager/system-test', NULL, 1, 'tool', 1, 'menu.systemManager.testPage', 1);
INSERT INTO `sys_menu` VALUES (42, 30, '查看', NULL, 'sys:oss:list', 2, NULL, 1, NULL, 0);
INSERT INTO `sys_menu` VALUES (43, 30, '新增', NULL, 'sys:oss:save', 2, NULL, 2, NULL, 0);
INSERT INTO `sys_menu` VALUES (44, 30, '上传', NULL, 'sys:oss:upload', 2, NULL, 3, NULL, 0);
INSERT INTO `sys_menu` VALUES (45, 30, '删除', NULL, 'sys:oss:delete', 2, NULL, 4, NULL, 0);
INSERT INTO `sys_menu` VALUES (46, 27, '查看', NULL, 'sys:config:list,sys:config:info', 2, NULL, 1, NULL, 0);
INSERT INTO `sys_menu` VALUES (47, 27, '删除', NULL, 'sys:config:delete', 2, NULL, 1, NULL, 0);
INSERT INTO `sys_menu` VALUES (48, 27, '修改', NULL, 'sys:config:update', 2, NULL, 1, NULL, 0);
INSERT INTO `sys_menu` VALUES (49, 27, '添加', NULL, 'sys:config:save', 2, NULL, 1, NULL, 0);
INSERT INTO `sys_menu` VALUES (50, 29, '查看', NULL, 'sys:log:list', 2, NULL, 1, NULL, 0);
INSERT INTO `sys_menu` VALUES (51, 0, '二维码管理', '/qrcode-manager', NULL, 0, 'qrcode', 2, 'menu.qrcodeManager', 0);
INSERT INTO `sys_menu` VALUES (52, 0, '会员管理', '/member-manager', NULL, 0, 'team', 1, 'menu.memberManager', 0);
INSERT INTO `sys_menu` VALUES (53, 51, '二维码列表', '/qrcode-manager/qrcode-list', NULL, 1, 'bars', NULL, 'menu.qrcodeManager.qrcodeList', 0);
INSERT INTO `sys_menu` VALUES (54, 52, '会员列表', '/member-manager/member-list', NULL, 1, 'bars', NULL, 'menu.memberManager.memberList', 0);
INSERT INTO `sys_menu` VALUES (55, 51, '微信基本信息', '/qrcode-manager/qrcode-wx-info', NULL, 1, 'wechat', NULL, 'menu.qrcodeManager.qrcodeWxInfo', 0);
INSERT INTO `sys_menu` VALUES (56, 51, '二维码参数配置', '/qrcode-manager/qrcode-config', NULL, 1, 'barcode', NULL, 'menu.qrcodeManager.qrcodeConfig', 0);
INSERT INTO `sys_menu` VALUES (57, 55, '查看', NULL, 'sys:user:list,sys:user:info', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (58, 55, '添加', NULL, 'sys:user:save,sys:role:select', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (59, 55, '修改', NULL, 'sys:user:update,sys:role:select', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (60, 55, '删除', NULL, 'sys:user:delete', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (61, 56, '查看', NULL, 'sys:user:list,sys:user:info', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (62, 56, '添加', NULL, 'sys:user:save,sys:role:select', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (63, 56, '修改', NULL, 'sys:user:update,sys:role:select', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (64, 56, '删除', NULL, 'sys:user:delete', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (65, 53, '添加', NULL, 'sys:user:save,sys:role:select', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (66, 53, '查看', NULL, 'sys:user:list,sys:user:info', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (67, 53, '修改', NULL, 'sys:user:update,sys:role:select', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (68, 53, '删除', NULL, 'sys:user:delete', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (69, 0, '数据统计', '/dashboard/analysis', NULL, 0, 'dashboard', 0, 'menu.dashboard.analysis', 0);
INSERT INTO `sys_menu` VALUES (70, 54, '添加', NULL, 'sys:user:save,sys:role:select', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (71, 54, '查看', NULL, 'sys:user:list,sys:user:info', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (72, 54, '修改', NULL, 'sys:user:update,sys:role:select', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (73, 54, '删除', NULL, 'sys:user:delete', 2, NULL, NULL, NULL, 0);
INSERT INTO `sys_menu` VALUES (74, 2, '用户列表', '/admin-manager/admin-list', NULL, 1, 'bars', NULL, 'menu.adminManager.adminManagerList', 0);
INSERT INTO `sys_menu` VALUES (75, 31, '渠道列表', '/department-manager/department-list', NULL, 1, NULL, NULL, 'menu.departmentManager.departmentManagerList', 0);

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'URL地址',
  `bucket_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '存储空间',
  `file_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 129 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文件上传' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oss
-- ----------------------------
INSERT INTO `sys_oss` VALUES (79, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/2fb361592b77489caae8cf82018a4cdb.png', 'master-test', 'upload/20190130/2fb361592b77489caae8cf82018a4cdb.png', '2019-01-30 15:30:04');
INSERT INTO `sys_oss` VALUES (80, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/1357e652e7134b8f94726d471b776519.png', 'master-test', 'upload/20190130/1357e652e7134b8f94726d471b776519.png', '2019-01-30 15:30:04');
INSERT INTO `sys_oss` VALUES (81, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/621779f9cbd8447489ab5c1063919e40.png', 'master-test', 'upload/20190130/621779f9cbd8447489ab5c1063919e40.png', '2019-01-30 15:30:05');
INSERT INTO `sys_oss` VALUES (82, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/0188acb13161465993e92fca152b2c6b.png', 'master-test', 'upload/20190130/0188acb13161465993e92fca152b2c6b.png', '2019-01-30 15:30:06');
INSERT INTO `sys_oss` VALUES (83, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/64d6e61ca521466fae2976cefbfdad7c.png', 'master-test', 'upload/20190130/64d6e61ca521466fae2976cefbfdad7c.png', '2019-01-30 15:30:06');
INSERT INTO `sys_oss` VALUES (84, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/d7235fe00a9b450d9113320403de0d78.png', 'master-test', 'upload/20190130/d7235fe00a9b450d9113320403de0d78.png', '2019-01-30 15:30:07');
INSERT INTO `sys_oss` VALUES (85, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/2b9f54a3806e41d1a4f838340d99365c.png', 'master-test', 'upload/20190130/2b9f54a3806e41d1a4f838340d99365c.png', '2019-01-30 15:30:07');
INSERT INTO `sys_oss` VALUES (86, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/3663ed20b1aa4ae59e9c5c4648fdd47c.png', 'master-test', 'upload/20190130/3663ed20b1aa4ae59e9c5c4648fdd47c.png', '2019-01-30 15:30:08');
INSERT INTO `sys_oss` VALUES (87, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/50d9a2b6eb0b44888efd43ad206faad5.jpg', 'master-test', 'upload/20190130/50d9a2b6eb0b44888efd43ad206faad5.jpg', '2019-01-30 15:30:08');
INSERT INTO `sys_oss` VALUES (88, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/1fe7e32fa8b641a5b13112514919f1ae.png', 'master-test', 'upload/20190130/1fe7e32fa8b641a5b13112514919f1ae.png', '2019-01-30 15:30:08');
INSERT INTO `sys_oss` VALUES (89, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/67862baaf63c491c9f387f4327c03da2.jpg', 'master-test', 'upload/20190130/67862baaf63c491c9f387f4327c03da2.jpg', '2019-01-30 15:30:09');
INSERT INTO `sys_oss` VALUES (90, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/33fed781629b4b90be1ce49fb1e6bc57.jpg', 'master-test', 'upload/20190130/33fed781629b4b90be1ce49fb1e6bc57.jpg', '2019-01-30 15:30:09');
INSERT INTO `sys_oss` VALUES (91, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/243167b2b85544a18a41a90bfde2c8e4.jpg', 'master-test', 'upload/20190130/243167b2b85544a18a41a90bfde2c8e4.jpg', '2019-01-30 15:30:09');
INSERT INTO `sys_oss` VALUES (92, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/8c82147f4f2c4582a997c0b2aa362faf.png', 'master-test', 'upload/20190130/8c82147f4f2c4582a997c0b2aa362faf.png', '2019-01-30 15:30:10');
INSERT INTO `sys_oss` VALUES (93, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/89e19054c00642899e38fdb68bd8f5a4.png', 'master-test', 'upload/20190130/89e19054c00642899e38fdb68bd8f5a4.png', '2019-01-30 15:30:10');
INSERT INTO `sys_oss` VALUES (94, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/c26745a811754b758b4fe116620e3582.png', 'master-test', 'upload/20190130/c26745a811754b758b4fe116620e3582.png', '2019-01-30 15:30:10');
INSERT INTO `sys_oss` VALUES (95, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/28b70b0983594ac5a11e9878c1bad0b2.png', 'master-test', 'upload/20190130/28b70b0983594ac5a11e9878c1bad0b2.png', '2019-01-30 15:30:11');
INSERT INTO `sys_oss` VALUES (96, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/768d3a96dfcc4fc88acfa21541c1ea5b.png', 'master-test', 'upload/20190130/768d3a96dfcc4fc88acfa21541c1ea5b.png', '2019-01-30 15:30:11');
INSERT INTO `sys_oss` VALUES (97, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/5a25c9511d964a3e8a6ae76c8c20273e.png', 'master-test', 'upload/20190130/5a25c9511d964a3e8a6ae76c8c20273e.png', '2019-01-30 15:30:11');
INSERT INTO `sys_oss` VALUES (98, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/e4591eb7ba3948f79cf9eb15760c58c4.png', 'master-test', 'upload/20190130/e4591eb7ba3948f79cf9eb15760c58c4.png', '2019-01-30 15:30:12');
INSERT INTO `sys_oss` VALUES (99, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/5f3cc3d665834bfaa81f9ea582b7811e.png', 'master-test', 'upload/20190130/5f3cc3d665834bfaa81f9ea582b7811e.png', '2019-01-30 15:30:12');
INSERT INTO `sys_oss` VALUES (100, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/4c7e150c830e4e3490649527999ea5ab.png', 'master-test', 'upload/20190130/4c7e150c830e4e3490649527999ea5ab.png', '2019-01-30 15:30:12');
INSERT INTO `sys_oss` VALUES (101, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/1ad950d8bffa4373a978d8a91ce77c72.png', 'master-test', 'upload/20190130/1ad950d8bffa4373a978d8a91ce77c72.png', '2019-01-30 15:30:12');
INSERT INTO `sys_oss` VALUES (102, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/36412eba0aba4ea19c06bd25e4dfe8ae.png', 'master-test', 'upload/20190130/36412eba0aba4ea19c06bd25e4dfe8ae.png', '2019-01-30 15:30:13');
INSERT INTO `sys_oss` VALUES (103, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/bb9ead7362114e978a3ef755ef0a4a3a.png', 'master-test', 'upload/20190130/bb9ead7362114e978a3ef755ef0a4a3a.png', '2019-01-30 15:30:13');
INSERT INTO `sys_oss` VALUES (104, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/2559e1aad3a64ca09e4de90dca29bc8b.png', 'master-test', 'upload/20190130/2559e1aad3a64ca09e4de90dca29bc8b.png', '2019-01-30 15:30:13');
INSERT INTO `sys_oss` VALUES (105, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/5324c89668564d158f02e3e1ee149b45.png', 'master-test', 'upload/20190130/5324c89668564d158f02e3e1ee149b45.png', '2019-01-30 15:30:14');
INSERT INTO `sys_oss` VALUES (106, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/941f376c887a4ef8a05ae73d8528e555.png', 'master-test', 'upload/20190130/941f376c887a4ef8a05ae73d8528e555.png', '2019-01-30 15:30:14');
INSERT INTO `sys_oss` VALUES (107, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/f1fefab6f04a42789a68aba82742e8bb.png', 'master-test', 'upload/20190130/f1fefab6f04a42789a68aba82742e8bb.png', '2019-01-30 15:30:14');
INSERT INTO `sys_oss` VALUES (108, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/c9b4fd9a591b4ad9bf175278907e11f8.png', 'master-test', 'upload/20190130/c9b4fd9a591b4ad9bf175278907e11f8.png', '2019-01-30 15:30:15');
INSERT INTO `sys_oss` VALUES (109, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/b0bff630f1c6467e8f60ff4e501d8c47.png', 'master-test', 'upload/20190130/b0bff630f1c6467e8f60ff4e501d8c47.png', '2019-01-30 15:30:15');
INSERT INTO `sys_oss` VALUES (110, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/4b701a890148475bb241a6f44c9f9f0f.png', 'master-test', 'upload/20190130/4b701a890148475bb241a6f44c9f9f0f.png', '2019-01-30 15:30:15');
INSERT INTO `sys_oss` VALUES (111, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/51d071972a3d4e7487e4c7919f7cc1f8.png', 'master-test', 'upload/20190130/51d071972a3d4e7487e4c7919f7cc1f8.png', '2019-01-30 15:30:15');
INSERT INTO `sys_oss` VALUES (112, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/f65b75fdec554cafad3a84ba872771c5.png', 'master-test', 'upload/20190130/f65b75fdec554cafad3a84ba872771c5.png', '2019-01-30 15:30:16');
INSERT INTO `sys_oss` VALUES (113, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/c7d8a2e338d6447fb62599c1a3954897.png', 'master-test', 'upload/20190130/c7d8a2e338d6447fb62599c1a3954897.png', '2019-01-30 15:30:16');
INSERT INTO `sys_oss` VALUES (114, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/c7245d54caa1462bb6eb8bf2d7ce6a82.png', 'master-test', 'upload/20190130/c7245d54caa1462bb6eb8bf2d7ce6a82.png', '2019-01-30 15:30:16');
INSERT INTO `sys_oss` VALUES (115, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/8ae11ea6287f442ebf4c2358f3ad60ef.png', 'master-test', 'upload/20190130/8ae11ea6287f442ebf4c2358f3ad60ef.png', '2019-01-30 15:30:16');
INSERT INTO `sys_oss` VALUES (116, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/62f4cd654dcd400a9af4ae59d5c7c00a.png', 'master-test', 'upload/20190130/62f4cd654dcd400a9af4ae59d5c7c00a.png', '2019-01-30 15:30:17');
INSERT INTO `sys_oss` VALUES (117, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/a16ba61fe2f1404987c9140269a7b37e.png', 'master-test', 'upload/20190130/a16ba61fe2f1404987c9140269a7b37e.png', '2019-01-30 15:30:17');
INSERT INTO `sys_oss` VALUES (118, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/99140c49b7524b40878feeb70d75a478.png', 'master-test', 'upload/20190130/99140c49b7524b40878feeb70d75a478.png', '2019-01-30 15:30:17');
INSERT INTO `sys_oss` VALUES (119, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/a81f587365dc41708b3576af57771e1a.png', 'master-test', 'upload/20190130/a81f587365dc41708b3576af57771e1a.png', '2019-01-30 15:30:18');
INSERT INTO `sys_oss` VALUES (120, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/41451d66cd8243a3afc86067df99952f.jpg', 'master-test', 'upload/20190130/41451d66cd8243a3afc86067df99952f.jpg', '2019-01-30 15:30:18');
INSERT INTO `sys_oss` VALUES (121, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/e99bb7b2625842c1810c154ef41940db.png', 'master-test', 'upload/20190130/e99bb7b2625842c1810c154ef41940db.png', '2019-01-30 15:30:18');
INSERT INTO `sys_oss` VALUES (122, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/ea501a7e8d9746b5834191009e4b705c.png', 'master-test', 'upload/20190130/ea501a7e8d9746b5834191009e4b705c.png', '2019-01-30 15:30:18');
INSERT INTO `sys_oss` VALUES (123, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/f9d015268044403da5e7cfad0a8d81aa.png', 'master-test', 'upload/20190130/f9d015268044403da5e7cfad0a8d81aa.png', '2019-01-30 15:30:19');
INSERT INTO `sys_oss` VALUES (124, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/48c04388255c47a789b0d512a3a6fc73.png', 'master-test', 'upload/20190130/48c04388255c47a789b0d512a3a6fc73.png', '2019-01-30 15:30:19');
INSERT INTO `sys_oss` VALUES (125, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/a88eff67f2014d1c960ab7ad21d725ea.png', 'master-test', 'upload/20190130/a88eff67f2014d1c960ab7ad21d725ea.png', '2019-01-30 15:30:19');
INSERT INTO `sys_oss` VALUES (126, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/696e57bf1d9c453fb470147af1a26728.png', 'master-test', 'upload/20190130/696e57bf1d9c453fb470147af1a26728.png', '2019-01-30 15:30:20');
INSERT INTO `sys_oss` VALUES (127, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/392e3cd7c2034e14a2ccb1383e7d4e73.jpg', 'master-test', 'upload/20190130/392e3cd7c2034e14a2ccb1383e7d4e73.jpg', '2019-01-30 15:30:20');
INSERT INTO `sys_oss` VALUES (128, 'http://pm2vkbv1m.bkt.clouddn.com/upload/20190130/c8a0f719f09c4f14a53e88352da69a70.jpg', 'master-test', 'upload/20190130/c8a0f719f09c4f14a53e88352da69a70.jpg', '2019-01-30 15:30:20');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, 'test1', '啊啊啊', 4, '2019-02-21 14:30:04');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1087620602212151331 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色与部门对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (1087620602212151329, 1, 4);
INSERT INTO `sys_role_dept` VALUES (1087620602212151330, 1, 6);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NULL DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1098431558227915266 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色与菜单对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1087609022518972700, 1087620602119876614, 1);
INSERT INTO `sys_role_menu` VALUES (1087609022518972701, 1087620602119876614, 2);
INSERT INTO `sys_role_menu` VALUES (1087609022518972702, 1087620602119876614, 3);
INSERT INTO `sys_role_menu` VALUES (1087609022518972703, 1087620602119876614, 4);
INSERT INTO `sys_role_menu` VALUES (1087609022518972704, 1087620602119876614, 5);
INSERT INTO `sys_role_menu` VALUES (1087609022518972705, 1087620602119876614, 6);
INSERT INTO `sys_role_menu` VALUES (1087609022518972706, 1087620602119876614, 7);
INSERT INTO `sys_role_menu` VALUES (1087609022518972707, 1087620602119876614, 8);
INSERT INTO `sys_role_menu` VALUES (1087609022518972708, 1087620602119876614, 9);
INSERT INTO `sys_role_menu` VALUES (1087609022518972709, 1087620602119876614, 10);
INSERT INTO `sys_role_menu` VALUES (1087609022518972710, 1087620602119876614, 11);
INSERT INTO `sys_role_menu` VALUES (1087609022518972711, 1087620602119876614, 12);
INSERT INTO `sys_role_menu` VALUES (1087609022518972712, 1087620602119876614, 13);
INSERT INTO `sys_role_menu` VALUES (1087609022518972713, 1087620602119876614, 14);
INSERT INTO `sys_role_menu` VALUES (1087609022518972714, 1087620602119876614, 15);
INSERT INTO `sys_role_menu` VALUES (1087609022518972715, 1087620602119876614, 16);
INSERT INTO `sys_role_menu` VALUES (1087609022518972716, 1087620602119876614, 17);
INSERT INTO `sys_role_menu` VALUES (1087609022518972717, 1087620602119876614, 18);
INSERT INTO `sys_role_menu` VALUES (1087609022518972718, 1087620602119876614, 19);
INSERT INTO `sys_role_menu` VALUES (1087609022518972719, 1087620602119876614, 20);
INSERT INTO `sys_role_menu` VALUES (1087609022518972720, 1087620602119876614, 21);
INSERT INTO `sys_role_menu` VALUES (1087609022518972721, 1087620602119876614, 22);
INSERT INTO `sys_role_menu` VALUES (1087609022518972722, 1087620602119876614, 23);
INSERT INTO `sys_role_menu` VALUES (1087609022518972723, 1087620602119876614, 24);
INSERT INTO `sys_role_menu` VALUES (1087609022518972724, 1087620602119876614, 25);
INSERT INTO `sys_role_menu` VALUES (1087609022518972725, 1087620602119876614, 26);
INSERT INTO `sys_role_menu` VALUES (1087609022518972726, 1087620602119876614, 27);
INSERT INTO `sys_role_menu` VALUES (1087609022518972727, 1087620602119876614, 29);
INSERT INTO `sys_role_menu` VALUES (1087609022518972728, 1087620602119876614, 30);
INSERT INTO `sys_role_menu` VALUES (1087609022518972729, 1087620602119876614, 31);
INSERT INTO `sys_role_menu` VALUES (1087609022518972730, 1087620602119876614, 32);
INSERT INTO `sys_role_menu` VALUES (1087609022518972731, 1087620602119876614, 33);
INSERT INTO `sys_role_menu` VALUES (1087609022518972732, 1087620602119876614, 34);
INSERT INTO `sys_role_menu` VALUES (1087609022518972733, 1087620602119876614, 35);
INSERT INTO `sys_role_menu` VALUES (1087609022518972734, 1087620602119876614, 36);
INSERT INTO `sys_role_menu` VALUES (1087609022518972735, 1087620602119876614, 37);
INSERT INTO `sys_role_menu` VALUES (1087609022518972736, 1087620602119876614, 38);
INSERT INTO `sys_role_menu` VALUES (1087609022518972737, 1087620602119876614, 39);
INSERT INTO `sys_role_menu` VALUES (1087609022518972738, 1087620602119876614, 40);
INSERT INTO `sys_role_menu` VALUES (1087609022518972739, 1087620602119876614, 41);
INSERT INTO `sys_role_menu` VALUES (1098154412188217346, 1098154412112719873, 1);
INSERT INTO `sys_role_menu` VALUES (1098154412192411650, 1098154412112719873, 2);
INSERT INTO `sys_role_menu` VALUES (1098154412192411651, 1098154412112719873, 3);
INSERT INTO `sys_role_menu` VALUES (1098154412192411652, 1098154412112719873, 4);
INSERT INTO `sys_role_menu` VALUES (1098154412192411653, 1098154412112719873, 5);
INSERT INTO `sys_role_menu` VALUES (1098154412200800257, 1098154412112719873, 6);
INSERT INTO `sys_role_menu` VALUES (1098154412200800258, 1098154412112719873, 7);
INSERT INTO `sys_role_menu` VALUES (1098154412200800259, 1098154412112719873, 8);
INSERT INTO `sys_role_menu` VALUES (1098154412204994562, 1098154412112719873, 9);
INSERT INTO `sys_role_menu` VALUES (1098154412204994563, 1098154412112719873, 10);
INSERT INTO `sys_role_menu` VALUES (1098154412204994564, 1098154412112719873, 11);
INSERT INTO `sys_role_menu` VALUES (1098154412204994565, 1098154412112719873, 12);
INSERT INTO `sys_role_menu` VALUES (1098154412204994566, 1098154412112719873, 13);
INSERT INTO `sys_role_menu` VALUES (1098154412204994567, 1098154412112719873, 14);
INSERT INTO `sys_role_menu` VALUES (1098154412204994568, 1098154412112719873, 15);
INSERT INTO `sys_role_menu` VALUES (1098154412204994569, 1098154412112719873, 16);
INSERT INTO `sys_role_menu` VALUES (1098154412213383170, 1098154412112719873, 17);
INSERT INTO `sys_role_menu` VALUES (1098154412213383171, 1098154412112719873, 18);
INSERT INTO `sys_role_menu` VALUES (1098154412213383172, 1098154412112719873, 19);
INSERT INTO `sys_role_menu` VALUES (1098154412213383173, 1098154412112719873, 20);
INSERT INTO `sys_role_menu` VALUES (1098154412221771778, 1098154412112719873, 21);
INSERT INTO `sys_role_menu` VALUES (1098154412221771779, 1098154412112719873, 22);
INSERT INTO `sys_role_menu` VALUES (1098154412221771780, 1098154412112719873, 23);
INSERT INTO `sys_role_menu` VALUES (1098154412221771781, 1098154412112719873, 24);
INSERT INTO `sys_role_menu` VALUES (1098154412221771782, 1098154412112719873, 25);
INSERT INTO `sys_role_menu` VALUES (1098154412221771783, 1098154412112719873, 26);
INSERT INTO `sys_role_menu` VALUES (1098154412221771784, 1098154412112719873, 27);
INSERT INTO `sys_role_menu` VALUES (1098154412230160385, 1098154412112719873, 29);
INSERT INTO `sys_role_menu` VALUES (1098154412230160386, 1098154412112719873, 30);
INSERT INTO `sys_role_menu` VALUES (1098154412230160387, 1098154412112719873, 31);
INSERT INTO `sys_role_menu` VALUES (1098154412230160388, 1098154412112719873, 32);
INSERT INTO `sys_role_menu` VALUES (1098154412238548993, 1098154412112719873, 33);
INSERT INTO `sys_role_menu` VALUES (1098154412238548994, 1098154412112719873, 34);
INSERT INTO `sys_role_menu` VALUES (1098154412238548995, 1098154412112719873, 35);
INSERT INTO `sys_role_menu` VALUES (1098154412238548996, 1098154412112719873, 36);
INSERT INTO `sys_role_menu` VALUES (1098154412238548997, 1098154412112719873, 37);
INSERT INTO `sys_role_menu` VALUES (1098154412238548998, 1098154412112719873, 38);
INSERT INTO `sys_role_menu` VALUES (1098154412238548999, 1098154412112719873, 39);
INSERT INTO `sys_role_menu` VALUES (1098154412238549000, 1098154412112719873, 40);
INSERT INTO `sys_role_menu` VALUES (1098154412246937601, 1098154412112719873, 41);
INSERT INTO `sys_role_menu` VALUES (1098154412246937602, 1098154412112719873, 42);
INSERT INTO `sys_role_menu` VALUES (1098154412246937603, 1098154412112719873, 43);
INSERT INTO `sys_role_menu` VALUES (1098154412246937604, 1098154412112719873, 44);
INSERT INTO `sys_role_menu` VALUES (1098154412246937605, 1098154412112719873, 45);
INSERT INTO `sys_role_menu` VALUES (1098154412246937606, 1098154412112719873, 46);
INSERT INTO `sys_role_menu` VALUES (1098154412246937607, 1098154412112719873, 47);
INSERT INTO `sys_role_menu` VALUES (1098154412246937608, 1098154412112719873, 48);
INSERT INTO `sys_role_menu` VALUES (1098154412255326210, 1098154412112719873, 49);
INSERT INTO `sys_role_menu` VALUES (1098154412255326211, 1098154412112719873, 50);
INSERT INTO `sys_role_menu` VALUES (1098415756250566658, 1098415756145709058, 1);
INSERT INTO `sys_role_menu` VALUES (1098415756300898306, 1098415756145709058, 2);
INSERT INTO `sys_role_menu` VALUES (1098415756309286913, 1098415756145709058, 3);
INSERT INTO `sys_role_menu` VALUES (1098415756309286914, 1098415756145709058, 4);
INSERT INTO `sys_role_menu` VALUES (1098415756309286915, 1098415756145709058, 5);
INSERT INTO `sys_role_menu` VALUES (1098415756309286916, 1098415756145709058, 6);
INSERT INTO `sys_role_menu` VALUES (1098415756309286917, 1098415756145709058, 7);
INSERT INTO `sys_role_menu` VALUES (1098415756309286918, 1098415756145709058, 8);
INSERT INTO `sys_role_menu` VALUES (1098415756317675522, 1098415756145709058, 9);
INSERT INTO `sys_role_menu` VALUES (1098415756317675523, 1098415756145709058, 10);
INSERT INTO `sys_role_menu` VALUES (1098415756317675524, 1098415756145709058, 11);
INSERT INTO `sys_role_menu` VALUES (1098415756317675525, 1098415756145709058, 12);
INSERT INTO `sys_role_menu` VALUES (1098415756317675526, 1098415756145709058, 13);
INSERT INTO `sys_role_menu` VALUES (1098415756317675527, 1098415756145709058, 14);
INSERT INTO `sys_role_menu` VALUES (1098415756317675528, 1098415756145709058, 15);
INSERT INTO `sys_role_menu` VALUES (1098415756317675529, 1098415756145709058, 16);
INSERT INTO `sys_role_menu` VALUES (1098415756326064130, 1098415756145709058, 17);
INSERT INTO `sys_role_menu` VALUES (1098415756326064131, 1098415756145709058, 18);
INSERT INTO `sys_role_menu` VALUES (1098415756334452738, 1098415756145709058, 19);
INSERT INTO `sys_role_menu` VALUES (1098415756334452739, 1098415756145709058, 20);
INSERT INTO `sys_role_menu` VALUES (1098415756334452740, 1098415756145709058, 21);
INSERT INTO `sys_role_menu` VALUES (1098415756334452741, 1098415756145709058, 22);
INSERT INTO `sys_role_menu` VALUES (1098415756334452742, 1098415756145709058, 23);
INSERT INTO `sys_role_menu` VALUES (1098415756334452743, 1098415756145709058, 24);
INSERT INTO `sys_role_menu` VALUES (1098415756334452744, 1098415756145709058, 25);
INSERT INTO `sys_role_menu` VALUES (1098415756342841346, 1098415756145709058, 26);
INSERT INTO `sys_role_menu` VALUES (1098415756342841347, 1098415756145709058, 27);
INSERT INTO `sys_role_menu` VALUES (1098415756342841348, 1098415756145709058, 29);
INSERT INTO `sys_role_menu` VALUES (1098415756342841349, 1098415756145709058, 30);
INSERT INTO `sys_role_menu` VALUES (1098415756342841350, 1098415756145709058, 31);
INSERT INTO `sys_role_menu` VALUES (1098415756342841351, 1098415756145709058, 32);
INSERT INTO `sys_role_menu` VALUES (1098415756342841352, 1098415756145709058, 33);
INSERT INTO `sys_role_menu` VALUES (1098415756342841353, 1098415756145709058, 34);
INSERT INTO `sys_role_menu` VALUES (1098415756342841354, 1098415756145709058, 35);
INSERT INTO `sys_role_menu` VALUES (1098415756342841355, 1098415756145709058, 36);
INSERT INTO `sys_role_menu` VALUES (1098415756342841356, 1098415756145709058, 37);
INSERT INTO `sys_role_menu` VALUES (1098415756342841357, 1098415756145709058, 38);
INSERT INTO `sys_role_menu` VALUES (1098415756342841358, 1098415756145709058, 39);
INSERT INTO `sys_role_menu` VALUES (1098415756351229954, 1098415756145709058, 40);
INSERT INTO `sys_role_menu` VALUES (1098415756351229955, 1098415756145709058, 41);
INSERT INTO `sys_role_menu` VALUES (1098415756351229956, 1098415756145709058, 42);
INSERT INTO `sys_role_menu` VALUES (1098415756351229957, 1098415756145709058, 43);
INSERT INTO `sys_role_menu` VALUES (1098415756351229958, 1098415756145709058, 44);
INSERT INTO `sys_role_menu` VALUES (1098415756351229959, 1098415756145709058, 45);
INSERT INTO `sys_role_menu` VALUES (1098415756351229960, 1098415756145709058, 46);
INSERT INTO `sys_role_menu` VALUES (1098415756359618561, 1098415756145709058, 47);
INSERT INTO `sys_role_menu` VALUES (1098415756359618562, 1098415756145709058, 48);
INSERT INTO `sys_role_menu` VALUES (1098415756359618563, 1098415756145709058, 49);
INSERT INTO `sys_role_menu` VALUES (1098415756359618564, 1098415756145709058, 50);
INSERT INTO `sys_role_menu` VALUES (1098431558173388801, 1098431558068531201, 1);
INSERT INTO `sys_role_menu` VALUES (1098431558185971713, 1098431558068531201, 2);
INSERT INTO `sys_role_menu` VALUES (1098431558185971714, 1098431558068531201, 3);
INSERT INTO `sys_role_menu` VALUES (1098431558185971715, 1098431558068531201, 4);
INSERT INTO `sys_role_menu` VALUES (1098431558185971716, 1098431558068531201, 5);
INSERT INTO `sys_role_menu` VALUES (1098431558194360321, 1098431558068531201, 6);
INSERT INTO `sys_role_menu` VALUES (1098431558194360322, 1098431558068531201, 7);
INSERT INTO `sys_role_menu` VALUES (1098431558194360323, 1098431558068531201, 8);
INSERT INTO `sys_role_menu` VALUES (1098431558194360324, 1098431558068531201, 9);
INSERT INTO `sys_role_menu` VALUES (1098431558194360325, 1098431558068531201, 10);
INSERT INTO `sys_role_menu` VALUES (1098431558202748929, 1098431558068531201, 11);
INSERT INTO `sys_role_menu` VALUES (1098431558202748930, 1098431558068531201, 12);
INSERT INTO `sys_role_menu` VALUES (1098431558202748931, 1098431558068531201, 13);
INSERT INTO `sys_role_menu` VALUES (1098431558202748932, 1098431558068531201, 14);
INSERT INTO `sys_role_menu` VALUES (1098431558202748933, 1098431558068531201, 15);
INSERT INTO `sys_role_menu` VALUES (1098431558202748934, 1098431558068531201, 16);
INSERT INTO `sys_role_menu` VALUES (1098431558211137538, 1098431558068531201, 17);
INSERT INTO `sys_role_menu` VALUES (1098431558211137539, 1098431558068531201, 18);
INSERT INTO `sys_role_menu` VALUES (1098431558211137540, 1098431558068531201, 19);
INSERT INTO `sys_role_menu` VALUES (1098431558211137541, 1098431558068531201, 20);
INSERT INTO `sys_role_menu` VALUES (1098431558211137542, 1098431558068531201, 21);
INSERT INTO `sys_role_menu` VALUES (1098431558211137543, 1098431558068531201, 22);
INSERT INTO `sys_role_menu` VALUES (1098431558211137544, 1098431558068531201, 23);
INSERT INTO `sys_role_menu` VALUES (1098431558219526145, 1098431558068531201, 24);
INSERT INTO `sys_role_menu` VALUES (1098431558219526146, 1098431558068531201, 25);
INSERT INTO `sys_role_menu` VALUES (1098431558219526147, 1098431558068531201, 26);
INSERT INTO `sys_role_menu` VALUES (1098431558219526148, 1098431558068531201, 27);
INSERT INTO `sys_role_menu` VALUES (1098431558219526149, 1098431558068531201, 29);
INSERT INTO `sys_role_menu` VALUES (1098431558219526150, 1098431558068531201, 30);
INSERT INTO `sys_role_menu` VALUES (1098431558219526151, 1098431558068531201, 31);
INSERT INTO `sys_role_menu` VALUES (1098431558219526152, 1098431558068531201, 32);
INSERT INTO `sys_role_menu` VALUES (1098431558219526153, 1098431558068531201, 33);
INSERT INTO `sys_role_menu` VALUES (1098431558227914753, 1098431558068531201, 34);
INSERT INTO `sys_role_menu` VALUES (1098431558227914754, 1098431558068531201, 35);
INSERT INTO `sys_role_menu` VALUES (1098431558227914755, 1098431558068531201, 36);
INSERT INTO `sys_role_menu` VALUES (1098431558227914756, 1098431558068531201, 37);
INSERT INTO `sys_role_menu` VALUES (1098431558227914757, 1098431558068531201, 38);
INSERT INTO `sys_role_menu` VALUES (1098431558227914758, 1098431558068531201, 39);
INSERT INTO `sys_role_menu` VALUES (1098431558227914759, 1098431558068531201, 40);
INSERT INTO `sys_role_menu` VALUES (1098431558227914760, 1098431558068531201, 41);
INSERT INTO `sys_role_menu` VALUES (1098431558227914761, 1098431558068531201, 42);
INSERT INTO `sys_role_menu` VALUES (1098431558227914762, 1098431558068531201, 43);
INSERT INTO `sys_role_menu` VALUES (1098431558227914763, 1098431558068531201, 44);
INSERT INTO `sys_role_menu` VALUES (1098431558227914764, 1098431558068531201, 45);
INSERT INTO `sys_role_menu` VALUES (1098431558227914765, 1098431558068531201, 46);
INSERT INTO `sys_role_menu` VALUES (1098431558227914766, 1098431558068531201, 47);
INSERT INTO `sys_role_menu` VALUES (1098431558227914767, 1098431558068531201, 48);
INSERT INTO `sys_role_menu` VALUES (1098431558227914768, 1098431558068531201, 49);
INSERT INTO `sys_role_menu` VALUES (1098431558227914769, 1098431558068531201, 50);
INSERT INTO `sys_role_menu` VALUES (1098431558227914770, 1098431558068531202, 1);
INSERT INTO `sys_role_menu` VALUES (1098431558227914771, 1098431558068531202, 2);
INSERT INTO `sys_role_menu` VALUES (1098431558227914772, 1098431558068531202, 3);
INSERT INTO `sys_role_menu` VALUES (1098431558227914773, 1098431558068531202, 4);
INSERT INTO `sys_role_menu` VALUES (1098431558227914774, 1098431558068531202, 5);
INSERT INTO `sys_role_menu` VALUES (1098431558227914775, 1098431558068531202, 6);
INSERT INTO `sys_role_menu` VALUES (1098431558227914776, 1098431558068531202, 7);
INSERT INTO `sys_role_menu` VALUES (1098431558227914777, 1098431558068531202, 8);
INSERT INTO `sys_role_menu` VALUES (1098431558227914778, 1098431558068531202, 9);
INSERT INTO `sys_role_menu` VALUES (1098431558227914779, 1098431558068531202, 10);
INSERT INTO `sys_role_menu` VALUES (1098431558227914780, 1098431558068531202, 11);
INSERT INTO `sys_role_menu` VALUES (1098431558227914781, 1098431558068531202, 12);
INSERT INTO `sys_role_menu` VALUES (1098431558227914782, 1098431558068531202, 13);
INSERT INTO `sys_role_menu` VALUES (1098431558227914783, 1098431558068531202, 14);
INSERT INTO `sys_role_menu` VALUES (1098431558227914784, 1098431558068531202, 15);
INSERT INTO `sys_role_menu` VALUES (1098431558227914785, 1098431558068531202, 16);
INSERT INTO `sys_role_menu` VALUES (1098431558227914786, 1098431558068531202, 17);
INSERT INTO `sys_role_menu` VALUES (1098431558227914787, 1098431558068531202, 18);
INSERT INTO `sys_role_menu` VALUES (1098431558227914788, 1098431558068531202, 19);
INSERT INTO `sys_role_menu` VALUES (1098431558227914789, 1098431558068531202, 20);
INSERT INTO `sys_role_menu` VALUES (1098431558227914790, 1098431558068531202, 21);
INSERT INTO `sys_role_menu` VALUES (1098431558227914791, 1098431558068531202, 22);
INSERT INTO `sys_role_menu` VALUES (1098431558227914792, 1098431558068531202, 23);
INSERT INTO `sys_role_menu` VALUES (1098431558227914793, 1098431558068531202, 24);
INSERT INTO `sys_role_menu` VALUES (1098431558227914794, 1098431558068531202, 25);
INSERT INTO `sys_role_menu` VALUES (1098431558227914795, 1098431558068531202, 26);
INSERT INTO `sys_role_menu` VALUES (1098431558227914796, 1098431558068531202, 27);
INSERT INTO `sys_role_menu` VALUES (1098431558227914797, 1098431558068531202, 29);
INSERT INTO `sys_role_menu` VALUES (1098431558227914798, 1098431558068531202, 30);
INSERT INTO `sys_role_menu` VALUES (1098431558227914799, 1098431558068531202, 31);
INSERT INTO `sys_role_menu` VALUES (1098431558227914800, 1098431558068531202, 32);
INSERT INTO `sys_role_menu` VALUES (1098431558227914801, 1098431558068531202, 33);
INSERT INTO `sys_role_menu` VALUES (1098431558227914802, 1098431558068531202, 34);
INSERT INTO `sys_role_menu` VALUES (1098431558227914803, 1098431558068531202, 35);
INSERT INTO `sys_role_menu` VALUES (1098431558227914804, 1098431558068531202, 36);
INSERT INTO `sys_role_menu` VALUES (1098431558227914805, 1098431558068531202, 37);
INSERT INTO `sys_role_menu` VALUES (1098431558227914806, 1098431558068531202, 38);
INSERT INTO `sys_role_menu` VALUES (1098431558227914807, 1098431558068531202, 39);
INSERT INTO `sys_role_menu` VALUES (1098431558227914808, 1098431558068531202, 40);
INSERT INTO `sys_role_menu` VALUES (1098431558227914809, 1098431558068531202, 41);
INSERT INTO `sys_role_menu` VALUES (1098431558227914810, 1098431558068531202, 42);
INSERT INTO `sys_role_menu` VALUES (1098431558227914811, 1098431558068531202, 43);
INSERT INTO `sys_role_menu` VALUES (1098431558227914812, 1098431558068531202, 44);
INSERT INTO `sys_role_menu` VALUES (1098431558227914813, 1098431558068531202, 45);
INSERT INTO `sys_role_menu` VALUES (1098431558227914814, 1098431558068531202, 46);
INSERT INTO `sys_role_menu` VALUES (1098431558227914815, 1098431558068531202, 47);
INSERT INTO `sys_role_menu` VALUES (1098431558227914816, 1098431558068531202, 48);
INSERT INTO `sys_role_menu` VALUES (1098431558227914817, 1098431558068531202, 49);
INSERT INTO `sys_role_menu` VALUES (1098431558227914818, 1098431558068531202, 50);
INSERT INTO `sys_role_menu` VALUES (1098431558227914819, 1098431558068531203, 1);
INSERT INTO `sys_role_menu` VALUES (1098431558227914820, 1098431558068531203, 2);
INSERT INTO `sys_role_menu` VALUES (1098431558227914821, 1098431558068531203, 3);
INSERT INTO `sys_role_menu` VALUES (1098431558227914822, 1098431558068531203, 4);
INSERT INTO `sys_role_menu` VALUES (1098431558227914823, 1098431558068531203, 5);
INSERT INTO `sys_role_menu` VALUES (1098431558227914824, 1098431558068531203, 6);
INSERT INTO `sys_role_menu` VALUES (1098431558227914825, 1098431558068531203, 7);
INSERT INTO `sys_role_menu` VALUES (1098431558227914826, 1098431558068531203, 8);
INSERT INTO `sys_role_menu` VALUES (1098431558227914827, 1098431558068531203, 9);
INSERT INTO `sys_role_menu` VALUES (1098431558227914828, 1098431558068531203, 10);
INSERT INTO `sys_role_menu` VALUES (1098431558227914829, 1098431558068531203, 11);
INSERT INTO `sys_role_menu` VALUES (1098431558227914830, 1098431558068531203, 12);
INSERT INTO `sys_role_menu` VALUES (1098431558227914831, 1098431558068531203, 13);
INSERT INTO `sys_role_menu` VALUES (1098431558227914832, 1098431558068531203, 14);
INSERT INTO `sys_role_menu` VALUES (1098431558227914833, 1098431558068531203, 15);
INSERT INTO `sys_role_menu` VALUES (1098431558227914834, 1098431558068531203, 16);
INSERT INTO `sys_role_menu` VALUES (1098431558227914835, 1098431558068531203, 17);
INSERT INTO `sys_role_menu` VALUES (1098431558227914836, 1098431558068531203, 18);
INSERT INTO `sys_role_menu` VALUES (1098431558227914837, 1098431558068531203, 19);
INSERT INTO `sys_role_menu` VALUES (1098431558227914838, 1098431558068531203, 20);
INSERT INTO `sys_role_menu` VALUES (1098431558227914839, 1098431558068531203, 21);
INSERT INTO `sys_role_menu` VALUES (1098431558227914840, 1098431558068531203, 22);
INSERT INTO `sys_role_menu` VALUES (1098431558227914841, 1098431558068531203, 23);
INSERT INTO `sys_role_menu` VALUES (1098431558227914842, 1098431558068531203, 24);
INSERT INTO `sys_role_menu` VALUES (1098431558227914843, 1098431558068531203, 25);
INSERT INTO `sys_role_menu` VALUES (1098431558227914844, 1098431558068531203, 26);
INSERT INTO `sys_role_menu` VALUES (1098431558227914845, 1098431558068531203, 27);
INSERT INTO `sys_role_menu` VALUES (1098431558227914846, 1098431558068531203, 29);
INSERT INTO `sys_role_menu` VALUES (1098431558227914847, 1098431558068531203, 30);
INSERT INTO `sys_role_menu` VALUES (1098431558227914848, 1098431558068531203, 31);
INSERT INTO `sys_role_menu` VALUES (1098431558227914849, 1098431558068531203, 32);
INSERT INTO `sys_role_menu` VALUES (1098431558227914850, 1098431558068531203, 33);
INSERT INTO `sys_role_menu` VALUES (1098431558227914851, 1098431558068531203, 34);
INSERT INTO `sys_role_menu` VALUES (1098431558227914852, 1098431558068531203, 35);
INSERT INTO `sys_role_menu` VALUES (1098431558227914853, 1098431558068531203, 36);
INSERT INTO `sys_role_menu` VALUES (1098431558227914854, 1098431558068531203, 37);
INSERT INTO `sys_role_menu` VALUES (1098431558227914855, 1098431558068531203, 38);
INSERT INTO `sys_role_menu` VALUES (1098431558227914856, 1098431558068531203, 39);
INSERT INTO `sys_role_menu` VALUES (1098431558227914857, 1098431558068531203, 40);
INSERT INTO `sys_role_menu` VALUES (1098431558227914858, 1098431558068531203, 41);
INSERT INTO `sys_role_menu` VALUES (1098431558227914859, 1098431558068531203, 42);
INSERT INTO `sys_role_menu` VALUES (1098431558227914860, 1098431558068531203, 43);
INSERT INTO `sys_role_menu` VALUES (1098431558227914861, 1098431558068531203, 44);
INSERT INTO `sys_role_menu` VALUES (1098431558227914862, 1098431558068531203, 45);
INSERT INTO `sys_role_menu` VALUES (1098431558227914863, 1098431558068531203, 46);
INSERT INTO `sys_role_menu` VALUES (1098431558227914864, 1098431558068531203, 47);
INSERT INTO `sys_role_menu` VALUES (1098431558227914865, 1098431558068531203, 48);
INSERT INTO `sys_role_menu` VALUES (1098431558227914866, 1098431558068531203, 49);
INSERT INTO `sys_role_menu` VALUES (1098431558227914867, 1098431558068531203, 50);
INSERT INTO `sys_role_menu` VALUES (1098431558227914868, 1098431558068531204, 1);
INSERT INTO `sys_role_menu` VALUES (1098431558227914869, 1098431558068531204, 2);
INSERT INTO `sys_role_menu` VALUES (1098431558227914870, 1098431558068531204, 3);
INSERT INTO `sys_role_menu` VALUES (1098431558227914871, 1098431558068531204, 4);
INSERT INTO `sys_role_menu` VALUES (1098431558227914872, 1098431558068531204, 5);
INSERT INTO `sys_role_menu` VALUES (1098431558227914873, 1098431558068531204, 6);
INSERT INTO `sys_role_menu` VALUES (1098431558227914874, 1098431558068531204, 7);
INSERT INTO `sys_role_menu` VALUES (1098431558227914875, 1098431558068531204, 8);
INSERT INTO `sys_role_menu` VALUES (1098431558227914876, 1098431558068531204, 9);
INSERT INTO `sys_role_menu` VALUES (1098431558227914877, 1098431558068531204, 10);
INSERT INTO `sys_role_menu` VALUES (1098431558227914878, 1098431558068531204, 11);
INSERT INTO `sys_role_menu` VALUES (1098431558227914879, 1098431558068531204, 12);
INSERT INTO `sys_role_menu` VALUES (1098431558227914880, 1098431558068531204, 13);
INSERT INTO `sys_role_menu` VALUES (1098431558227914881, 1098431558068531204, 14);
INSERT INTO `sys_role_menu` VALUES (1098431558227914882, 1098431558068531204, 15);
INSERT INTO `sys_role_menu` VALUES (1098431558227914883, 1098431558068531204, 16);
INSERT INTO `sys_role_menu` VALUES (1098431558227914884, 1098431558068531204, 17);
INSERT INTO `sys_role_menu` VALUES (1098431558227914885, 1098431558068531204, 18);
INSERT INTO `sys_role_menu` VALUES (1098431558227914886, 1098431558068531204, 19);
INSERT INTO `sys_role_menu` VALUES (1098431558227914887, 1098431558068531204, 20);
INSERT INTO `sys_role_menu` VALUES (1098431558227914888, 1098431558068531204, 21);
INSERT INTO `sys_role_menu` VALUES (1098431558227914889, 1098431558068531204, 22);
INSERT INTO `sys_role_menu` VALUES (1098431558227914890, 1098431558068531204, 23);
INSERT INTO `sys_role_menu` VALUES (1098431558227914891, 1098431558068531204, 24);
INSERT INTO `sys_role_menu` VALUES (1098431558227914892, 1098431558068531204, 25);
INSERT INTO `sys_role_menu` VALUES (1098431558227914893, 1098431558068531204, 26);
INSERT INTO `sys_role_menu` VALUES (1098431558227914894, 1098431558068531204, 27);
INSERT INTO `sys_role_menu` VALUES (1098431558227914895, 1098431558068531204, 29);
INSERT INTO `sys_role_menu` VALUES (1098431558227914896, 1098431558068531204, 30);
INSERT INTO `sys_role_menu` VALUES (1098431558227914897, 1098431558068531204, 31);
INSERT INTO `sys_role_menu` VALUES (1098431558227914898, 1098431558068531204, 32);
INSERT INTO `sys_role_menu` VALUES (1098431558227914899, 1098431558068531204, 33);
INSERT INTO `sys_role_menu` VALUES (1098431558227914900, 1098431558068531204, 34);
INSERT INTO `sys_role_menu` VALUES (1098431558227914901, 1098431558068531204, 35);
INSERT INTO `sys_role_menu` VALUES (1098431558227914902, 1098431558068531204, 36);
INSERT INTO `sys_role_menu` VALUES (1098431558227914903, 1098431558068531204, 37);
INSERT INTO `sys_role_menu` VALUES (1098431558227914904, 1098431558068531204, 38);
INSERT INTO `sys_role_menu` VALUES (1098431558227914905, 1098431558068531204, 39);
INSERT INTO `sys_role_menu` VALUES (1098431558227914906, 1098431558068531204, 40);
INSERT INTO `sys_role_menu` VALUES (1098431558227914907, 1098431558068531204, 41);
INSERT INTO `sys_role_menu` VALUES (1098431558227914908, 1098431558068531204, 42);
INSERT INTO `sys_role_menu` VALUES (1098431558227914909, 1098431558068531204, 43);
INSERT INTO `sys_role_menu` VALUES (1098431558227914910, 1098431558068531204, 44);
INSERT INTO `sys_role_menu` VALUES (1098431558227914911, 1098431558068531204, 45);
INSERT INTO `sys_role_menu` VALUES (1098431558227914912, 1098431558068531204, 46);
INSERT INTO `sys_role_menu` VALUES (1098431558227914913, 1098431558068531204, 47);
INSERT INTO `sys_role_menu` VALUES (1098431558227914914, 1098431558068531204, 48);
INSERT INTO `sys_role_menu` VALUES (1098431558227914915, 1098431558068531204, 49);
INSERT INTO `sys_role_menu` VALUES (1098431558227914916, 1098431558068531204, 50);
INSERT INTO `sys_role_menu` VALUES (1098431558227914917, 1098431558068531204, 51);
INSERT INTO `sys_role_menu` VALUES (1098431558227914918, 1098431558068531205, 1);
INSERT INTO `sys_role_menu` VALUES (1098431558227914919, 1098431558068531205, 2);
INSERT INTO `sys_role_menu` VALUES (1098431558227914920, 1098431558068531205, 3);
INSERT INTO `sys_role_menu` VALUES (1098431558227914921, 1098431558068531205, 4);
INSERT INTO `sys_role_menu` VALUES (1098431558227914922, 1098431558068531205, 5);
INSERT INTO `sys_role_menu` VALUES (1098431558227914923, 1098431558068531205, 6);
INSERT INTO `sys_role_menu` VALUES (1098431558227914924, 1098431558068531205, 7);
INSERT INTO `sys_role_menu` VALUES (1098431558227914925, 1098431558068531205, 8);
INSERT INTO `sys_role_menu` VALUES (1098431558227914926, 1098431558068531205, 9);
INSERT INTO `sys_role_menu` VALUES (1098431558227914927, 1098431558068531205, 10);
INSERT INTO `sys_role_menu` VALUES (1098431558227914928, 1098431558068531205, 11);
INSERT INTO `sys_role_menu` VALUES (1098431558227914929, 1098431558068531205, 12);
INSERT INTO `sys_role_menu` VALUES (1098431558227914930, 1098431558068531205, 13);
INSERT INTO `sys_role_menu` VALUES (1098431558227914931, 1098431558068531205, 14);
INSERT INTO `sys_role_menu` VALUES (1098431558227914932, 1098431558068531205, 15);
INSERT INTO `sys_role_menu` VALUES (1098431558227914933, 1098431558068531205, 16);
INSERT INTO `sys_role_menu` VALUES (1098431558227914934, 1098431558068531205, 17);
INSERT INTO `sys_role_menu` VALUES (1098431558227914935, 1098431558068531205, 18);
INSERT INTO `sys_role_menu` VALUES (1098431558227914936, 1098431558068531205, 19);
INSERT INTO `sys_role_menu` VALUES (1098431558227914937, 1098431558068531205, 20);
INSERT INTO `sys_role_menu` VALUES (1098431558227914938, 1098431558068531205, 21);
INSERT INTO `sys_role_menu` VALUES (1098431558227914939, 1098431558068531205, 22);
INSERT INTO `sys_role_menu` VALUES (1098431558227914940, 1098431558068531205, 23);
INSERT INTO `sys_role_menu` VALUES (1098431558227914941, 1098431558068531205, 24);
INSERT INTO `sys_role_menu` VALUES (1098431558227914942, 1098431558068531205, 25);
INSERT INTO `sys_role_menu` VALUES (1098431558227914943, 1098431558068531205, 26);
INSERT INTO `sys_role_menu` VALUES (1098431558227914944, 1098431558068531205, 27);
INSERT INTO `sys_role_menu` VALUES (1098431558227914945, 1098431558068531205, 29);
INSERT INTO `sys_role_menu` VALUES (1098431558227914946, 1098431558068531205, 30);
INSERT INTO `sys_role_menu` VALUES (1098431558227914947, 1098431558068531205, 31);
INSERT INTO `sys_role_menu` VALUES (1098431558227914948, 1098431558068531205, 32);
INSERT INTO `sys_role_menu` VALUES (1098431558227914949, 1098431558068531205, 33);
INSERT INTO `sys_role_menu` VALUES (1098431558227914950, 1098431558068531205, 34);
INSERT INTO `sys_role_menu` VALUES (1098431558227914951, 1098431558068531205, 35);
INSERT INTO `sys_role_menu` VALUES (1098431558227914952, 1098431558068531205, 36);
INSERT INTO `sys_role_menu` VALUES (1098431558227914953, 1098431558068531205, 37);
INSERT INTO `sys_role_menu` VALUES (1098431558227914954, 1098431558068531205, 38);
INSERT INTO `sys_role_menu` VALUES (1098431558227914955, 1098431558068531205, 39);
INSERT INTO `sys_role_menu` VALUES (1098431558227914956, 1098431558068531205, 40);
INSERT INTO `sys_role_menu` VALUES (1098431558227914957, 1098431558068531205, 41);
INSERT INTO `sys_role_menu` VALUES (1098431558227914958, 1098431558068531205, 42);
INSERT INTO `sys_role_menu` VALUES (1098431558227914959, 1098431558068531205, 43);
INSERT INTO `sys_role_menu` VALUES (1098431558227914960, 1098431558068531205, 44);
INSERT INTO `sys_role_menu` VALUES (1098431558227914961, 1098431558068531205, 45);
INSERT INTO `sys_role_menu` VALUES (1098431558227914962, 1098431558068531205, 46);
INSERT INTO `sys_role_menu` VALUES (1098431558227914963, 1098431558068531205, 47);
INSERT INTO `sys_role_menu` VALUES (1098431558227914964, 1098431558068531205, 48);
INSERT INTO `sys_role_menu` VALUES (1098431558227914965, 1098431558068531205, 49);
INSERT INTO `sys_role_menu` VALUES (1098431558227914966, 1098431558068531205, 50);
INSERT INTO `sys_role_menu` VALUES (1098431558227914967, 1098431558068531205, 51);
INSERT INTO `sys_role_menu` VALUES (1098431558227915216, 1, 1);
INSERT INTO `sys_role_menu` VALUES (1098431558227915217, 1, 2);
INSERT INTO `sys_role_menu` VALUES (1098431558227915218, 1, 3);
INSERT INTO `sys_role_menu` VALUES (1098431558227915219, 1, 4);
INSERT INTO `sys_role_menu` VALUES (1098431558227915220, 1, 5);
INSERT INTO `sys_role_menu` VALUES (1098431558227915221, 1, 6);
INSERT INTO `sys_role_menu` VALUES (1098431558227915222, 1, 7);
INSERT INTO `sys_role_menu` VALUES (1098431558227915223, 1, 8);
INSERT INTO `sys_role_menu` VALUES (1098431558227915224, 1, 9);
INSERT INTO `sys_role_menu` VALUES (1098431558227915225, 1, 10);
INSERT INTO `sys_role_menu` VALUES (1098431558227915226, 1, 11);
INSERT INTO `sys_role_menu` VALUES (1098431558227915227, 1, 12);
INSERT INTO `sys_role_menu` VALUES (1098431558227915228, 1, 13);
INSERT INTO `sys_role_menu` VALUES (1098431558227915229, 1, 14);
INSERT INTO `sys_role_menu` VALUES (1098431558227915230, 1, 15);
INSERT INTO `sys_role_menu` VALUES (1098431558227915231, 1, 16);
INSERT INTO `sys_role_menu` VALUES (1098431558227915232, 1, 17);
INSERT INTO `sys_role_menu` VALUES (1098431558227915233, 1, 18);
INSERT INTO `sys_role_menu` VALUES (1098431558227915234, 1, 19);
INSERT INTO `sys_role_menu` VALUES (1098431558227915235, 1, 20);
INSERT INTO `sys_role_menu` VALUES (1098431558227915236, 1, 21);
INSERT INTO `sys_role_menu` VALUES (1098431558227915237, 1, 22);
INSERT INTO `sys_role_menu` VALUES (1098431558227915238, 1, 23);
INSERT INTO `sys_role_menu` VALUES (1098431558227915239, 1, 24);
INSERT INTO `sys_role_menu` VALUES (1098431558227915240, 1, 25);
INSERT INTO `sys_role_menu` VALUES (1098431558227915241, 1, 26);
INSERT INTO `sys_role_menu` VALUES (1098431558227915242, 1, 27);
INSERT INTO `sys_role_menu` VALUES (1098431558227915243, 1, 29);
INSERT INTO `sys_role_menu` VALUES (1098431558227915244, 1, 30);
INSERT INTO `sys_role_menu` VALUES (1098431558227915245, 1, 31);
INSERT INTO `sys_role_menu` VALUES (1098431558227915246, 1, 32);
INSERT INTO `sys_role_menu` VALUES (1098431558227915247, 1, 33);
INSERT INTO `sys_role_menu` VALUES (1098431558227915248, 1, 34);
INSERT INTO `sys_role_menu` VALUES (1098431558227915249, 1, 35);
INSERT INTO `sys_role_menu` VALUES (1098431558227915250, 1, 36);
INSERT INTO `sys_role_menu` VALUES (1098431558227915251, 1, 37);
INSERT INTO `sys_role_menu` VALUES (1098431558227915252, 1, 38);
INSERT INTO `sys_role_menu` VALUES (1098431558227915253, 1, 39);
INSERT INTO `sys_role_menu` VALUES (1098431558227915254, 1, 40);
INSERT INTO `sys_role_menu` VALUES (1098431558227915255, 1, 41);
INSERT INTO `sys_role_menu` VALUES (1098431558227915256, 1, 42);
INSERT INTO `sys_role_menu` VALUES (1098431558227915257, 1, 43);
INSERT INTO `sys_role_menu` VALUES (1098431558227915258, 1, 44);
INSERT INTO `sys_role_menu` VALUES (1098431558227915259, 1, 45);
INSERT INTO `sys_role_menu` VALUES (1098431558227915260, 1, 46);
INSERT INTO `sys_role_menu` VALUES (1098431558227915261, 1, 47);
INSERT INTO `sys_role_menu` VALUES (1098431558227915262, 1, 48);
INSERT INTO `sys_role_menu` VALUES (1098431558227915263, 1, 49);
INSERT INTO `sys_role_menu` VALUES (1098431558227915264, 1, 50);
INSERT INTO `sys_role_menu` VALUES (1098431558227915265, 1, 51);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `password` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '盐',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '状态  0：禁用   1：正常',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'defaultAvatar.png' COMMENT '头像',
  `signature` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '座右铭',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '', 'e1153123d7d180ceeb820d577ff119876678732a68eef4e6ffc0b1f06a01f91b', 'YzcmCZNvbXocrsz9dm8e', '123145@qq.com', '12345698711', 1, 4, '02549f9c-3ae9-45db-b873-635f06e0df09.jpeg', '', '2016-11-11 11:11:11');
INSERT INTO `sys_user` VALUES (3, 'teywteyw', NULL, '0a1ade81f7129dd4fa42ca8cd8adac668649cc88456d969b89de6601a1fa5f79', 'QpW0JznfOZvuNG4hhB1W', 'q@q.com', '11111111111', 1, 3, 'defaultAvatar.png', NULL, '2019-02-15 18:26:08');
INSERT INTO `sys_user` VALUES (4, '12313', NULL, '575abe148ca8cac7dc1f9f09f29d791fefe079995537b25ed1e2056952416621', 'XX8X9T3hfhfPzyCGzJfR', '643935700@qq.con', '13245685210', 1, 1, 'defaultAvatar.png', NULL, '2019-02-21 14:27:02');
INSERT INTO `sys_user` VALUES (5, 'test1', NULL, '7be0f9939da642910b6889b1787eb20245b420370151769d60787ca3a5e4fc2c', 'g6IW3Oc9pW6Z9KzfygXv', '123@qqq.com', '12345678977', 1, 3, 'defaultAvatar.png', NULL, '2019-04-17 18:01:54');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NULL DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) NULL DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1087608018633302025 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户与角色对应关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1087608018633302018, 1087608018549415938, 1);
INSERT INTO `sys_user_role` VALUES (1087608018633302021, 4, 1098431558068531203);
INSERT INTO `sys_user_role` VALUES (1087608018633302022, 3, 1);
INSERT INTO `sys_user_role` VALUES (1087608018633302024, 5, 1);

-- ----------------------------
-- Table structure for wx_appinfo
-- ----------------------------
DROP TABLE IF EXISTS `wx_appinfo`;
CREATE TABLE `wx_appinfo`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序ID',
  `secret` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '小程序secret',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '小程序名',
  `token` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '消息token',
  `aeskey` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '消息aeskey',
  `access_token` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信访问token',
  `last_token_time` datetime(0) NULL DEFAULT NULL COMMENT '上次生成accesstoken时间',
  `expires_in` int(11) NULL DEFAULT 7200 COMMENT '微信token有效时间单位（秒）',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '说明',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `appid_index`(`appid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '小程序相关配置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of wx_appinfo
-- ----------------------------
INSERT INTO `wx_appinfo` VALUES (1, 'wx91101e95149c98da', '1bab55240809c25e3757c4f65a79588e', '姗姗生产', NULL, NULL, NULL, NULL, 7200, NULL);
INSERT INTO `wx_appinfo` VALUES (3, 'wx4ee818d7d071c361', '91fa95d13d3cba85ca1c57bc58d317ae', '姗姗测试', NULL, NULL, '15_Od9srvHayi7JhpvHD31EQOD3HcHTOpczFoFXiXoYLJIYpRGOHpiqtp6RNN6tC59S0vPqPknTPjBy--aQw9aatS6x54r2T9HoQLLoJqiDJA5_pdqCADe3LAElNGrGEGGIAV5qq9EJTe139ASzVWRdAIAGHC', '2018-10-26 14:38:40', 7200, NULL);

-- ----------------------------
-- Table structure for wx_user
-- ----------------------------
DROP TABLE IF EXISTS `wx_user`;
CREATE TABLE `wx_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `open_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '微信openId',
  `session_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `qrcode_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '注册时记录用户扫码渠道，如朋友圈广告',
  `register_ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户注册IP',
  `union_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '微信unionId',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `nick_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `gender` tinyint(4) NULL DEFAULT NULL COMMENT '用户头像地址',
  `avatar_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户头像地址',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户所在城市',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户所在省份',
  `language` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户所在语言',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户绑定的手机号',
  `pure_phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户没有区号的手机号',
  `country_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户手机区号',
  `is_new` tinyint(1) NULL DEFAULT NULL COMMENT '是否为商户侧的拉新用户',
  `vip_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '会员id',
  `member_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '会员绑定手机号',
  `share_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '如果是扫码进入，存放二维码id，记录二维码信息；如果是通过分享进入，记录分享人信息',
  `dept_id` int(11) NULL DEFAULT NULL COMMENT '如果是扫码进来，可以存放所扫码所属部门',
  `dept_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '部门推广码',
  `id_card` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户身份证信息',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '姓名',
  `webid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '华联与微众唯一key，默认第一次注册手机号',
  `webank` tinyint(2) NULL DEFAULT NULL COMMENT '是否微众轻会员',
  `scene` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '二维码',
  `hdcard_member_id` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '线下会员号',
  `ident_code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '会员身份识别码',
  `scene_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '渠道',
  `create_date` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `open_id_index`(`open_id`) USING BTREE,
  INDEX `dept_id_index`(`dept_id`) USING BTREE,
  INDEX `share_id_index`(`share_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '微信小程序用户信息' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
