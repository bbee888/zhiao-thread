CREATE TABLE IF NOT EXISTS `inquiry` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(50) NOT NULL COMMENT '姓名',
  `email` varchar(100) NOT NULL COMMENT '邮箱',
  `company` varchar(100) DEFAULT NULL COMMENT '公司名称',
  `phone` varchar(50) DEFAULT NULL COMMENT '电话/微信',
  `country` varchar(10) NOT NULL COMMENT '国家/地区',
  `interest` varchar(50) DEFAULT NULL COMMENT '感兴趣的产品',
  `subject` varchar(200) NOT NULL COMMENT '主题',
  `message` text NOT NULL COMMENT '留言内容',
  `attachment_name` varchar(255) DEFAULT NULL COMMENT '附件名称',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态（0-未处理 1-已处理）',
  `locale` varchar(10) DEFAULT NULL COMMENT '提交语言',
  `ip` varchar(45) DEFAULT NULL COMMENT 'IP',
  `user_agent` varchar(255) DEFAULT NULL COMMENT 'User-Agent',
  `create_by` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '逻辑删除标识（0-未删除 1-已删除）',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_inquiry_status` (`status`) USING BTREE,
  KEY `idx_inquiry_create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='询盘';

INSERT IGNORE INTO `sys_menu`
(`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `route_path`, `component`, `perm`, `always_show`, `keep_alive`, `visible`, `sort`, `icon`, `redirect`, `create_time`, `update_time`, `params`)
VALUES
  (2813,0,'2813','询盘管理','C',NULL,'/inquiry','Layout',NULL,1,1,1,2,'el-icon-ChatLineSquare','/inquiry/list',NOW(),NOW(),NULL),
  (2814,2813,'2813,2814','询盘列表','M','InquiryList','list','inquiry/list/index',NULL,0,1,1,1,'',NULL,NOW(),NOW(),NULL),
  (2815,2814,'2813,2814,2815','询盘查询','B',NULL,'',NULL,'inquiry:list',NULL,NULL,1,1,'',NULL,NOW(),NOW(),NULL),
  (2816,2814,'2813,2814,2816','询盘查看','B',NULL,'',NULL,'inquiry:detail',NULL,NULL,1,2,'',NULL,NOW(),NOW(),NULL),
  (2817,2814,'2813,2814,2817','询盘编辑','B',NULL,'',NULL,'inquiry:update',NULL,NULL,1,3,'',NULL,NOW(),NOW(),NULL),
  (2818,2814,'2813,2814,2818','询盘删除','B',NULL,'',NULL,'inquiry:delete',NULL,NULL,1,4,'',NULL,NOW(),NOW(),NULL);

INSERT IGNORE INTO `sys_role_menu` (`role_id`, `menu_id`)
VALUES
  (2,2813),
  (2,2814),
  (2,2815),
  (2,2816),
  (2,2817),
  (2,2818);

