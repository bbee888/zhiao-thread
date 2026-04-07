SET @db := DATABASE();

SET @has_color := (
  SELECT COUNT(*)
  FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'product' AND COLUMN_NAME = 'color'
);
SET @sql := IF(@has_color = 0, 'ALTER TABLE `product` ADD COLUMN `color` varchar(50) NOT NULL DEFAULT '''' COMMENT ''颜色'' AFTER `model`', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @has_length := (
  SELECT COUNT(*)
  FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'product' AND COLUMN_NAME = 'length'
);
SET @sql := IF(@has_length = 0, 'ALTER TABLE `product` ADD COLUMN `length` varchar(50) NOT NULL DEFAULT '''' COMMENT ''长度'' AFTER `color`', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @has_tenacity := (
  SELECT COUNT(*)
  FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'product' AND COLUMN_NAME = 'tenacity'
);
SET @sql := IF(@has_tenacity = 0, 'ALTER TABLE `product` ADD COLUMN `tenacity` varchar(50) NOT NULL DEFAULT '''' COMMENT ''强力'' AFTER `length`', 'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

INSERT INTO `sys_dict` (`dict_code`, `name`, `status`, `remark`, `create_time`, `create_by`, `update_time`, `update_by`, `is_deleted`)
SELECT 'product_model', '产品型号', 1, NULL, NOW(), 1, NOW(), 1, 0
WHERE NOT EXISTS (SELECT 1 FROM `sys_dict` WHERE `dict_code` = 'product_model' AND `is_deleted` = 0);

INSERT INTO `sys_dict` (`dict_code`, `name`, `status`, `remark`, `create_time`, `create_by`, `update_time`, `update_by`, `is_deleted`)
SELECT 'color', '颜色', 1, NULL, NOW(), 1, NOW(), 1, 0
WHERE NOT EXISTS (SELECT 1 FROM `sys_dict` WHERE `dict_code` = 'color' AND `is_deleted` = 0);

INSERT INTO `sys_dict` (`dict_code`, `name`, `status`, `remark`, `create_time`, `create_by`, `update_time`, `update_by`, `is_deleted`)
SELECT 'length', '长度', 1, NULL, NOW(), 1, NOW(), 1, 0
WHERE NOT EXISTS (SELECT 1 FROM `sys_dict` WHERE `dict_code` = 'length' AND `is_deleted` = 0);

INSERT INTO `sys_dict` (`dict_code`, `name`, `status`, `remark`, `create_time`, `create_by`, `update_time`, `update_by`, `is_deleted`)
SELECT 'tenacity', '强力', 1, NULL, NOW(), 1, NOW(), 1, 0
WHERE NOT EXISTS (SELECT 1 FROM `sys_dict` WHERE `dict_code` = 'tenacity' AND `is_deleted` = 0);
