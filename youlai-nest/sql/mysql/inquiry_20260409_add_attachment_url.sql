ALTER TABLE `inquiry`
  ADD COLUMN `attachment_url` varchar(1024) DEFAULT NULL COMMENT '附件URL' AFTER `attachment_name`;

