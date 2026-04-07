ALTER TABLE `article_lang`
  DROP COLUMN `seo_title`,
  CHANGE COLUMN `seo_keywords` `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键词',
  CHANGE COLUMN `seo_description` `description` varchar(500) NOT NULL DEFAULT '' COMMENT '描述';

ALTER TABLE `product_lang`
  DROP COLUMN `seo_title`,
  CHANGE COLUMN `seo_keywords` `keywords` varchar(255) NOT NULL DEFAULT '' COMMENT '关键词',
  CHANGE COLUMN `seo_description` `description` varchar(500) NOT NULL DEFAULT '' COMMENT '描述';

