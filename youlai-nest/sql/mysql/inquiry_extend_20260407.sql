SET @db := DATABASE();

-- model
SET @has_model := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'inquiry' AND COLUMN_NAME = 'model'
);
SET @sql := IF(@has_model = 0, 'ALTER TABLE `inquiry` ADD COLUMN `model` varchar(50) NULL COMMENT ''型号'' AFTER `locale`', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- quantity
SET @has_quantity := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'inquiry' AND COLUMN_NAME = 'quantity'
);
SET @sql := IF(@has_quantity = 0, 'ALTER TABLE `inquiry` ADD COLUMN `quantity` varchar(100) NULL COMMENT ''数量'' AFTER `model`', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- color
SET @has_color := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'inquiry' AND COLUMN_NAME = 'color'
);
SET @sql := IF(@has_color = 0, 'ALTER TABLE `inquiry` ADD COLUMN `color` varchar(50) NULL COMMENT ''颜色'' AFTER `quantity`', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- length
SET @has_length := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'inquiry' AND COLUMN_NAME = 'length'
);
SET @sql := IF(@has_length = 0, 'ALTER TABLE `inquiry` ADD COLUMN `length` varchar(50) NULL COMMENT ''长度'' AFTER `color`', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- tenacity
SET @has_tenacity := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'inquiry' AND COLUMN_NAME = 'tenacity'
);
SET @sql := IF(@has_tenacity = 0, 'ALTER TABLE `inquiry` ADD COLUMN `tenacity` varchar(50) NULL COMMENT ''强度'' AFTER `length`', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- productId
SET @has_pid := (
  SELECT COUNT(*) FROM information_schema.COLUMNS
  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'inquiry' AND COLUMN_NAME = 'product_id'
);
SET @sql := IF(@has_pid = 0, 'ALTER TABLE `inquiry` ADD COLUMN `product_id` bigint NULL COMMENT ''关联产品ID'' AFTER `tenacity`', 'SELECT 1');
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

