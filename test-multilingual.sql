-- 测试多语言数据保存功能
-- 运行此脚本检查多语言表中的数据

-- 检查文章分类多语言数据
SELECT 
  '文章分类' as type,
  acl.cate_id as id,
  GROUP_CONCAT(CONCAT(acl.lang, ':', acl.name) SEPARATOR ' | ') as lang_data
FROM article_category_lang acl
WHERE acl.is_deleted = 0
GROUP BY acl.cate_id
ORDER BY acl.cate_id DESC
LIMIT 10;

-- 检查文章多语言数据
SELECT 
  '文章' as type,
  al.article_id as id,
  GROUP_CONCAT(CONCAT(al.lang, ':', al.title) SEPARATOR ' | ') as lang_data
FROM article_lang al
WHERE al.is_deleted = 0
GROUP BY al.article_id
ORDER BY al.article_id DESC
LIMIT 10;

-- 检查产品分类多语言数据
SELECT 
  '产品分类' as type,
  pcl.cate_id as id,
  GROUP_CONCAT(CONCAT(pcl.lang, ':', pcl.name) SEPARATOR ' | ') as lang_data
FROM product_category_lang pcl
WHERE pcl.is_deleted = 0
GROUP BY pcl.cate_id
ORDER BY pcl.cate_id DESC
LIMIT 10;

-- 检查产品多语言数据
SELECT 
  '产品' as type,
  pl.product_id as id,
  GROUP_CONCAT(CONCAT(pl.lang, ':', pl.title) SEPARATOR ' | ') as lang_data
FROM product_lang pl
WHERE pl.is_deleted = 0
GROUP BY pl.product_id
ORDER BY pl.product_id DESC
LIMIT 10;
