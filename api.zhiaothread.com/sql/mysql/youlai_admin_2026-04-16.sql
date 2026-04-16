# ************************************************************
# Sequel Ace SQL dump
# 版本号： 20099
#
# https://sequel-ace.com/
# https://github.com/Sequel-Ace/Sequel-Ace
#
# 主机: 127.0.0.1 (MySQL 9.6.0)
# 数据库: youlai_admin
# 生成时间: 2026-04-16 00:22:26 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
SET NAMES utf8mb4;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE='NO_AUTO_VALUE_ON_ZERO', SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# 转储表 article
# ------------------------------------------------------------

DROP TABLE IF EXISTS `article`;

CREATE TABLE `article` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` int NOT NULL COMMENT '分类ID',
  `cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '封面图',
  `sort` int DEFAULT '100' COMMENT '排序',
  `status` tinyint DEFAULT '1' COMMENT '1=发布 0=隐藏',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` int DEFAULT NULL,
  `update_by` int DEFAULT NULL,
  `is_deleted` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章';

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;

INSERT INTO `article` (`id`, `cate_id`, `cover`, `sort`, `status`, `create_time`, `update_time`, `create_by`, `update_by`, `is_deleted`)
VALUES
	(1,10,'/oss/20260405/b86c8218-73f7-40ec-82a2-e05b7ee79450.jpg',100,1,'2026-04-01 22:13:46','2026-04-05 13:37:06',2,2,0),
	(2,13,'/oss/20260409/c8b4bed8-59ee-41d7-bc07-a73f9a8f88ad.jpg',100,1,'2026-04-04 22:50:38','2026-04-09 10:18:58',2,2,0);

/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 article_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `article_category`;

CREATE TABLE `article_category` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `sort` int DEFAULT '100' COMMENT '排序',
  `status` tinyint DEFAULT '1' COMMENT '1=启用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `create_by` int DEFAULT NULL COMMENT '用户',
  `update_by` int DEFAULT NULL,
  `is_deleted` tinyint DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章分类';

LOCK TABLES `article_category` WRITE;
/*!40000 ALTER TABLE `article_category` DISABLE KEYS */;

INSERT INTO `article_category` (`id`, `sort`, `status`, `create_time`, `create_by`, `update_by`, `is_deleted`, `update_time`)
VALUES
	(10,100,1,'2026-04-01 16:39:44',2,2,0,'2026-04-01 21:44:35'),
	(11,100,1,'2026-04-02 08:59:50',2,2,1,'2026-04-02 08:59:55'),
	(12,100,1,'2026-04-04 17:09:36',2,2,0,'2026-04-04 17:09:36'),
	(13,100,1,'2026-04-04 17:10:40',2,2,0,'2026-04-04 17:10:40');

/*!40000 ALTER TABLE `article_category` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 article_category_lang
# ------------------------------------------------------------

DROP TABLE IF EXISTS `article_category_lang`;

CREATE TABLE `article_category_lang` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` int NOT NULL COMMENT '分类ID',
  `lang` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '语言',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `create_by` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '修改人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT '0' COMMENT '逻辑删除标识(0-未删除 1-已删除)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cate_lang_unique` (`cate_id`,`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章分类多语言';

LOCK TABLES `article_category_lang` WRITE;
/*!40000 ALTER TABLE `article_category_lang` DISABLE KEYS */;

INSERT INTO `article_category_lang` (`id`, `cate_id`, `lang`, `name`, `create_by`, `create_time`, `update_by`, `update_time`, `is_deleted`)
VALUES
	(7,10,'ar','أخبار الشركة',2,'2026-04-01 21:44:35',2,'2026-04-01 21:44:35',0),
	(8,10,'en','Company News',2,'2026-04-01 21:44:35',2,'2026-04-01 21:44:35',0),
	(9,10,'zh','公司新闻',2,'2026-04-01 21:44:35',2,'2026-04-01 21:44:35',0),
	(10,10,'vi','Tin tức công ty',2,'2026-04-01 21:44:35',2,'2026-04-01 21:44:35',0),
	(11,10,'id','Berita Perusahaan',2,'2026-04-01 21:44:35',2,'2026-04-01 21:44:35',0),
	(12,10,'th','ข่าวสารบริษัท',2,'2026-04-01 21:44:35',2,'2026-04-01 21:44:35',0),
	(13,10,'km','ព័ត៌មានក្រុមហ៊ុន',2,'2026-04-01 21:44:35',2,'2026-04-01 21:44:35',0),
	(14,10,'fr','Actualités de l\'entreprise',2,'2026-04-01 21:44:35',2,'2026-04-01 21:44:35',0),
	(15,10,'it','Notizie aziendali',2,'2026-04-01 21:44:35',2,'2026-04-01 21:44:35',0),
	(17,12,'zh','行业动态',2,'2026-04-04 17:09:36',2,'2026-04-04 17:09:36',0),
	(18,12,'en','Industry Trends',2,'2026-04-04 17:09:36',2,'2026-04-04 17:09:36',0),
	(19,12,'ar','تطورات الصناعة',2,'2026-04-04 17:09:36',2,'2026-04-04 17:09:36',0),
	(20,12,'vi','	Xu hướng ngành',2,'2026-04-04 17:09:36',2,'2026-04-04 17:09:36',0),
	(21,12,'id','Perkembangan Industri',2,'2026-04-04 17:09:36',2,'2026-04-04 17:09:36',0),
	(22,12,'th','แนวโน้มอุตสาหกรรม',2,'2026-04-04 17:09:36',2,'2026-04-04 17:09:36',0),
	(23,12,'km','និន្នាការឧស្សាហកម្ម',2,'2026-04-04 17:09:36',2,'2026-04-04 17:09:36',0),
	(24,12,'fr','Actualités du Secteur',2,'2026-04-04 17:09:36',2,'2026-04-04 17:09:36',0),
	(25,12,'it','Tendenze del Settore',2,'2026-04-04 17:09:36',2,'2026-04-04 17:09:36',0),
	(26,13,'zh','产品指南',2,'2026-04-04 17:10:40',2,'2026-04-04 17:10:40',0),
	(27,13,'en','Product Guide',2,'2026-04-04 17:10:40',2,'2026-04-04 17:10:40',0),
	(28,13,'ar','دليل المنتجات',2,'2026-04-04 17:10:40',2,'2026-04-04 17:10:40',0),
	(29,13,'vi','Hướng dẫn sản phẩm',2,'2026-04-04 17:10:40',2,'2026-04-04 17:10:40',0),
	(30,13,'id','Panduan Produk',2,'2026-04-04 17:10:40',2,'2026-04-04 17:10:40',0),
	(31,13,'th','คู่มือผลิตภัณฑ์',2,'2026-04-04 17:10:40',2,'2026-04-04 17:10:40',0),
	(32,13,'km','សៀវភៅណែនាំផលិតផល',2,'2026-04-04 17:10:40',2,'2026-04-04 17:10:40',0),
	(33,13,'fr','Guide Produit',2,'2026-04-04 17:10:40',2,'2026-04-04 17:10:40',0),
	(34,13,'it','Guida ai Prodotti',2,'2026-04-04 17:10:40',2,'2026-04-04 17:10:40',0);

/*!40000 ALTER TABLE `article_category_lang` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 article_lang
# ------------------------------------------------------------

DROP TABLE IF EXISTS `article_lang`;

CREATE TABLE `article_lang` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int NOT NULL COMMENT '文章ID',
  `lang` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '语言 en/ar/th/ms/id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章标题',
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT '内容',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'SEO关键词',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'SEO描述',
  `create_by` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '修改人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT '0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_lang_unique` (`article_id`,`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='文章多语言';

LOCK TABLES `article_lang` WRITE;
/*!40000 ALTER TABLE `article_lang` DISABLE KEYS */;

INSERT INTO `article_lang` (`id`, `article_id`, `lang`, `title`, `content`, `keywords`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `is_deleted`)
VALUES
	(62,1,'en','标题2','<p>标题2</p>','标题2','标题2',2,'2026-04-05 13:37:06',2,'2026-04-05 13:37:06',0),
	(63,1,'zh','全球供应链调整背景下，中国缝纫线出口的新机遇与挑战','<p style=\"text-align: start;\">当前，全球经济格局与贸易秩序正处于深刻重构期，全球供应链从追求效率优先转向兼顾安全与韧性，区域化、近岸化趋势日益明显。作为纺织服装产业不可或缺的“工业血脉”，缝纫线行业正身处这场变革的风口浪尖。对于全球最大的缝纫线生产与出口国——中国而言，这场供应链调整既是严峻挑战，也蕴含着向价值链上游跃升的历史性机遇。</p><p style=\"text-align: start;\"><strong>一、 直面挑战：多重压力下的出口困局</strong></p><p style=\"text-align: start;\">全球供应链的深度调整，给中国缝纫线出口带来了结构性的压力，主要体现在以下几个方面：</p><p style=\"text-align: start;\">1. 传统市场份额遭遇挤压，订单转移压力持续。近年来，受国际贸易环境变化及成本等因素驱动，部分服装制造业产能向越南、柬埔寨、孟加拉国等东南亚及南亚国家转移。这直接导致了对上游缝纫线等原材料订单的牵引效应。数据显示，我国对部分传统主力出口市场的针织服装及附件出口出现下滑，而同期我国缝制机械对越南、印度、孟加拉等地的出口额却呈现两位数以上的显著增长，这从侧面印证了下游成衣制造产能的迁移趋势，对国内缝纫线企业的出口订单构成了直接分流。</p><p style=\"text-align: start;\">2. 贸易壁垒与技术门槛不断升高。除了关税波动带来的成本不确定性，欧美等主要市场日益严苛的环保、社会责任及技术标准，正成为新的“绿色壁垒”。例如，OEKO-TEX、GRS（全球回收标准）等认证已成为进入高端市场的敲门砖。然而，行业整体在绿色转型上仍面临动力不足、研发投入偏低（普遍不足5%）的困境，高端原材料如己二腈等仍部分依赖进口，使得部分企业在应对国际新规时显得被动。</p><p style=\"text-align: start;\">3. 成本优势减弱与同质化竞争内卷。国内劳动力、环保合规等成本的持续上升，正在削弱传统价格竞争力。与此同时，行业内大量企业仍集中在中低端产品领域，陷入同质化竞争，利润空间被不断压缩，难以支撑面向未来的技术研发与品牌建设投入。</p><p style=\"text-align: start;\"><strong>二、 洞察机遇：在变局中开辟新增长通道</strong></p><p style=\"text-align: start;\">挑战固然严峻，但供应链重构也打破了旧有平衡，为中国缝纫线产业的高质量出口创造了新的切入点。</p><p style=\"text-align: start;\">1. “一带一路”与新兴市场成为增长新引擎。在全球市场格局深度调整的同时，对“一带一路”沿线国家的出口展现出强劲韧性，已成为行业出口的重要压舱石和增长极。我国缝制机械对“一带一路”市场的出口额占比已超过七成，且增速显著。这预示着，随着沿线国家工业化进程加速和纺织服装业发展，其对高品质缝纫线的需求将持续释放，为中国企业提供了广阔的市场替代与拓展空间。</p><p style=\"text-align: start;\">2. 供应链协同与“技术出海”创造新价值。全球供应链重构并非简单的“零和博弈”，而是催生了新的区域协同模式。中国缝纫线产业凭借完整的产业链、持续进步的制造技术以及日益增强的柔性化生产能力，正从单纯的“产品输出”向“技术输出”和“解决方案输出”升级。例如，通过与下游成衣厂在东南亚等地的产能进行配套协同，或向海外客户提供包括高性能特种线、绿色认证产品及数字化生产咨询在内的综合服务，从而嵌入更高层级的价值链。</p><p style=\"text-align: start;\">3. 内需升级与产业转型倒逼产品创新。国内消费市场对高品质、功能性、环保型纺织品的需求增长，以及新能源汽车、户外装备、智能穿戴等新兴领域的崛起，正在倒逼缝纫线产业向高端化、功能化、绿色化转型。抗菌、阻燃、高强耐磨、生物基（如聚乳酸缝纫线）、原液着色（无染缝纫线）等特种和高附加值产品，不仅能够满足国内产业升级需求，更能凭借其技术壁垒形成国际竞争新优势，打破对低成本普通产品的路径依赖。</p><p style=\"text-align: start;\">4. 数字化与柔性供应链提升响应能力。面对全球订单日益呈现的“小单化、快反化”趋势，数字化转型成为构建供应链韧性的关键。通过引入MES系统、AI质检、智能吊挂等技术与设备，企业能够大幅提升生产效率和柔性制造能力，快速响应海外客户的多样化、定制化需求。这种“规模化+定制化+柔性化”的综合能力，正是中国缝纫线出口从“以量取胜”转向“以质和效取胜”的核心竞争力。</p><p style=\"text-align: start;\"><strong>三、 破局之道：迈向“价值突围”的战略路径</strong></p><p style=\"text-align: start;\">为把握机遇、应对挑战，中国缝纫线出口企业需进行系统性战略升级：</p><p style=\"text-align: start;\">1. 坚定技术研发，攻克高端制造壁垒。企业必须加大研发投入，聚焦高性能纤维材料、精密制造工艺、绿色低碳技术等核心环节进行攻关。特别是在可吸收外科缝合线、航空航天特种线带等尖端领域，加速实现进口替代，并争取在全球技术标准制定中拥有话语权。</p><p style=\"text-align: start;\">2. 深化绿色转型，获取全球市场通行证。将环保从成本项转化为价值项，全面推广无水少水染色、再生涤纶、生物可降解材料等绿色技术，积极获取国际认可的环保与社会责任认证。这不仅是突破贸易壁垒的需要，更是塑造负责任品牌形象、获取“绿色溢价”的必然选择。</p><p style=\"text-align: start;\">3. 优化市场布局，实施多元化出口战略。在稳固传统市场的同时，积极开拓“一带一路”、RCEP等新兴市场。通过跨境电商等新渠道，直接触达海外中小品牌和制造商，探索B2C、C2M等新模式，减少对传统大宗贸易的过度依赖。</p><p style=\"text-align: start;\">4. 推动集群升级与跨界融合。行业应鼓励龙头企业发挥引领作用，带动产业集群向专业化、高端化升级。同时，加强产学研用合作，推动缝纫线产业与新材料、智能制造、医疗器械等领域的跨界融合，开拓应急救灾、医疗健康、智能交通等新兴应用蓝海。</p><p style=\"text-align: start;\"><strong>结语</strong></p><p style=\"text-align: start;\">全球供应链的调整，如同一场大考，考验着中国缝纫线产业的根基与韧性。过去依赖“规模红利”的粗放式出口模式已难以为继，未来属于那些能够以技术创新为矛、以绿色智能为盾、以柔性协同为网，勇于向“价值突围”的企业。唯有主动拥抱变革，将挑战转化为淬炼内功的动力，将机遇落地为差异化竞争的优势，中国缝纫线产业方能在重构的全球价值链中占据更有利的位置，让每一根丝线都串联起中国制造迈向高质量发展的新篇章。</p>','缝纫线， 缝纫线行业， 缝纫线选购， 工业缝纫线， 缝纫线生产厂家， 缝纫线种类， 缝纫线价格， 高强缝纫线， 特种缝纫线， 汽车缝纫线','本文深度解析缝纫线行业市场现状、未来发展趋势及核心技术应用。涵盖从传统服装缝纫线到汽车内饰、工业集装袋等特种缝纫线的分类与选用原则，探讨“德国精工”品质标准、智能制造转型以及高附加值产品创新。为缝纫线生产商、采购商及行业从业者提供全面的市场洞察与选型指南。',2,'2026-04-05 13:37:06',2,'2026-04-05 13:37:06',0),
	(64,2,'ar','كيف تختار خياطة مناسبة لأقمشة مختلفة؟','<p><span style=\"color: rgb(0, 0, 0);\">غير you 重要ة في عملية الخياطة، لكنها عنصر أساسي يحدد متانة المنتج النهائي وجاذبيته الجمالية. اختيار خيط خياطة غير مناسب لا يؤدي فقط إلى كسر الخيط المتكرر وتخطي الغرز، بل يضر أيضًا بالأقمشة الثمينة، مما يفسد المشروع بأكمله. تختلف الأقمشة بشكل كبير في مادتها وسماكتها ومرونتها، لذا تختلف خيوط الخياطة المناسبة لها. إتقان تقنيات المطابقة العلمية يمكن أن يعزز كفاءة الخياطة إلى أقصى حد.</span></p><p><span style=\"color: rgb(0, 0, 0);\">قماش القطن هو المادة الأكثر استخدامًا في الحياة اليومية، ويشمل قمصان القطن النقي والملابس المنزلية وملابس القطن. يتميز هذا النوع من القماش بتهوية جيدة ونعومة الملمس، مما يجعل </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">خيوط القطن النقية</span><span style=\"color: rgb(0, 0, 0);\"> هي المطابقة المثالية. تشترك هذه الخيوط في المادة ونسبة التمدد مع قماش القطن، مما يمنع تجاعيد القماش الناتجة عن السحب. وهي أيضًا مقاومة للحرارة، ومناسبة للكي. بالنسبة للقماش الكانفاس السميك والقطن الدنيم، اختر خيوط قطن ذات عدد سميك لزيادة قوة الغرز؛ أما بالنسبة للشاش القطني الخفيف، فاختر خيوط قطن رفيعة لتجنب ارتفاع الغرز الذي يؤثر على المظهر.</span></p><p><span style=\"color: rgb(0, 0, 0);\">الأقمشة الخفيفة مثل الحرير والشيفون والأورجانزا رقيقة وهشة، وعرضة للخدش والتلف. تُفضل </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">خيوط الحرير وخيوط البوليستر فائقة الرقة</span><span style=\"color: rgb(0, 0, 0);\"> لخياطة هذه الأقمشة. الخيط الرفيع والناعم لا يترك ثقوب إبر في القماش. اربطه بإبر خياطة رفيعة لتقليل التلف، وهو مثالي لصنع الفساتين وشالات الحرير والملابس الشفافة لضمان تشطيبات دقيقة.</span></p><p><span style=\"color: rgb(0, 0, 0);\">أقمشة الصوف والصوف السميك سميكة ومرنة مع قدرة عزل حراري ممتازة، وعرضة للتقلص والارتداد أثناء الخياطة. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">خيوط الصوف وخيوط البوليستر عالية المرونة</span><span style=\"color: rgb(0, 0, 0);\"> هي الخيارات المناسبة. تتميز هذه الخيوط بمرونة معينة لتتشكل بشكل متزامن مع القماش، مما يمنع تكسير الغرز بعد الغسيل. تتماشى أقمشة الصوف السميكة مع الخيوط المرنة السميكة، بينما تستخدم أقمشة الصوف الدقيقة خيوط مرنة ناعمة، مما يوازن بين المتانة وراحة ارتداء.</span></p><p><span style=\"color: rgb(0, 0, 0);\">تشمل الأقمشة الاصطناعية البوليستر والنايلون وأقمشة الملابس الرياضية سريعة الجفاف، والتي تتميز بمرونة عالية ومقاومة للتآكل. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">خيوط البوليستر للخياطة</span><span style=\"color: rgb(0, 0, 0);\"> هي المطابقة المثالية. تتميز بقوة عالية ومقاومة للتقلص والبهتان، وتستخدم على نطاق واسع في الملابس الرياضية والأمتعة والمنتجات الخارجية. بالنسبة للأقمشة الاصطناعية عالية المرونة، يمكن استخدام خيوط البوليستر الملفوفة لتلبية متطلبات التمدد الكبير.</span></p><p><span style=\"color: rgb(0, 0, 0);\">الدنيم والكانفاس والجلد هي أقمشة سميكة وصلبة تتطلب متطلبات عالية لقوة خيوط الخياطة. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">خيوط البوليستر عالية القوة وخيوط مزيج القطن والبوليستر</span><span style=\"color: rgb(0, 0, 0);\"> هي الخيارات الأولى للدنيم والكانفاس، وتتميز بمقاومة الاحتكاك وقدرة تحمل ممتازة، وتتجنب الكسر في أجزاء الملابس المعرضة للضغط. أما بالنسبة للجلد، فاستخدم </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">خيوط النايلون وخيوط الشمع الخاصة للجلد</span><span style=\"color: rgb(0, 0, 0);\">. الخيط المُشمع مصقول، وسائل بما يكفي لاختراق الجلد، ومقاوم للماء والتآكل، ويستخدم عادة في حقائب الجلد والسترات والاحذية.</span></p><p><span style=\"color: rgb(0, 0, 0);\">أقمشة التريكو وأقمشة ملابس السباحة عالية المرونة وتلتصق بالجسم، والخيوط العادية عرضة للكسر عند التمدد. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">خيوط النايلون عالية المرونة</span><span style=\"color: rgb(0, 0, 0);\"> تناسب الأقمشة المقاومة للماء مثل ملابس السباحة، مع مرونة ممتازة ومقاومة للماء والتآكل؛ أما بالنسبة لملابس التريكو اليومية، فخيوط البوليستر المرنة تتكيف مع تمدد القماش، مما يضمن بقاء الغرز مرتبة وسليمة عند ارتدائها.</span></p><p><span style=\"color: rgb(0, 0, 0);\">قماش الكتان يتميز بتهوية جيدة وملمس صلب وعرضة للتقلص. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">خيوط الكتان الخاصة أو خيوط القطن النقية</span><span style=\"color: rgb(0, 0, 0);\"> هي أفضل مطابقة، حيث أن نسبة تقلصها تتطابق مع قماش الكتان، مما يتجنب تقلص الغرز والتشوه بعد التنظيف، وهو مثالي لقمصان الكتان والستائر ومفرشات المائدة.</span></p><p><span style=\"color: rgb(0, 0, 0);\">بالإضافة إلى المطابقة حسب مادة القماش، انتبه للتناسق بين سماكة خيوط الخياطة وحجم الإبرة: الأقمشة الخفيفة تُربط بخيوط رفيعة وإبر رفيعة، بينما تستخدم الأقمشة السميكة خيوط سميكة وإبر سميكة. أيضًا، اختر الخيوط بناءً على سيناريوهات الاستخدام: المنتجات الخارجية تُعطي الأولوية للخيوط المقاومة للشمس والتآكل، والملابس الملاصقة للجسم تستخدم خيوط ناعمة وغير متهيجة للجلد.</span></p><p><span style=\"color: rgb(0, 0, 0);\">المطابقة المناسبة بين خيوط الخياطة والقماش تتجنب عيوب الخياطة ويطيل عمر المنتجات النهائية. سواء كانت الخياطة اليدوية أو الإنتاج الصناعي، تذكر قواعد اختيار الخيط الحصرية لأقمشة مختلفة يساعد في إنشاء أعمال خياطة قوية وجميلة بسهولة.</span></p><p><br></p>','خيوط خياطة لأقمشة مختلفة، مطابقة الأقمشة وخيوط الخياطة، خيوط خياطة قماش القطن، خيوط خياطة قماش الحرير، خيوط خياطة الدنيم، دليل اختيار خيوط الخياطة','تشرح هذه المقالة مبادئ مطابقة خيوط الخياطة مع أنواع مختلفة من الأقمشة، وتوصي بخيوط مناسبة للقطن والحرير والصوف والدنيم والجلد وغيرها، مما يساعدك على تجنب كسر الخيط وتلف القماش، وإتقان مهارات اختيار خيوط الخياطة الاحترافية.',2,'2026-04-09 10:18:58',2,'2026-04-09 10:18:58',0),
	(65,2,'en','How to Choose the Right Sewing Thread for Different Fabrics?','<p><span style=\"color: rgb(0, 0, 0);\">Sewing thread may seem insignificant in the sewing process, but it is a core element that determines the durability and aesthetics of the finished product. Choosing the wrong sewing thread not only leads to frequent thread breakage and skipped stitches, but also damages precious fabrics, ruining the entire project. Different fabrics vary greatly in material, thickness and elasticity, so the matching sewing threads differ accordingly. Mastering scientific matching techniques can maximize the efficiency of sewing.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Cotton fabric is the most widely used material in daily life, including pure cotton T-shirts, bedding, and cotton garments. This kind of fabric features great air permeability and soft texture, making </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">pure cotton sewing thread</span><span style=\"color: rgb(0, 0, 0);\"> the ideal match. This thread shares similar material and stretch rate with cotton fabric, preventing fabric wrinkles caused by pulling. It is also heat-resistant, suitable for ironing. For heavy canvas and denim cotton, choose cotton thread with a thicker count to enhance stitching strength; for lightweight cotton gauze, opt for fine-count cotton thread to avoid raised stitches affecting appearance.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Lightweight fabrics such as silk, chiffon and organza are delicate and fragile, prone to snags and damage. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Silk thread and ultra-fine polyester thread</span><span style=\"color: rgb(0, 0, 0);\"> are preferred for sewing these fabrics. The slender and smooth thread leaves no needle holes on the fabric. Pair it with fine sewing needles to reduce damage, perfect for making dresses, silk scarves and sheer garments to ensure exquisite finishes.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Wool and woolen fabrics are thick and elastic with excellent warmth retention, and are prone to shrinking and rebounding during sewing. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Wool thread and high-elastic polyester thread</span><span style=\"color: rgb(0, 0, 0);\"> are suitable choices. These threads have certain elasticity to deform synchronously with the fabric, preventing stitch cracking after washing. Thick woolen fabrics match thick elastic thread, while worsted wool fabrics use fine elastic thread, balancing durability and wearing comfort.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Synthetic fabrics include polyester, nylon and sportswear quick-drying fabrics, featuring high elasticity and wear resistance. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Polyester sewing thread</span><span style=\"color: rgb(0, 0, 0);\"> is the perfect match. It boasts high strength, resistance to shrinkage and fading, widely used for sportswear, luggage and outdoor products. For highly elastic synthetic fabrics, spun spandex thread can be used to meet large stretching demands.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Denim, canvas and leather are heavy and hard fabrics with high requirements for sewing thread strength. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">High-strength polyester thread and cotton-polyester blended thread</span><span style=\"color: rgb(0, 0, 0);\"> are the top choices for denim and canvas, featuring friction resistance and excellent load-bearing capacity, avoiding breakage at stressed parts of garments. For leather, use </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">nylon thread and special waxed thread for leather</span><span style=\"color: rgb(0, 0, 0);\">. The waxed thread is waxed, smooth enough to penetrate leather, and is waterproof and wear-resistant, commonly used for leather bags, jackets and boots.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Knit fabrics and swimsuit fabrics are highly elastic and close-fitting, and regular threads are easy to break under stretching. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Nylon high-elastic thread</span><span style=\"color: rgb(0, 0, 0);\"> suits waterproof fabrics like swimsuits, with excellent elasticity, water resistance and corrosion resistance; for daily knitwear, spandex elastic thread adapts to fabric stretching, ensuring stitches stay loose and intact when worn.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Linen fabric has good air permeability, a stiff texture and is easy to shrink. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Special linen thread or pure cotton thread</span><span style=\"color: rgb(0, 0, 0);\"> is the best match, as their shrinkage rate matches linen fabric, avoiding stitch shrinkage and distortion after cleaning, ideal for linen shirts, curtains and tablecloths.</span></p><p><span style=\"color: rgb(0, 0, 0);\">In addition to matching according to fabric material, pay attention to the coordination between sewing thread thickness and needle size: lightweight fabrics pair with fine thread and fine needles, while heavy fabrics use thick thread and thick needles. Also, select threads based on usage scenarios: outdoor products prioritize sun and wear-resistant threads, and close-fitting garments use skin-friendly and non-irritating threads.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Reasonably matching sewing thread and fabric avoids sewing failures and extends the service life of finished products. Whether for hand sewing or industrial production, remembering the exclusive thread selection rules for different fabrics helps create sturdy and beautiful sewing works easily.</span></p>','sewing thread for different fabrics, fabric and sewing thread matching, cotton fabric sewing thread, silk fabric sewing thread, denim sewing thread, sewing thread selection guide','This article explains the guidelines for matching sewing threads with various fabrics, recommends suitable threads for cotton, silk, wool, denim, leather and more, helping you avoid thread breakage and fabric damage, and master professional sewing thread selection skills.',2,'2026-04-09 10:18:58',2,'2026-04-09 10:18:58',0),
	(66,2,'fr','Comment choisir le fil à coudre adapté à différents tissus?','<p><span style=\"color: rgb(0, 0, 0);\">Le fil à coudre peut sembler anodin dans le processus de couture, mais il constitue un élément clé qui détermine la durabilité et l\'esthétique du produit fini. Choisir le mauvais fil entraîne non seulement des ruptures fréquentes et des points manqués, mais endommage également des tissus précieux, ruinant ainsi tout le projet. Les tissus varient considérablement en matière, épaisseur et élasticité, c\'est pourquoi les fils à coudre correspondants diffèrent. Maîtriser des techniques d\'assemblage scientifiques permet d\'optimiser l\'efficacité de la couture.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Le tissu en coton est le matériau le plus utilisé au quotidien, incluant les t-shirts en coton pur, le linge de lit et les vêtements en coton. Ce type de tissu offre une bonne respirabilité et une texture douce, faisant du </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">fil de coton pur</span><span style=\"color: rgb(0, 0, 0);\"> le choix idéal. Ce fil possède une matière et un taux d\'étirement similaires à ceux du coton, évitant les plis causés par les tiraillements. Il est également résistant à la chaleur, adapté au repassage. Pour la toile et le jean épais, optez pour un fil de coton plus gros afin d renforcer la solidité des points; pour la gaze de coton légère, choisissez un fil de coton fin pour éviter des points en relief qui gâchent l\'apparence.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Les tissus légers tels que la soie, le chiffon et l\'organza sont délicats et fragiles, faciles à accrocher et à abîmer. Le </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">fil de soie et le fil de polyester ultra-fin</span><span style=\"color: rgb(0, 0, 0);\"> sont privilégiés pour coudre ces tissus. Le fil fin et lisse ne laisse pas de trous d\'aiguille sur le tissu. Associez-le à une aiguille fine pour réduire les dommages, idéal pour confectionner des robes de soirée, des écharpes en soie et des vêtements transparents, garantissant une finition exquise.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Les tissus en laine et lainages sont épais et élastiques, avec une excellente isolation thermique, et ont tendance à rétrécir pendant la couture. Le </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">fil de laine et le fil de polyester haute élasticité</span><span style=\"color: rgb(0, 0, 0);\"> sont des choix adaptés. Ces fils possèdent une certaine élasticité pour se déformer en même temps que le tissu, empêchant les points de craquer après le lavage. Les lainages épais s\'associent à du fil élastique gros, tandis que les tissus en laine fines utilisent un fil élastique fin, équilibrant durabilité et confort de port.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Les tissus synthétiques comprennent le polyester, le nylon et les tissus séchants rapides pour vêtements de sport, caractérisés par une haute élasticité et une résistance à l\'usure. Le </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">fil de polyester</span><span style=\"color: rgb(0, 0, 0);\"> est l\'association parfaite. Il offre une grande solidité, résiste au rétrécissement et à la décoloration, et est largement utilisé pour les vêtements de sport, les bagages et les articles de plein air. Pour les tissus synthétiques très élastiques, le fil de spandex peut être utilisé pour répondre aux besoins de grands étirements.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Le jean, la toile et le cuir sont des tissus épais et durs, exigant une grande résistance du fil à coudre. Le </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">fil de polyester haute résistance et le fil mélangé coton-polyester</span><span style=\"color: rgb(0, 0, 0);\"> sont les premiers choix pour le jean et la toile, résistant aux frottements et dotés d\'une excellente capacité portante, évitant les ruptures au niveau des zones sollicitées des vêtements. Pour le cuir, utilisez </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">du fil de nylon et du fil ciré spécial pour cuir</span><span style=\"color: rgb(0, 0, 0);\">. Le fil ciré est lisse pour traverser le cuir, et est également imperméable et résistant à l\'usure, souvent employé pour les sacs, vestes et chaussures en cuir.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Les tissus tricotés et les maillots de bain sont très élastiques et moulants, les fils ordinaires cassent facilement sous étirement. Le </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">fil de nylon haute élasticité</span><span style=\"color: rgb(0, 0, 0);\"> convient aux tissus imperméables comme les maillots de bain, avec une excellente élasticité, imperméabilité et résistance à la corrosion; pour les tricots quotidiens, le fil élastique en spandex s\'adapte à l\'étirement du tissu, assurant que les points ne se serrent pas et ne se cassent pas au port.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Le tissu en lin possède une bonne respirabilité, une texture rigide et a tendance à rétrécir. Le </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">fil spécial pour lin ou le fil de coton pur</span><span style=\"color: rgb(0, 0, 0);\"> est le meilleur choix, car leur taux de rétrécissement correspond à celui du lin, évitant la déformation des points après lavage, idéal pour les chemises en lin, rideaux et nappes.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Outre l\'assemblage selon la matière du tissu, faites attention à la compatibilité entre l\'épaisseur du fil et la taille de l\'aiguille: les tissus légers s\'associent à du fil fin et une aiguille fine, tandis que les tissus épais utilisent du fil gros et une aiguille épaisse. Choisissez également le fil en fonction du contexte d\'utilisation: les articles de plein air privilégient des fils résistants au soleil et à l\'usure, les vêtements près du corps utilisent des fils doux et non irritants pour la peau.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Un assemblage judicieux entre fil à coudre et tissu permet d\'éviter les défauts de couture et de prolonger la durée de vie des produits finis. Que ce soit pour la couture à la main ou la production industrielle, retenir les règles de choix de fil spécifiques à différents tissus aide à réaliser facilement des ouvrages solides et élégants.</span></p><p><br></p>','fil à coudre pour différents tissus, assortiment tissus et fil à coudre, fil à coudre pour coton, fil à coudre pour soie, fil à coudre pour jean, guide de choix du fil à coudre','Cet article explique les principes d\'assortiment du fil à coudre avec divers tissus, recommande des fils adaptés pour le coton, la soie, la laine, le jean, le cuir, vous aide à éviter les ruptures de fil et les dommages sur les tissus, et maîtriser des techniques professionnelles de choix du fil à coudre.',2,'2026-04-09 10:18:58',2,'2026-04-09 10:18:58',0),
	(67,2,'id','Bagaimana Memilih Benang Jahit yang Sesuai untuk Berbagai Jenis Kain?','<p><span style=\"color: rgb(0, 0, 0);\">Benang jahit mungkin tampak tidak penting dalam proses menjahit, namun merupakan elemen inti yang menentukan daya tahan dan estetika produk jadi. Memilih benang jahit yang salah tidak hanya menyebabkan benang sering putus dan jahitan meloncat, tetapi juga merusak kain berharga, sehingga merusak seluruh proyek. Berbagai kain memiliki perbedaan besar dalam material, ketebalan dan elastisitas, sehingga benang jahit yang cocok juga berbeda. Menguasai teknik pencocokan ilmiah dapat memaksimalkan efisiensi menjahit.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Kain katun adalah bahan yang paling banyak digunakan dalam kehidupan sehari-hari, termasuk kaos katun murni, perlengkapan tempat tidur, dan pakaian katun. Jenis kain ini memiliki permeabilitas udara yang baik dan tekstur lembut, menjadikan </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">benang katun murni</span><span style=\"color: rgb(0, 0, 0);\"> sebagai pilihan yang ideal. Benang ini memiliki material dan tingkat peregangan yang mirip dengan kain katun, mencegah kerutan kain akibat tarikan. Ini juga tahan panas, cocok untuk proses setrika. Untuk kanvas tebal dan katun denim, pilih benang katun dengan ukuran lebih tebal untuk meningkatkan kekuatan jahitan; untuk kain katun tipis, pilih benang katun halus untuk menghindari jahitan menonjol yang memengaruhi penampilan.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Kain tipis seperti sutra, chiffon dan organza halus dan rapuh, mudah tersangkut dan rusak. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Benang sutra dan benang poliester sangat halus</span><span style=\"color: rgb(0, 0, 0);\"> lebih disukai untuk menjahit kain ini. Benang yang ramping dan halus tidak meninggalkan lubang jarum pada kain. Pasangkan dengan jarum jahit halus untuk mengurangi kerusakan, sempurna untuk membuat gaun pesta, syal sutra, dan pakaian transparan guna memastikan hasil akhir yang indah.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Kain wol dan wol tebal memiliki elastisitas dan kemampuan menahan panas yang sangat baik, mudah menyusut selama menjahit. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Benang wol dan benang poliester elastis tinggi</span><span style=\"color: rgb(0, 0, 0);\"> adalah pilihan yang cocok. Jenis benang ini memiliki elastisitas tertentu untuk berubah bentuk secara bersamaan dengan kain, mencegah jahitan retak setelah dicuci. Kain wol tebal cocok dengan benang elastis tebal, sementara kain wol halus menggunakan benang elastis halus, menyeimbangkan daya tahan dan kenyamanan pemakaian.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Kain sintetis termasuk poliester, nilon dan kain cepat kering pakaian olahraga, memiliki elastisitas tinggi dan tahan aus. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Benang jahit poliester</span><span style=\"color: rgb(0, 0, 0);\"> adalah pilihan yang sempurna. Ini memiliki kekuatan tinggi, tahan susut dan pudar, banyak digunakan untuk pakaian olahraga, tas dan produk luar ruangan. Untuk kain sintetis dengan elastisitas tinggi, benang spandeks dapat digunakan untuk memenuhi kebutuhan peregangan besar.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Denim, kanvas dan kulit adalah kain tebal dan keras dengan persyaratan tinggi terhadap kekuatan benang jahit. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Benang poliester kekuatan tinggi dan benang campuran katun-poliester</span><span style=\"color: rgb(0, 0, 0);\"> adalah pilihan utama untuk denim dan kanvas, tahan gesekan dan memiliki daya dukung yang sangat baik, menghindari putus di bagian pakaian yang menerima tekanan. Untuk kulit, gunakan </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">benang nilon dan benang lilin khusus untuk kulit</span><span style=\"color: rgb(0, 0, 0);\">. Benang lilin dilapisi lilin, cukup halus untuk menembus kulit, serta tahan air dan aus, umum digunakan untuk tas kulit, jaket kulit dan sepatu kulit.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Kain rajut dan kain pakaian renang bersifat elastis tinggi dan ketat terhadap tubuh, benang biasa mudah putus saat diregangkan. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Benang nilon elastis tinggi</span><span style=\"color: rgb(0, 0, 0);\"> cocok untuk kain tahan air seperti pakaian renang, dengan elastisitas sangat baik, tahan air dan korosi; untuk pakaian rajut sehari-hari, benang elastis spandeks beradaptasi dengan peregangan kain, memastikan jahitan tidak kencang dan tidak retak saat dipakai.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Kain linen memiliki permeabilitas udara yang baik, tekstur kaku dan mudah menyusut. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Benang khusus linen atau benang katun murni</span><span style=\"color: rgb(0, 0, 0);\"> adalah pilihan terbaik, karena tingkat penyusutannya sesuai dengan kain linen, menghindari penyusutan dan deformasi jahitan setelah dibersihkan, ideal untuk kemeja linen, gorden dan taplak meja.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Selain mencocokkan berdasarkan material kain, perhatikan kesesuaian antara ketebalan benang jahit dan ukuran jarum: kain tipis dipasangkan dengan benang halus dan jarum halus, sementara kain tebal menggunakan benang tebal dan jarum tebal. Selain itu, pilih benang berdasarkan skenario penggunaan: produk luar ruangan mengutamakan benang tahan sinar matahari dan aus, pakaian ketat menggunakan benang yang ramah kulit dan tidak iritasi.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Pencocokan yang wajar antara benang jahit dan kain menghindari kegagalan menjahit dan memperpanjang umur produk jadi. Baik menjahit tangan maupun produksi industri, mengingat aturan pemilihan benang eksklusif untuk berbagai kain membantu menciptakan karya jahit yang kokoh dan indah dengan mudah.</span></p>','benang jahit untuk berbagai kain, pencocokan kain dan benang jahit, benang jahit kain katun, benang jahit kain sutra, benang jahit denim, panduan memilih benang jahit','Artikel ini menjelaskan pedoman pencocokan benang jahit dengan berbagai jenis kain, merekomendasikan benang yang cocok untuk katun, sutra, wol, denim, kulit dan lainnya, membantu Anda menghindari benang putus dan kerusakan kain, serta menguasai keterampilan memilih benang jahit profesional.',2,'2026-04-09 10:18:58',2,'2026-04-09 10:18:58',0),
	(68,2,'it','Come scegliere il filo da cucire adatto per diversi tessuti?','<p><span style=\"color: rgb(0, 0, 0);\">Il filo da cucire può sembrare insignificante nel processo di cucitura, ma è un elemento fondamentale che determina la durata e l\'estetica del prodotto finito. Scegliere il filo sbagliato non solo causa rotture frequenti e punti saltati, ma danneggia anche tessuti preziosi, rovinando l\'intero progetto. I tessuti variano notevolmente per materiale, spessore ed elasticità, quindi i fili da cucire corrispondenti sono differenti. Padroneggiare tecniche di abbinamento scientifiche permette di ottimizzare l\'efficienza della cucitura.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Il tessuto di cotone è il materiale più utilizzato nella vita quotidiana, comprese magliette di cotone puro, biancheria da letto e abiti in cotone. Questo tipo di tessuto ha una buona traspirabilità e una texture morbida, rendendo il </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">filo di cotone puro</span><span style=\"color: rgb(0, 0, 0);\"> la scelta ideale. Questo filo ha materiale e tasso di allungamento simili a quelli del cotone, prevenendo le pieghe causate dalle trazioni. È anche resistente al calore, adatto per la stiratura. Per la tela e il jeans spessi, scegli un filo di cotone più oftenato per aumentare la resistenza dei punti; per la garza di cotone leggera, opta per un filo di cotone fine per evitare punti in rilievo che rovinano l\'aspetto.</span></p><p><span style=\"color: rgb(0, 0, 0);\">I tessuti leggeri come seta, chiffon e organza sono delicati e fragili, facili da impigliarsi e danneggiare. Il </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">filo di seta e il filo di poliestere ultrafine</span><span style=\"color: rgb(0, 0, 0);\"> sono preferiti per cucire questi tessuti. Il filo sottile e liscio non lascia fori d\'ago sul tessuto. Abbinalo a un ago sottile per ridurre i danni, perfetto per realizzare abiti da sera, sciarpe di seta e capi trasparenti, garantendo finiture squisite.</span></p><p><span style=\"color: rgb(0, 0, 0);\">I tessuti di lana e pannolenci sono spessi ed elastici, con un ottimo isolamento termico, e tendono a restringersi durante la cucitura. Il </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">filo di lana e il filo di poliestere ad alta elasticità</span><span style=\"color: rgb(0, 0, 0);\"> sono scelte adatte. Questi fili hanno una certa elasticità per deformarsi simultaneamente al tessuto, evitando la rottura dei punti dopo il lavaggio. I pannolenci spessi si abbinano a fili elastici grossi, mentre i tessuti di lana fine usano fili elastici sottili, bilanciando durata e comfort di indosso.</span></p><p><span style=\"color: rgb(0, 0, 0);\">I tessuti sintetici includono poliestere, nylon e tessuti ad asciugatura rapida per abbigliamento sportivo, caratterizzati da alta elasticità e resistenza all\'usura. Il </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">filo da cucire in poliestere</span><span style=\"color: rgb(0, 0, 0);\"> è l\'abbinamento perfetto. Ha un\'elevata resistenza, resiste al restringimento e allo sbiadimento, ed è ampiamente utilizzato per abbigliamento sportivo, bagagli e articoli all\'aperto. Per i tessuti sintetici ad alta elasticità, si può usare il filo di spandex per soddisfare le esigenze di grandi allungamenti.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Jeans, tela e pelle sono tessuti spessi e duri, con elevate esigenze di resistenza del filo da cucire. Il </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">filo di poliestere ad alta resistenza e il filo misto cotone-poliestere</span><span style=\"color: rgb(0, 0, 0);\"> sono le prime scelte per jeans e tela, resistenti all\'attrito e con un\'ottima capacità portante, evitando rotture nelle parti sollecitate dei capi. Per la pelle, usa </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">filo di nylon e filo cerato speciale per pelle</span><span style=\"color: rgb(0, 0, 0);\">. Il filo cerato è liscio da attraversare la pelle, inoltre è impermeabile e resistente all\'usura, spesso impiegato per borse, giacche e scarpe in pelle.</span></p><p><span style=\"color: rgb(0, 0, 0);\">I tessuti a maglia e i costumi da bagno sono altamente elastici e aderenti, i fili comuni si rompono facilmente sotto allungamento. Il </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">filo di nylon ad alta elasticità</span><span style=\"color: rgb(0, 0, 0);\"> è adatto per tessuti impermeabili come i costumi da bagno, con ottima elasticità, impermeabilità e resistenza alla corrosione; per i capi a maglia quotidiani, il filo elastico in spandex si adatta all\'allungamento del tessuto, assicurando che i punti non si stringano e non si rompano durante l\'uso.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Il tessuto di lino ha una buona traspirabilità, texture rigida e tende a restringersi. Il </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">filo speciale per lino o il filo di cotone puro</span><span style=\"color: rgb(0, 0, 0);\"> è la scelta migliore, poiché il loro tasso di restringimento corrisponde a quello del lino, evitando la deformazione dei punti dopo il lavaggio, ideale per camicie di lino, tende e tovaglie.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Oltre all\'abbinamento in base al materiale del tessuto, prestare attenzione alla compatibilità tra spessore del filo e dimensione dell\'ago: i tessuti leggeri si abbinano a fili sottili e aghi fini, mentre i tessuti spessi usano fili grossi e aghi spessi. Scegli inoltre il filo in base allo scenario d\'uso: gli articoli all\'aperto privilegiano fili resistenti al sole e all\'usura, i capi aderenti usano fili morbidi e non irritanti per la pelle.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Un abbinamento ragionevole tra filo da cucire e tessuto evita difetti di cucitura e prolunga la durata dei prodotti finiti. Che si tratti di cucitura a mano o produzione industriale, ricordare le regole di scelta del filo specifiche per diversi tessuti aiuta a realizzare facilmente lavori di cucitura solidi ed eleganti.</span></p>','filo da cucire per diversi tessuti, abbinamento tessuti e filo da cucire, filo da cucire per cotone, filo da cucire per seta, filo da cucire per jeans, guida alla scelta del filo da cucire','Questo articolo spiega i principi di abbinamento del filo da cucire con vari tessuti, consiglia fili adatti per cotone, seta, lana, jeans, pelle, aiutandoti a evitare rotture del filo e danni ai tessuti, e a padroneggiare tecniche professionali di scelta del filo da cucire.',2,'2026-04-09 10:18:58',2,'2026-04-09 10:18:58',0),
	(69,2,'km','របៀបជ្រើសខ្សែស្នែងសំរាប់ប្រភេទផ្សេងៗនៃក្រណាត់','<p><span style=\"color: rgb(0, 0, 0);\">ខ្សែស្នែងប្រហែលជាមិនសំខាន់ក្នុងដំណើរការស្នែងក្រណាត់ ប៉ុន្តែវាជាធាតុស្នូលដែលកំណត់ភាពធន់និងភាពស្រស់ស្អាតនៃផលិតផលបញ្ចប់។ ការជ្រើសខ្សែស្នែងមិនត្រឹមតែបណ្តាលឱ្យខ្សែស្នែងបែកខ្ញែក និងខ្វះចន្លោះញឹកញាប់ប៉ុណ្ណោះទេ ថែមទាំងធ្វើឱ្យខូចក្រណាត់ដែលមានតម្លៃ ធ្វើឱ្យគម្រោងទាំងមូលខូច។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ក្រណាត់ប្រភេទផ្សេងៗមានភាពខុសប្លែកគ្នាយ៉ាងខ្លាំងនៅក្នុងវត្ថុធាតុ ក្រាស់ និងភាពបត់បែន ដូច្នេះខ្សែស្នែងដែលសមស្របក៏មានភាពខុសប្លែកគ្នាដែរ។ ការស្ទង់មតិបច្ចេកទេសផ្សំដែលមានតម្លៃវិទ្យាសាស្ត្រអាចបង្កើនប្រសិទ្ធភាពស្នែងក្រណាត់ឱ្យអតិបរមា។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ក្រណាត់កប្បាសគឺជាវត្ថុធាតុដែលប្រើប្រាស់ច្រើនបំផុតក្នុងជីវិតប្រចាំថ្ងៃ រួមមានអាវយឺតកប្បាសសុទ្ធ សំភារៈគ្រែ និងសម្លៀកបំពាក់ក្រណាត់កប្បាស។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ប្រភេទក្រណាត់នេះមានការបញ្ជូនខ្យល់បរិស្ថានល្អ និងមានលក្ខណៈទន់ភ្លន់ ធ្វើឱ្យ</span><span style=\"color: rgb(0, 0, 0); font-size: 16px;\">ខ្សែស្នែងកប្បាសសុទ្ធ</span><span style=\"color: rgb(0, 0, 0);\">ក្លាយជាជម្រើសដ៏ល្អឥតខ្ចោះ។ ខ្សែស្នែងនេះមានវត្ថុធាតុ និងអត្រាបត់បែនស្រដៀងនឹងក្រណាត់កប្បាស ការពារការបត់បែនពីការអូសទាញ។ វាក៏អត់ធ្មត់នឹងកំដៅផងដែរ សមស្របសម្រាប់ការដុតក្រណាត់។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ចំពោះក្រណាត់ក្រណាត់ក្រាស់ និងកប្បាសជិន ជ្រើសខ្សែស្នែងកប្បាសដែលមានទំហំក្រាស់ដើម្បីបង្កើនភាពរឹងមាំនៃស្នែង; ចំពោះក្រណាត់តុស្នែងកប្បាសស្តើង ជ្រើសខ្សែស្នែងកប្បាសល្អិតដើម្បីចៀសវាងស្នែងលេចចេញដែលប៉ះពាល់ដល់រូបរាង។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ក្រណាត់ស្តើងដូចជាសូត្រ ស៊ីហ្វុង និងអូហ្គែនហ្សាមានលក្ខណៈល្អិត និងផុយស្រួយ ងាយខូចពីការច្របាច់។</span></p><p><span style=\"color: rgb(0, 0, 0); font-size: 16px;\">ខ្សែស្នែងសូត្រ និងខ្សែស្នែងប៉ូលីអេស្ទើរល្អិតបំផុត</span><span style=\"color: rgb(0, 0, 0);\">គឺជាជម្រើសដំបូងសម្រាប់ស្នែងក្រណាត់ប្រភេទនេះ។ ខ្សែស្នែងស្តើង និងរលោងមិនបន្សល់ទុកនូវរន្ធដំបងនៅលើក្រណាត់។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ផ្សំជាមួយដំបងស្នែងល្អិតដើម្បីកាត់បន្ថយការខូចខាត ស័ក្តិសមសម្រាប់ធ្វើសម្លៀកបំពាក់ពិធី ស្ប៉ាសូត្រ និងសម្លៀកបំពាក់ប្រហុក ដើម្បីធានាបាននូវលទ្ធផលដ៏ឆ្ងាញ់។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ក្រណាត់ចៀម និងក្រណាត់ចៀមក្រាស់មានភាពក្រាស់ និងបត់បែន ជាមួយនឹងសមត្ថភាពការពារកម្ដៅដ៏ល្អ ច្រើនតែបត់បែនក្នុងពេលស្នែង។</span></p><p><span style=\"color: rgb(0, 0, 0); font-size: 16px;\">ខ្សែស្នែងចៀម និងខ្សែស្នែងប៉ូលីអេស្ទើរមានបត់បែនខ្ពស់</span><span style=\"color: rgb(0, 0, 0);\">គឺជាជម្រើសដ៏សមស្រប។ ប្រភេទខ្សែស្នែងនេះមានភាពបត់បែនជាក់លាក់ដើម្បីផ្លាស់ប្តូររូបរាងស្របគ្នាជាមួយក្រណាត់ ការពារស្នែងបែកបន្ទាប់ពីលាង។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ក្រណាត់ចៀមក្រាស់ផ្សំជាមួយខ្សែស្នែងបត់បែនក្រាស់ ចំណែកក្រណាត់ចៀមល្អិតប្រើខ្សែស្នែងបត់បែនល្អិត ធ្វើឱ្យមានតុល្យភាពរវាងភាពធន់ និងផាសុកភាពពេលស្លៀក។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ក្រណាត់សំយោគរួមមានប៉ូលីអេស្ទើរ នីឡុង និងក្រណាត់ស្ងួតរហ័សសម្រាប់សម្លៀកបំពាក់កីឡា មានលក្ខណៈបត់បែនខ្ពស់ និងអត់ធ្មត់នឹងការសឹក។</span></p><p><span style=\"color: rgb(0, 0, 0); font-size: 16px;\">ខ្សែស្នែងប៉ូលីអេស្ទើរ</span><span style=\"color: rgb(0, 0, 0);\">គឺជាជម្រើសដ៏ល្អឥតខ្ចោះ។ វាមានភាពរឹងមាំខ្ពស់ អត់ធ្មត់នឹងការបត់បែន និងច្រេះពណ៌ ប្រើប្រាស់យ៉ាងទូលំទូលាយសម្រាប់សម្លៀកបំពាក់កីឡា កាបូប និងផលិតផលក្រៅផ្ទះ។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ចំពោះក្រណាត់សំយោគដែលមានបត់បែនខ្ពស់ អាចប្រើខ្សែស្នែងស្ពានដេកដើម្បីបំពេញតម្រូវការបត់បែនដ៏ធំ។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ជិន ក្រណាត់ក្រណាត់ និងស្បែកគឺជាក្រណាត់ក្រាស់ និងរឹង ដែលមានតម្រូវការខ្ពស់ចំពោះភាពរឹងមាំនៃខ្សែស្នែង។</span></p><p><span style=\"color: rgb(0, 0, 0); font-size: 16px;\">ខ្សែស្នែងប៉ូលីអេស្ទើររឹងមាំខ្ពស់ និងខ្សែស្នែងចម្រុះកប្បាស-ប៉ូលីអេស្ទើរ</span><span style=\"color: rgb(0, 0, 0);\">គឺជាជម្រើសដំបូងសម្រាប់ជិន និងក្រណាត់ក្រណាត់ អត់ធ្មត់នឹងការកកិត និងមានសមត្ថភាពផ្ទុកទម្ងន់ដ៏ល្អ ចៀសវាងការបែកនៅផ្នែកទទួលកម្លាំងនៃសម្លៀកបំពាក់។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ចំពោះក្រណាត់ស្បែក សូមប្រើ</span><span style=\"color: rgb(0, 0, 0); font-size: 16px;\">ខ្សែស្នែងនីឡុង និងខ្សែស្នែងក្រអូបពិសេសសម្រាប់ស្បែក</span><span style=\"color: rgb(0, 0, 0);\">។ ខ្សែស្នែងក្រអូបត្រូវបានបោះពុម្ពក្រអូប រលោងគ្រប់គ្រាន់ដើម្បីជ្រាបចូលស្បែក ហើយក៏អត់ធ្មត់នឹងទឹក និងការសឹកដែរ ជារឿយៗប្រើសម្រាប់កាបូបស្បែក អាវស្បែក និងស្បែកជើង។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ក្រណាត់ត្បាញ និងក្រណាត់សម្លៀកបំពាក់ហែលទឹកមានបត់បែនខ្ពស់ និងស្លៀកជិតរាងកាយ ខ្សែស្នែងធម្មតាងាយបែកពេលបត់បែន។</span></p><p><span style=\"color: rgb(0, 0, 0); font-size: 16px;\">ខ្សែស្នែងនីឡុងបត់បែនខ្ពស់</span><span style=\"color: rgb(0, 0, 0);\">សមស្របនឹងក្រណាត់អត់ធ្មត់នឹងទឹកដូចជាសម្លៀកបំពាក់ហែលទឹកមានភាពបត់បែនដ៏ល្អ អត់ធ្មត់នឹងទឹក និងការច្រេះ; ចំពោះសម្លៀកបំពាក់ត្បាញប្រចាំថ្ងៃ ខ្សែស្នែងបត់បែនស្ពានដេកសម្របខ្លួនទៅនឹងការបត់បែននៃក្រណាត់ ដើម្បីធានាថាស្នែងមិនតឹង និងមិនបែកពេលស្លៀក។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ក្រណាត់លីនេនមានការបញ្ជូនខ្យល់បរិស្ថានល្អ មានលក្ខណៈរឹង និងងាយបត់បែន។</span></p><p><span style=\"color: rgb(0, 0, 0); font-size: 16px;\">ខ្សែស្នែងពិសេសសម្រាប់លីនេន ឬខ្សែស្នែងកប្បាសសុទ្ធ</span><span style=\"color: rgb(0, 0, 0);\">គឺជាជម្រើសដ៏ល្អបំផុត ពីព្រោះអត្រាបត់បែនរបស់វាស្របគ្នានឹងក្រណាត់លីនេន ចៀសវាងការបត់បែន និងការបង្ក្រាបនៃស្នែងបន្ទាប់ពីលាង ស័ក្តិសមសម្រាប់អាវស្រីលីនេន ជង់ក្រណាត់ និងកន្សែងតុ។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ក្រៅពីការផ្សំដោយផ្អែកលើវត្ថុធាតុក្រណាត់ សូមយកចិត្តទុកដាក់លើភាពស្របគ្នារវាងកម្រាស់ខ្សែស្នែង និងទំហំដំបង។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ក្រណាត់ស្តើងផ្សំជាមួយខ្សែស្នែងល្អិត និងដំបងល្អិត ចំណែកក្រណាត់ក្រាស់ប្រើខ្សែស្នែងក្រាស់ និងដំបងក្រាស់។</span></p><p><span style=\"color: rgb(0, 0, 0);\">លើសពីនេះ ជ្រើសខ្សែស្នែងដោយផ្អែកលើស្ថានភាពប្រើប្រាស់៖ ផលិតផលក្រៅផ្ទះផ្តល់អាទិភាពដល់ខ្សែស្នែងអត់ធ្មត់នឹងពន្លឺព្រះអាទិត្យ និងការសឹក សម្លៀកបំពាក់ជិតរាងកាយប្រើខ្សែស្នែងទន់ភ្លន់ និងមិនបណ្តាលឱ្យរលាកស្បែក។</span></p><p><span style=\"color: rgb(0, 0, 0);\">ការផ្សំខ្សែស្នែង និងក្រណាត់ដោយសមហេតុផលជួយចៀសវាងបញ្ហានៃការស្នែង និងពង្រីកអាយុជីវិតនៃផលិតផលបញ្ចប់។</span></p><p><span style=\"color: rgb(0, 0, 0);\">មិនថាជាការស្នែងដោយដៃ ឬផលិតកម្មឧស្សាហកម្មក៏ដោយ ការចងចាំច្បាប់ជ្រើសខ្សែស្នែងពិសេសសម្រាប់ក្រណាត់ប្រភេទផ្សេងៗនឹងជួយបង្កើតការងារស្នែងដ៏រឹងមាំ និងស្រស់ស្អាតបានយ៉ាងងាយស្រួល។</span></p>','ខ្សែស្នែងសម្រាប់ក្រណាត់ផ្សេងៗ, ការផ្សំក្រណាត់និងខ្សែស្នែង, ខ្សែស្នែងក្រណាត់កប្បាស, ខ្សែស្នែងក្រណាត់សូត្រ, ខ្សែស្នែងជិន, ច្បាប់ជ្រើសខ្សែស្នែង','អត្ថបទនេះពន្យល់គោលការណ៍ផ្សំខ្សែស្នែងជាមួយប្រភេទក្រណាត់ផ្សេងៗ ណែនាំខ្សែស្នែងដ៏សមស្របសម្រាប់កប្បាស សូត្រ ចៀម ជិន ស្បែក ជួយអ្នកចៀសវាងខ្សែស្នែងបែក និងក្រណាត់ខូច ហើយស្ទង់មតិបច្ចេកទេសជ្រើសខ្សែស្នែងជំនាញវិជ្ជាជីវៈ',2,'2026-04-09 10:18:58',2,'2026-04-09 10:18:58',0),
	(70,2,'th','วิธีเลือกด้ายเย็บที่เหมาะสมสำหรับผ้าประเภทต่างๆ','<p><span style=\"color: rgb(0, 0, 0);\">ด้ายเย็บดูเหมือนจะไม่สำคัญในกระบวนการเย็บผ้า แต่เป็นองค์ประกอบสำคัญที่กำหนดความทนทานและความสวยงามของผลิตภัณฑ์สำเร็จ การเลือกด้ายเย็บที่ไม่ถูกต้องไม่เพียงแต่ทำให้ด้ายขาดและการเย็บขาดรูข้ามบ่อยครั้งเท่านั้น แต่ยังทำให้ผ้าที่มีค่าเสียหาย ทำให้โครงงานทั้งหมดพังทลาย</span></p><p><span style=\"color: rgb(0, 0, 0);\">ผ้าประเภทต่างๆ มีความแตกต่างมากในด้านวัสดุ ความหนาและความยืดหยุ่น ดังนั้นด้ายเย็บที่เหมาะจึงแตกต่างกันไป การเชี่ยวชาญเทคนิคการจับคู่ที่มีประสิทธิภาพจะช่วยเพิ่มประสิทธิภาพการเย็บผ้าให้สูงสุด</span></p><p><span style=\"color: rgb(0, 0, 0);\">ผ้าฝ้ายเป็นวัสดุที่ใช้กันกว้างขวางที่สุดในชีวิตประจำวัน รวมถึงเสื้อยืดฝ้ายแท้ เฟอร์นิเจอร์นอน และเครื่องแต่งกายจากผ้าฝ้าย</span></p><p><span style=\"color: rgb(0, 0, 0);\">ประเภทผ้านี้มีการระบายอากาศที่ดีและเนื้อสัมผัสอ่อนโยน ทำให้</span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">ด้ายฝ้ายแท้</span><span style=\"color: rgb(0, 0, 0);\">เป็นตัวเลือกที่เหมาะอุดมคติ ด้ายชนิดนี้มีวัสดุและอัตราการยืดตัวคล้ายคลึงกับผ้าฝ้าย ป้องกันรอยยับจากการดึงดัน นอกจากนี้ยังทนความร้อน เหมาะสำหรับการรีดผ้า</span></p><p><span style=\"color: rgb(0, 0, 0);\">สำหรับผ้าแคนวาสหนาและยีนส์ฝ้าย ให้เลือกด้ายฝ้ายที่มีขนาดหนาเพื่อเพิ่มความแข็งแรงของรอยเย็บ ส่วนผ้าตาข่ายฝ้ายบางเบา ให้เลือกด้ายฝ้ายละเอียดเพื่อหลีกเลี่ยงรอยเย็บยื่นออกมาที่ส่งผลต่อความสวยงาม</span></p><p><span style=\"color: rgb(0, 0, 0);\">ผ้าบางเบาเช่นไหมชิฟฟอนและออร์แกนซา มีลักษณะละเอียดอ่อนและเปราะบาง ง่ายต่อการขาดเส้นด้าย</span></p><p><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">ด้ายไหมและด้ายโพลีเอสเตอร์ละเอียดพิเศษ</span><span style=\"color: rgb(0, 0, 0);\">เป็นตัวเลือกแรกสำหรับการเย็บผ้าประเภทนี้ ด้ายบางและลื่นไม่ทิ้งรูเข็มบนผ้า</span></p><p><span style=\"color: rgb(0, 0, 0);\">จับคู่กับเข็มเย็บละเอียดเพื่อลดความเสียหาย เหมาะอย่างยิ่งสำหรับการทำชุดราตรี ผ้าพันคอไหม และเครื่องแต่งกายโปร่งแสง เพื่อให้ได้ผลงานที่ประณีต</span></p><p><span style=\"color: rgb(0, 0, 0);\">ผ้าขนสัตว์และผ้าขนสัตว์หนามีลักษณะหนาและยืดหยุ่น พร้อมความกันความเย็นที่ยอดเยี่ยม ง่ายต่อการหดตัวระหว่างการเย็บ</span></p><p><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">ด้ายขนสัตว์และด้ายโพลีเอสเตอร์ยืดหสูง</span><span style=\"color: rgb(0, 0, 0);\">เป็นตัวเลือกที่เหมาะสม ด้ายประเภทนี้มีความยืดหยุ่นบางประการเพื่อเปลี่ยนรูปพร้อมกับผ้า ป้องกันรอยเย็บขาดหลังการซักผ้า</span></p><p><span style=\"color: rgb(0, 0, 0);\">ผ้าขนสัตว์หนาจับคู่กับด้ายยืดหหนา ส่วนผ้าขนสัตว์เนื้อละเอียดใช้ด้ายยืดหละเอียด เพื่อปรับสมดุลระหว่างความทนทานและความสบายในการสวมใส่</span></p><p><span style=\"color: rgb(0, 0, 0);\">ผ้าสังเคราะห์ ได้แก่ โพลีเอสเตอร์ ไนลอน และผ้าแห้งเร็วสำหรับเครื่องแต่งกายกีฬา มีลักษณะยืดหสูงและทนสึกหรอ</span></p><p><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">ด้ายเย็บโพลีเอสเตอร์</span><span style=\"color: rgb(0, 0, 0);\">เป็นตัวเลือกที่สมบูรณ์แบบ มีความแข็งแรงสูง ทนต่อการหดตัวและสีซีด ใช้กันอย่างแพร่หลายสำหรับเครื่องแต่งกายกีฬา กระเป๋าและผลิตภัณฑ์กลางแจ้ง</span></p><p><span style=\"color: rgb(0, 0, 0);\">สำหรับผ้าสังเคราะห์ที่ยืดหสูง สามารถใช้ด้ายสแปนเด็กซ์เพื่อตอบสนองความต้องการยืดตัวขนาดใหญ่</span></p><p><span style=\"color: rgb(0, 0, 0);\">ยีนส์ ผ้าแคนวาสและหนังเป็นผ้าหนาและแข็ง ที่มีข้อกำหนดสูงสำหรับความแข็งแรงของด้ายเย็บ</span></p><p><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">ด้ายโพลีเอสเตอร์แรงสูงและด้ายผสมฝ้าย-โพลีเอสเตอร์</span><span style=\"color: rgb(0, 0, 0);\">เป็นตัวเลือกแรกสำหรับยีนส์และผ้าแคนวาส ทนแรงเสียดทานและมีสมรรถนะรับน้ำหนักยอดเยี่ยม หลีกเลี่ยงการขาดในส่วนที่รับแรงของเครื่องแต่งกาย</span></p><p><span style=\"color: rgb(0, 0, 0);\">สำหรับผ้าหนัง ให้ใช้</span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">ด้ายไนลอนและด้ายขี้ผึ้งพิเศษสำหรับหนัง</span><span style=\"color: rgb(0, 0, 0);\"> ด้ายขี้ผึ้งมีการเคลือบผึ้ง ลื่นพอที่จะเจาะผ่านหนัง และยังทนน้ำและสึกหรอ มักใช้สำหรับกระเป๋าหนัง เสื้อหนังและรองเท้าหนัง</span></p><p><span style=\"color: rgb(0, 0, 0);\">ผ้าถักและผ้าสวมว่ายน้ำมีความยืดหสูงและสวมชิดตัว ด้ายปกติขาดง่ายเมื่อถูกยืดตัว</span></p><p><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">ด้ายไนลอนยืดหสูง</span><span style=\"color: rgb(0, 0, 0);\">เหมาะสำหรับผ้าทนน้ำเช่นชุดว่ายน้ำ มีความยืดหยุ่นยอดเยี่ยม ทนน้ำและการกร่อน ส่วนเครื่องแต่งกายถักประจำวันใช้ด้ายยืดหสแปนเด็กซ์ปรับตัวกับการยืดตัวของผ้า เพื่อให้แน่ใจว่ารอยเย็บไม่กระชับและไม่ขาดเมื่อสวมใส่</span></p><p><span style=\"color: rgb(0, 0, 0);\">ผ้าลินินมีการระบายอากาศที่ดี เนื้อแข็งและง่ายต่อการหดตัว</span></p><p><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">ด้ายพิเศษสำหรับลินินหรือด้ายฝ้ายแท้</span><span style=\"color: rgb(0, 0, 0);\">เป็นตัวเลือกที่ดีที่สุด เนื่องจากอัตราการหดตัวของพวกมันตรงกับผ้าลินิน หลีกเลี่ยงการหดตัวและการผิดรูปของรอยเย็บหลังทำความสะอาด เหมาะอย่างยิ่งสำหรับเสื้อเชิ้ตลินิน ม่านและผ้าคลุมโต๊ะ</span></p><p><span style=\"color: rgb(0, 0, 0);\">นอกเหนือจากการจับคู่ตามวัสดุผ้า ให้ใส่ใจกับความสอดคล้องระหว่างความหนาของด้ายเย็บและขนาดเข็ม</span></p><p><span style=\"color: rgb(0, 0, 0);\">ผ้าบางเบาจับคู่กับด้ายละเอียดและเข็มละเอียด ส่วนผ้าหนาใช้ด้ายหนาและเข็มหนา</span></p><p><span style=\"color: rgb(0, 0, 0);\">นอกจากนี้ ให้เลือกด้ายตามสถานการณ์การใช้งาน ผลิตภัณฑ์กลางแจ้งให้ความสำคัญกับด้ายทนแสงแดดและสึกหรอ เครื่องแต่งกายชิดตัวใช้ด้ายที่อ่อนโยนต่อผิวหนังและไม่ระคายเคือง</span></p><p><span style=\"color: rgb(0, 0, 0);\">การจับคู่ด้ายเย็บและผ้าอย่างเหมาะสมช่วยหลีกเลี่ยงความล้มเหลวในการเย็บและยืดอายุการใช้งานของผลิตภัณฑ์สำเร็จ</span></p><p><span style=\"color: rgb(0, 0, 0);\">ไม่ว่าจะเป็นการเย็บด้วยมือหรือการผลิตอุตสาหกรรม การจดจำกฎการเลือกด้ายเฉพาะสำหรับผ้าประเภทต่างๆ จะช่วยสร้างงานเย็บที่แข็งแรงและสวยงามได้อย่างง่ายดาย</span></p>','ด้ายเย็บสำหรับผ้าต่างๆ,การจับคู่ผ้าและด้ายเย็บ,ด้ายเย็บผ้าฝ้าย,ด้ายเย็บผ้าไหม,ด้ายเย็บยีนส์,คู่มือการเลือกด้ายเย็บ','บทความนี้อธิบายหลักการจับคู่ด้ายเย็บกับผ้าประเภทต่างๆ แนะนำด้ายที่เหมาะสำหรับฝ้าย ไหม ขนสัตว์ ยีนส์ หนัง ช่วยคุณหลีกเลี่ยงด้ายขาดและผ้าเสียหาย เชี่ยวชาญเทคนิคการเลือกด้ายเย็บอย่างมืออาชีพ',2,'2026-04-09 10:18:58',2,'2026-04-09 10:18:58',0),
	(71,2,'vi','Làm thế nào để chọn chỉ may phù hợp với các loại vải khác nhau?','<p><span style=\"color: rgb(0, 0, 0);\">Chỉ may có vẻ không quan trọng trong quá trình may mặc, nhưng nó là yếu tố cốt lõi quyết định độ bền và thẩm mỹ của sản phẩm hoàn chỉnh. Chọn sai chỉ may không chỉ gây hiện tượng đứt chỉ, bỏ mũi kim thường xuyên mà còn làm hỏng các loại vải quý giá, làm hỏng toàn bộ sản phẩm. Các loại vải khác nhau có sự khác biệt lớn về vật liệu, độ dày và độ co giãn, do đó chỉ may tương ứng cũng khác nhau. Nắm vững kỹ thuật phối hợp khoa học sẽ giúp tối ưu hiệu quả may mặc.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Vải bông là vật liệu được sử dụng rộng rãi nhất trong cuộc sống hàng ngày, bao gồm áo thun cotton 100%, đồ gia dụng và quần áo vải bông. Loại vải này có độ thoáng khí tốt và kết cấu mềm mại, làm cho </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">chỉ bông nguyên chất</span><span style=\"color: rgb(0, 0, 0);\"> trở thành sự phối hợp lý tưởng. Loại chỉ này có vật liệu và tỷ lệ co giãn tương tự như vải bông, ngăn ngừa nếp nhăn do kéo căng. Nó cũng chịu nhiệt, phù hợp cho việc ủi. Đối với vải bạt jean dày dặn, hãy chọn chỉ bông có số dày để tăng độ bền đường may; đối với vải gaze bông mỏng, hãy chọn chỉ bông mịn để tránh đường may nổi lên ảnh hưởng đến vẻ ngoài.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Các loại vải mỏng như lụa, chiffon và organza mịn màng và dễ bị hư hỏng, kéo sợi. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Chỉ lụa và chỉ polyester siêu mịn</span><span style=\"color: rgb(0, 0, 0);\"> được ưu tiên sử dụng để may các loại vải này. Chỉ mảnh và mượt mà không để lại lỗ kim trên vải. Kết hợp với kim may mịn để giảm thiểu tổn thương, hoàn hảo cho việc làm váy dạ hội, khăn quàng lụa và quần áo trong suốt, đảm bảo hoàn thiện tinh xảo.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Vải len và vải nỉ dày dặn, có độ co giãn và khả năng giữ nhiệt tuyệt vời, dễ bị co rút trong quá trình may. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Chỉ len và chỉ polyester cao co giãn</span><span style=\"color: rgb(0, 0, 0);\"> là lựa chọn phù hợp. Các loại chỉ này có độ co giãn nhất định để biến dạng đồng bộ với vải, ngăn ngừa đường may nứt sau khi giặt. Vải len dày phối hợp với chỉ co giãn dày, còn vải len cao cấp sử dụng chỉ co giãn mịn, cân bằng giữa độ bền và sự thoải mái khi mặc.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Vải tổng hợp bao gồm polyester, nylon và vải nhanh khô cho đồ thể thao, có đặc tính co giãn cao và chống mài mòn. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Chỉ may polyester</span><span style=\"color: rgb(0, 0, 0);\"> là sự phối hợp hoàn hảo. Nó có độ bền cao, chống co rút và phai màu, được sử dụng rộng rãi cho đồ thể thao, túi xách và sản phẩm ngoài trời. Đối với vải tổng hợp có độ co giãn cao, có thể sử dụng chỉ spandex để đáp ứng nhu cầu kéo căng lớn.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Jean, vải bạt và da là các loại vải dày dặn, cứng, yêu cầu cao về độ bền của chỉ may. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Chỉ polyester cao cường độ và chỉ pha bông-polyester</span><span style=\"color: rgb(0, 0, 0);\"> là lựa chọn hàng đầu cho jean và vải bạt, có khả năng chống ma sát và chịu lực xuất sắc, tránh đứt ở các bộ phận chịu lực của quần áo. Đối với vải da, hãy sử dụng </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">chỉ nylon và chỉ sáp chuyên dụng cho da</span><span style=\"color: rgb(0, 0, 0);\">. Chỉ sáp được tráng sáp, mượt mà dễ xuyên qua da, đồng thời chống nước và mài mòn, thường được dùng cho túi da, áo da và giày da.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Vải len đan và vải đồ bơi có độ co giãn cao và ôm sát cơ thể, chỉ thông thường dễ đứt khi kéo căng. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Chỉ nylon cao co giãn</span><span style=\"color: rgb(0, 0, 0);\"> phù hợp với vải chống nước như đồ bơi, có độ co giãn tuyệt vời, chống nước và ăn mòn; đối với len đan hàng ngày, chỉ co giãn spandex thích ứng với sự co giãn của vải, đảm bảo đường may không bị chật chội và không nứt khi mặc.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Vải lanh có độ thoáng khí tốt, kết cấu cứng và dễ co rút. </span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">Chỉ chuyên dụng cho lanh hoặc chỉ bông nguyên chất</span><span style=\"color: rgb(0, 0, 0);\"> là sự phối hợp tốt nhất, vì tỷ lệ co rút của chúng phù hợp với vải lanh, tránh tình trạng co rút và biến dạng đường may sau khi giặt, lý tưởng cho áo sơ mi lanh, rèm cửa và khăn bàn.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Ngoài việc phối hợp theo vật liệu vải, hãy chú ý đến sự tương thích giữa độ dày chỉ may và kích thước kim: vải mỏng phối hợp với chỉ mịn và kim mịn, còn vải dày sử dụng chỉ dày và kim dày. Đồng thời, chọn chỉ dựa trên tình huống sử dụng: sản phẩm ngoài trời ưu tiên chỉ chống nắng và mài mòn, quần áo ôm thân sử dụng chỉ mềm mại, không gây kích ứng da.</span></p><p><span style=\"color: rgb(0, 0, 0);\">Việc phối hợp hợp lý giữa chỉ may và vải giúp tránh lỗi may và kéo dài tuổi thọ sản phẩm hoàn chỉnh. Dù là may tay hay sản xuất công nghiệp, nhớ quy tắc chọn chỉ riêng cho các loại vải khác nhau sẽ giúp bạn dễ dàng tạo ra các tác phẩm may chắc chắn và đẹp mắt.</span></p>','chỉ may cho các loại vải, phối hợp vải và chỉ may, chỉ may vải bông, chỉ may vải lụa, chỉ may jean, hướng dẫn chọn chỉ may','Bài viết giải thích nguyên tắc phối hợp chỉ may với các loại vải khác nhau, đề xuất chỉ phù hợp cho bông, lụa, len, jean, da..., giúp bạn tránh đứt chỉ và hư hỏng vải, nắm vững kỹ năng chọn chỉ may chuyên nghiệp.',2,'2026-04-09 10:18:58',2,'2026-04-09 10:18:58',0),
	(72,2,'zh','如何为不同面料选择合适的缝纫线？','<p><span style=\"color: rgb(0, 0, 0);\">在缝纫制作过程中，缝纫线看似不起眼，却是决定成品牢固度、美观度的核心要素。选错缝纫线，不仅容易出现断线、跳线问题，还会损伤珍贵面料，导致整件作品报废。不同面料的材质、厚度、弹性天差地别，搭配的缝纫线也各有讲究，掌握科学的搭配技巧，才能让缝纫效果事半功倍。</span></p><p><span style=\"color: rgb(0, 0, 0);\">棉面料是日常生活中应用最广泛的面料，涵盖纯棉 T 恤、床品、棉布衣物等。这类面料透气性佳、质地柔软，适配</span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">纯棉缝纫线</span><span style=\"color: rgb(0, 0, 0);\">，该款线与棉面料材质相近，伸缩率一致，缝制后不会因拉扯出现面料褶皱，同时耐高温，适配熨烫工序。对于厚重的帆布、牛仔棉，可选择粗支数的棉线，提升缝合强度；轻薄棉纱布则搭配细支棉线，避免线迹凸起影响美观。</span></p><p><span style=\"color: rgb(0, 0, 0);\">丝绸、雪纺、欧根纱等轻薄面料，质地细腻脆弱，极易被勾丝破损。缝制这类面料优先选用</span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">真丝线、超细涤纶丝</span><span style=\"color: rgb(0, 0, 0);\">，线体纤细顺滑，不会在面料上留下针孔痕迹。同时要搭配细号缝纫针，降低对面料的损伤，多用于礼服、丝巾、轻纱服饰的制作，保障成品精致细腻。</span></p><p><span style=\"color: rgb(0, 0, 0);\">羊毛、毛呢面料厚实且带有弹性，保暖性突出，缝合时容易出现缩绒、回弹现象。适合选择</span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">羊毛线、高弹涤纶线</span><span style=\"color: rgb(0, 0, 0);\">，这类线具备一定伸缩性，能跟随面料同步形变，防止洗涤后线迹崩裂。粗纺毛呢可搭配粗弹线，精纺羊毛面料选择细腻弹线，兼顾牢固度与穿着舒适度。</span></p><p><span style=\"color: rgb(0, 0, 0);\">化纤面料包含涤纶、锦纶、运动速干面料，这类面料弹性强、耐磨度高，适配</span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">涤纶缝纫线</span><span style=\"color: rgb(0, 0, 0);\">。涤纶线强度高、不易缩水褪色，适配化纤面料的特性，广泛用于运动服饰、箱包、户外用品的缝制。高弹性化纤面料，可搭配氨纶包芯线，满足大幅度拉伸需求。</span></p><p><span style=\"color: rgb(0, 0, 0);\">牛仔布、帆布、皮革属于厚重硬质面料，对缝纫线的强度要求极高。牛仔与帆布首选</span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">涤纶高强线、棉涤混纺线</span><span style=\"color: rgb(0, 0, 0);\">，耐摩擦、承重能力优异，应对衣物受力部位缝合不易断裂。皮革面料则专用</span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">尼龙线、皮革专用蜡线</span><span style=\"color: rgb(0, 0, 0);\">，蜡线经过上蜡处理，顺滑易穿透皮革，还能防水耐磨，常用于皮包、皮衣、皮靴制作。</span></p><p><span style=\"color: rgb(0, 0, 0);\">针织面料、泳衣面料高弹贴身，常规线体易因拉伸崩断。泳衣等防水面料搭配</span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">锦纶高弹线</span><span style=\"color: rgb(0, 0, 0);\">，弹性优异且防水耐腐蚀；日常针织衫可选择氨纶弹力线，跟随面料伸缩，保证穿着时线迹不紧绷、不开裂。</span></p><p><span style=\"color: rgb(0, 0, 0);\">亚麻面料透气性好、质地挺括，易缩水，搭配</span><span style=\"color: rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0); font-size: 16px;\">亚麻专用线或纯棉线</span><span style=\"color: rgb(0, 0, 0);\">最为合适，两者缩水率与亚麻面料匹配，清洗后不会出现线迹收缩扭曲的情况，适合亚麻衬衫、窗帘、桌布等制品。</span></p><p><span style=\"color: rgb(0, 0, 0);\">除了按面料材质选择，还需关注缝纫线粗细与针号的匹配，轻薄面料配细线细针，厚重面料配粗线粗针；同时根据使用场景选择，户外用品优先选耐晒耐磨的线，贴身衣物选择亲肤无刺激的线。</span></p><p><span style=\"color: rgb(0, 0, 0);\">合理搭配缝纫线与面料，既能规避缝纫故障，又能延长成品使用寿命。无论是手工缝纫还是工业制作，牢记不同面料的专属线体选择法则，就能轻松打造出牢固又美观的缝纫作品。</span></p>','面料选择缝纫线，不同面料缝纫线搭配，纯棉面料缝纫线，丝绸面料缝纫线，牛仔布缝纫线，缝纫线选购方法','详解各类面料缝纫线搭配准则，棉、丝绸、毛呢、牛仔、皮革等不同面料适配缝纫线推荐，教你避开断线、损伤面料问题，掌握专业缝纫线选择技巧。',2,'2026-04-09 10:18:58',2,'2026-04-09 10:18:58',0);

/*!40000 ALTER TABLE `article_lang` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 company
# ------------------------------------------------------------

DROP TABLE IF EXISTS `company`;

CREATE TABLE `company` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '固定ID=1',
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '公司LOGO',
  `cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '封面图',
  `sort` int DEFAULT '100' COMMENT '排序',
  `status` tinyint DEFAULT '1' COMMENT '1=显示',
  `create_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建人',
  `update_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公司介绍主表';

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;

INSERT INTO `company` (`id`, `logo`, `cover`, `sort`, `status`, `create_by`, `update_by`, `create_time`, `update_time`, `is_deleted`)
VALUES
	(1,'','',100,1,'system','2','2026-04-02 12:14:27','2026-04-11 15:59:35',0);

/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 company_lang
# ------------------------------------------------------------

DROP TABLE IF EXISTS `company_lang`;

CREATE TABLE `company_lang` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int NOT NULL COMMENT '关联company.id=1',
  `lang` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '语言 en/ar/th/ms/id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '标题（如 About Us）',
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT '公司介绍内容',
  `seo_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'SEO标题',
  `seo_keywords` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'SEO关键词',
  `seo_description` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'SEO描述',
  `create_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建人',
  `update_by` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '创建人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_deleted` tinyint DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `company_lang_unique` (`company_id`,`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公司介绍多语言';

LOCK TABLES `company_lang` WRITE;
/*!40000 ALTER TABLE `company_lang` DISABLE KEYS */;

INSERT INTO `company_lang` (`id`, `company_id`, `lang`, `title`, `content`, `seo_title`, `seo_keywords`, `seo_description`, `create_by`, `update_by`, `create_time`, `update_time`, `is_deleted`)
VALUES
	(8,1,'ar','ملف الشركة','<p>تُنشئ شركة هوبي زياو للخيوط المحدودة في 6 سبتمبر 2009. كشركة شاملة، تدمج بين الإنتاج والتشغيل والمبيعات والتصدير لجميع أنواع الخيوط البوليسيسترية وخيوط التفصيل، مع التركيز على تقديم منتجات خيوط التفصيل الصناعية عالية الجودة والحلول ذات الصلة لعملاء العالم. مع تجربة تزيد عن عقد من الزمن في صناعة الخيوط البوليسيسترية، أصبحت الشركة مصنعاً رائداً لخيوط التفصيل البوليسيسترية في مقاطعة هوبي.</p><p>تقع الشركة في حديقة الصناعات الجنوبية بمدينة هانشوان، وتتمتع بموقع جغرافي ممتاز وسيلة مواصلات سريعة. Она مجاورة لمنطقة هانشوان الحضرية من الشرق، وتحدي نهر هان من الجنوب، وتقترب من طريق هيسا المحلي من الشمال. وبمسافة لا تزيد عن 50 كيلومتراً من ووهان، المدينة المركزية في الصين الوسطى التي تُعرف باسم \"طريق تسعة مقاطعات\"، تستفيد الشركة من شبكة مواصلات برية ومائية متطورة، والتي توفر دعمًا فعالاً لشراء المواد الخام، نقل المنتجات والتصدير الخارجي. بالاستفادة من ميزات تجميع الصناعات النسيجية في هانشوان، تعزز الشركة الميزة التنافسية لمنتجاتها في السوق. تغطي الشركة مساحة إجمالية تبلغ 31302 متر مربع، وتتمتع بمنطقة إنتاج حديثة بساحة 25000 متر مربع وبمقياس إنتاجي يبلغ 60000 حصاة، مما يسمح لها بتلبية احتياجات الشراء بالكميات الكبيرة لعملاء العالم بفضل قدرتها الإنتاجية القوية.</p><p>لضمان جودة المنتج وكفاءة الإنتاج، توفر الشركة معدات إنتاج محلية متطورة، بما في ذلك أكثر من 360 مجموعة من الآلات مثل آلات فتحة القطن جينتان، آلات الدوران الحاسوبية ذات الثلاث محاور FA494 ومُرابطات الهواء. تغطي هذه المعدات كامل عملية الإنتاج، من الغزل والالتواء إلى التلوين واللف، مما يتحقق ضبط معياري وكفاءة لجميع مراحل الإنتاج. مع نظام إنتاج كامل، تبلغ إنتاج الشركة السنوي 8000 طن من جميع أنواع الخيوط والخيوط. منتجاتها الرئيسية هي سلسلة خيوط التفصيل البوليسيسترية العالية السرعة (T20S/2، T20S/3، T30S/2، T40S/2، T40S/3، T50S/2، T60S/2، T60S/3، إلخ)، والتي تفي بالمعايير العالية لتفصيل الصناعة. تُستخدم على نطاق واسع في جميع مجالات التفصيل الصناعي مثل الملابس والأحذية والأحمال والأثاث، وتتميز هذه المنتجات بالقوة العالية، والتحمل للمسحوق، والمتانة، والانكماش المنخفض، مما يفي باحتياجات أساسية الإنتاج الصناعي بشكل مثالي.</p><p>تُعطي الشركة أهمية كبيرة للإدارة الإنتاجية وضبط جودة المنتج. فعلاً منذ عام 2010، حصلت جميع خطوط منتجاتها على شهادة نظام الجودة ISO9001. مع الالتزام الدائم بمعايير ضبط الجودة، تنفذ الشركة فحص جودة كامل العمليية من اختيار المواد الخام إلى تسليم المنتج النهائي، مما يضمن أن منتجاتها تمتلك قوة عالية، وقيود خيوط قليلة، ومرونة وسطاء، وألوان زاهية، ومقاومة لون جيدة، وعدم وجود اختلاف في اللون. بفضل جودتها العالية، أصبحت منتجات الشركة محببة لدى عملاء العالم، وتُصدر إلى أكثر من 50 دولة ومنطقة في أمريكا الشمالية، وأوروبا، آسيا، إفريقيا، وأوقيانوسيا، بما في ذلك الولايات المتحدة الأمريكية، ماليزيا، الفلبين، بالإضافة إلى تغطية منطقة تايوان الصينية. بعد توفير خدمات منتج ثابتة وموثوقة لأكثر من 2000 عميل في جميع أنحاء العالم، أسست الشركة سمعة ماركة قوية في صناعة الخيوط البوليسيسترية وخيوط التفصيل، وأصبحت المورد المفضل للتعاون لعدة شركات.</p><p>في المستقبل، سينتج زياو للخيوط عن استعزاز حضوره في صناعة الخيوط البوليسيسترية وخيوط التفصيل، وسيقوم باستمرار بتحسين العمليات الإنتاجية وتحديث معدات الإنتاج. مع الالتزام بالجودة، وتوسيع السوق العالمي، وتركيز على قطاع خيوط التفصيل الصناعية، تسعى الشركة لتصبح موفراً رائداً في العالم لخيوط الخيوط </p>',' مصنع خيوط التفصيل البوليسيسترية في هوبي_زياو للخيوط_شركة شاملة للإنتاج والتشغيل','','','2','2','2026-04-11 15:59:35','2026-04-11 15:59:35',0),
	(9,1,'en','Company Profile','<p>Hubei Zhi\'ao Thread Co., Ltd. was established on September 6, 2009. As a comprehensive enterprise, it integrates the production, processing, sales and export of various polyester yarns and sewing threads, focusing on delivering high-quality industrial sewing thread products and related solutions to global customers. With over a decade of experience in the polyester yarn industry, it has grown into a leading polyester sewing thread manufacturer in Hubei Province.</p><p>Located in Chengnan Industrial Park, Hanchuan City, the company enjoys a superior geographical location and convenient transportation. It is adjacent to Hanchuan Urban Area in the east, borders the Han River in the south, and is close to Heisha Provincial Highway in the north. Only 50 kilometers away from Wuhan, the core city in central China known as the \"thoroughfare of nine provinces\", it benefits from a well-developed land and water transportation network, which provides efficient support for raw material procurement, product transportation and overseas export. Leveraging the advantages of Hanchuan\'s textile industrial cluster, the company further enhances the market competitiveness of its products. Covering a total area of 31,302 square meters, it boasts a 25,000-square-meter modern production base with a production scale of 60,000 spindles, enabling it to fully meet the bulk purchase needs of global customers with its strong production capacity.</p><p>To guarantee product quality and production efficiency, the company is equipped with advanced domestic production equipment, including more than 360 sets of machinery such as Jintan Cotton Opening Machines, FA494 Three-Axis Linkage Computerized Roving Frames and Air Knotters. These equipment cover the entire production process, from spinning and twisting to dyeing and winding, achieving standardized and efficient control over all production links. With a complete production system, the company has an annual output of 8,000 tons of various yarns and threads. Its core products are the high-speed pure polyester sewing thread series (T20S/2, T20S/3, T30S/2, T40S/2, T40S/3, T50S/2, T60S/2, T60S/3, etc.), which meet high industrial sewing standards. Widely used in various industrial sewing fields such as clothing, footwear, luggage and furniture, these products feature high strength, wear resistance, durability and low shrinkage, perfectly meeting the core needs of industrial production.</p><p>The company places great emphasis on production management and product quality control. As early as 2010, all its product lines have obtained ISO9001 quality system certification. Adhering strictly to quality control standards, it implements full-process quality inspection from raw material selection to finished product delivery, ensuring that its products possess high strength, few yarn defects, flexibility, smoothness, bright colors, good color fastness and no color difference. Thanks to its excellent quality, the company\'s products are highly recognized by global customers and exported to more than 50 countries and regions across North America, Europe, Asia, Africa and Oceania, including the United States, Malaysia and the Philippines, as well as covering China\'s Taiwan region. Having provided stable and reliable product services for over 2,000 customers worldwide, it has established a solid brand reputation in the polyester yarn and sewing thread industry and become the preferred cooperative supplier for many enterprises.</p><p>In the future, Zhi\'ao Thread will continue to deepen its presence in the polyester yarn and sewing thread industry, continuously optimize production processes and upgrade production equipment. Upholding its commitment to quality, expanding the global market and focusing on the industrial sewing thread segment, the company strives to become a world-leading supplier of yarns and sewing threads, creating greater value for customers and contributing to the high-quality development of the textile industry.</p>','Hubei Polyester Sewing Thread Manufacturer_Zhi\'ao Thread_Integrated Enterprise of Polyester Yarn Production, Processing and Export','Hubei polyester yarn, polyester sewing thread manufacturer, industrial sewing thread, high-speed pure polyester sewing thread, polyester yarn production and processing, sewing thread export, Zhi\'ao Thread','Hubei Zhi\'ao Thread Co., Ltd. is a professional manufacturer specializing in polyester yarns and polyester sewing threads, integrating production, processing, sales and export. With an annual output of 8,000 tons, it mainly supplies high-speed pure polyester sewing threads, holds ISO9001 certification, exports to more than 50 countries, and offers industrial sewing thread solutions for over 2,000 global customers.','2','2','2026-04-11 15:59:35','2026-04-11 15:59:35',0),
	(10,1,'zh','公司简介','<p>湖北智奥线业有限公司成立于2009年9月6日，是一家集各类涤纶纱线、缝纫线的生产、加工、销售及出口于一体的综合性企业，专注于为全球客户提供高品质工业用缝纫线产品及相关解决方案，深耕涤纶纱线领域十余年，是湖北地区颇具实力的涤纶缝纫线生产厂家。</p><p>公司地处汉川市城南工业园，地理位置优越、交通便捷——东邻汉川城关，南濒汉江，北靠省道荷沙线，距九省通衢的中部核心城市武汉仅50公里，水陆交通网络发达，为原材料采购、产品运输及海外出口提供了高效保障，依托汉川纺织产业集群优势，进一步提升了产品的市场竞争力。公司总占地面积达31302平方米，建有25000平方米现代化生产基地，生产规模达6万锭，具备强大的产能优势，可充分满足全球客户的批量采购需求。</p><p>为确保产品品质与生产效率，公司配备了国内先进的生产设备，包括金坛清花机、FA494三轴联动电脑粗纱机、气打结等各类设备360多台套，涵盖纺纱、加捻、染色、卷绕等全生产流程，实现了生产全环节的规范化、高效化管控。凭借完善的生产体系，公司年生产各类纱、线可达8000吨，其中高速纯涤纶缝纫线系列产品（T20S/2、T20S/3、T30S/2、T40S/2、T40S/3、T50S/2、T60S/2、T60S/3等）为主力产品，产品符合工业缝制高标准要求，广泛应用于各类工业缝制领域，涵盖服装、鞋类、箱包、家具等多个细分场景，兼具强度高、耐磨耐用、缩水率低等优势，契合工业生产的核心需求。</p><p>公司高度重视生产管理与产品质量管控，早在2010年，所属全系列产品便通过了ISO9001质量体系认证，严格遵循质量管控标准，从原材料甄选到成品出厂，实行全流程质检，确保产品强度高、纱疵少、柔韧滑爽、色泽艳丽、色牢度好、无色差。凭借优异品质，产品深受全球客户青睐，远销北美、欧洲、亚洲、非洲、大洋洲等50多个国家和地区，其中包括美国、马来西亚、菲律宾等，同时覆盖中国台湾地区，累计为全球超过2000家客户提供稳定、可靠的产品服务，在涤纶纱线、缝纫线行业内树立了良好的品牌口碑，成为众多企业的优选合作供应商。</p><p>未来，智奥线业将持续深耕涤纶纱线、缝纫线领域，不断优化生产工艺、升级生产设备，坚守品质初心，拓展全球市场，深耕工业用缝纫线细分领域，致力于成为全球领先的纱线、缝纫线供应商，为客户创造更高价值，助力纺织行业高质量发展。</p>','湖北涤纶缝纫线厂家_智奥线业_涤纶纱线生产加工出口一体化企业','湖北涤纶纱线，涤纶缝纫线厂家，工业用缝纫线，高速纯涤纶缝纫线，涤纶纱线生产加工，缝纫线出口，智奥线业','湖北智奥线业有限公司是专业涤纶纱线、涤纶缝纫线生产厂家，集生产、加工、销售、出口于一体，年产8000吨，主营高速纯涤纶缝纫线，通过ISO9001认证，远销50多个国家，为全球2000+客户提供工业用缝纫线解决方案。','2','2','2026-04-11 15:59:35','2026-04-11 15:59:35',0),
	(11,1,'vi','Giới thiệu Công ty','<p>Công ty TNHH Chợt Đường Hubei Zhi\'ao được thành lập vào ngày 6 tháng 9 năm 2009. Là một doanh nghiệp tổng hợp, công ty kết hợp sản xuất, gia công, bán hàng và xuất khẩu các loại sợi polyester và sợi may, tập trung vào việc cung cấp sản phẩm sợi may công nghiệp chất lượng cao và các giải pháp liên quan cho khách hàng trên toàn cầu. Với hơn một thập kỷ kinh nghiệm trong lĩnh vực sợi polyester, công ty đã phát triển thành một nhà sản xuất sợi may polyester hàng đầu tại tỉnh Hubei.</p><p>Công ty đặt trụ sở tại Khu Công nghiệp Nam Thành, Thành phố Hanchuan, sở hữu vị trí địa lý thuận lợi và giao thông thuận tiện. Công ty liền kề khu vực đô thị Hanchuan ở phía đông, giáp sông Hàn ở phía nam, và gần Đường Provincial Heisha ở phía bắc. Chỉ cách Wuhan – trung tâm của Trung Quốc miền Trung được gọi là \"đường nối chín tỉnh\" – 50 km, công ty tận dụng mạng lưới giao thông đường bộ và thủy lộ phát triển, cung cấp sự hỗ trợ hiệu quả cho việc mua nguyên liệu, vận chuyển sản phẩm và xuất khẩu quốc tế. Tận dụng lợi thế cụm công nghiệp dệt may tại Hanchuan, công ty càng tăng cường lợi thế cạnh tranh của sản phẩm trên thị trường. Công ty có tổng diện tích 31.302 mét vuông, sở hữu khu sản xuất hiện đại rộng 25.000 mét vuông với quy mô sản xuất 60.000 trục, đảm bảo đáp ứng nhu cầu mua hàng số lượng lớn của khách hàng toàn cầu nhờ khả năng sản xuất mạnh mẽ.</p><p>Để đảm bảo chất lượng sản phẩm và hiệu quả sản xuất, công ty trang bị thiết bị sản xuất tiên tiến trong nước, bao gồm hơn 360 bộ máy như Máy mở bông Jintan, Máy xoắn sợi máy tính ba trục FA494 và Máy nối nút khí. Các thiết bị này bao phủ toàn bộ quy trình sản xuất, từ dệt sợi, xoắn sợi đến nhuộm và cuộn sợi, đạt được kiểm soát tiêu chuẩn hóa và hiệu quả cho tất cả các khâu sản xuất. Với hệ thống sản xuất hoàn chỉnh, công ty có sản lượng hàng năm 8.000 tấn các loại sợi và dây. Sản phẩm chủ lực của công ty là dòng sợi may polyester tinh khiết tốc độ cao (T20S/2, T20S/3, T30S/2, T40S/2, T40S/3, T50S/2, T60S/2, T60S/3, v.v.), đáp ứng tiêu chuẩn cao cho may công nghiệp. Được sử dụng rộng rãi trong các lĩnh vực may công nghiệp như quần áo, giày dép, vali túi, nội thất, các sản phẩm này có ưu điểm độ bền cao, chống mài mòn, bền bỉ và tỷ lệ co giãn thấp, hoàn toàn đáp ứng nhu cầu cốt lõi của sản xuất công nghiệp.</p><p>Công ty rất coi trọng quản lý sản xuất và kiểm soát chất lượng sản phẩm. Đã từ năm 2010, toàn bộ dòng sản phẩm của công ty đã đạt chứng chỉ hệ thống quản lý chất lượng ISO9001. Tuân thủ nghiêm ngặt tiêu chuẩn kiểm soát chất lượng, công ty thực hiện kiểm tra chất lượng toàn quy trình từ việc lựa chọn nguyên liệu đến giao hàng sản phẩm hoàn thành, đảm bảo sản phẩm có độ bền cao, ít khiếm khuyết sợi, mềm mại, liền mạch, màu sắc tươi sáng, độ bền màu tốt và không có sự khác biệt màu sắc. Nhờ chất lượng tuyệt vời, sản phẩm của công ty được khách hàng toàn cầu ưa chuộng, được xuất khẩu đến hơn 50 quốc gia và vùng lãnh thổ trên Bắc Mỹ, Châu Âu, Châu Á, Châu Phi và Đại Dương, bao gồm Hoa Kỳ, Malaysia, Philippines, cũng như bao phủ khu vực Đài Loan Trung Quốc. Sau khi cung cấp dịch vụ sản phẩm ổn định và đáng tin cậy cho hơn 2.000 khách hàng trên toàn thế giới, công ty đã xây dựng uy tín thương hiệu mạnh mẽ trong lĩnh vực sợi polyester và sợi may, trở thành nhà cung cấp hợp tác ưu tiên của nhiều doanh nghiệp.</p><p>Trong tương lai, Zhi\'ao Thread sẽ tiếp tục mở rộng phạm vi hoạt động trong lĩnh vực sợi polyester và sợi may, không ngừng cải thiện quy trình sản xuất và nâng cấp thiết bị sản xuất. Giữ vững cam kết về chất lượng, mở rộng thị trường toàn cầu và tập trung vào phân khúc sợi may công nghiệp, công ty nỗ lực trở thành nhà cung cấp hàng đầu thế giới về sợi và sợi may, tạo ra giá trị lớn hơn cho khách hàng và đóng góp vào sự phát triển chất lượng cao của ngành công nghiệp dệt may.</p>','Nhà sản xuất sợi may polyester Hubei_Zhi\'ao Thread_Doanh nghiệp tổng hợp sản xuất, gia công và xuất khẩu sợi polyester','sợi polyester Hubei, nhà sản xuất sợi may polyester, sợi may công nghiệp, sợi may polyester tinh khiết tốc độ cao, sản xuất và gia công sợi polyester, xuất khẩu sợi may, Zhi\'ao Thread','Công ty TNHH Chợt Đường Hubei Zhi\'ao là một nhà sản xuất chuyên nghiệp về sợi polyester và sợi may, kết hợp sản xuất, gia công, bán hàng và xuất khẩu. Với sản lượng hàng năm 8.000 tấn, công ty chủ yếu cung cấp sợi may polyester tinh khiết tốc độ cao, có chứng chỉ ISO9001, xuất khẩu đến hơn 50 quốc gia và cung cấp giải pháp sợi may công nghiệp cho hơn 2.000 khách hàng toàn cầu.','2','2','2026-04-11 15:59:35','2026-04-11 15:59:35',0);

/*!40000 ALTER TABLE `company_lang` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 gen_table
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gen_table`;

CREATE TABLE `gen_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) NOT NULL COMMENT '表名',
  `module_name` varchar(100) DEFAULT NULL COMMENT '模块名',
  `package_name` varchar(255) NOT NULL COMMENT '包名',
  `business_name` varchar(100) NOT NULL COMMENT '业务名',
  `entity_name` varchar(100) NOT NULL COMMENT '实体类名',
  `author` varchar(50) NOT NULL COMMENT '作者',
  `parent_menu_id` bigint DEFAULT NULL COMMENT '上级菜单ID，对应sys_menu的id ',
  `remove_table_prefix` varchar(20) DEFAULT NULL COMMENT '要移除的表前缀，如: sys_',
  `page_type` varchar(20) DEFAULT NULL COMMENT '页面类型(classic|curd)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_tablename` (`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成配置表';



# 转储表 gen_table_column
# ------------------------------------------------------------

DROP TABLE IF EXISTS `gen_table_column`;

CREATE TABLE `gen_table_column` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `table_id` bigint NOT NULL COMMENT '关联的表配置ID',
  `column_name` varchar(100) DEFAULT NULL,
  `column_type` varchar(50) DEFAULT NULL,
  `column_length` int DEFAULT NULL,
  `field_name` varchar(100) NOT NULL COMMENT '字段名称',
  `field_type` varchar(100) DEFAULT NULL COMMENT '字段类型',
  `field_sort` int DEFAULT NULL COMMENT '字段排序',
  `field_comment` varchar(255) DEFAULT NULL COMMENT '字段描述',
  `max_length` int DEFAULT NULL,
  `is_required` tinyint(1) DEFAULT NULL COMMENT '是否必填',
  `is_show_in_list` tinyint(1) DEFAULT '0' COMMENT '是否在列表显示',
  `is_show_in_form` tinyint(1) DEFAULT '0' COMMENT '是否在表单显示',
  `is_show_in_query` tinyint(1) DEFAULT '0' COMMENT '是否在查询条件显示',
  `query_type` tinyint DEFAULT NULL COMMENT '查询方式',
  `form_type` tinyint DEFAULT NULL COMMENT '表单类型',
  `dict_type` varchar(50) DEFAULT NULL COMMENT '字典类型',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_table_id` (`table_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='代码生成字段配置表';



# 转储表 inquiry
# ------------------------------------------------------------

DROP TABLE IF EXISTS `inquiry`;

CREATE TABLE `inquiry` (
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
  `attachment_url` varchar(1024) DEFAULT NULL COMMENT '附件URL',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态（0-未处理 1-已处理）',
  `locale` varchar(10) DEFAULT NULL COMMENT '提交语言',
  `model` varchar(50) DEFAULT NULL COMMENT '型号',
  `quantity` varchar(100) DEFAULT NULL COMMENT '数量',
  `color` varchar(50) DEFAULT NULL COMMENT '颜色',
  `length` varchar(50) DEFAULT NULL COMMENT '长度',
  `tenacity` varchar(50) DEFAULT NULL COMMENT '强度',
  `product_id` bigint DEFAULT NULL COMMENT '关联产品ID',
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

LOCK TABLES `inquiry` WRITE;
/*!40000 ALTER TABLE `inquiry` DISABLE KEYS */;

INSERT INTO `inquiry` (`id`, `name`, `email`, `company`, `phone`, `country`, `interest`, `subject`, `message`, `attachment_name`, `attachment_url`, `status`, `locale`, `model`, `quantity`, `color`, `length`, `tenacity`, `product_id`, `ip`, `user_agent`, `create_by`, `create_time`, `update_by`, `update_time`, `is_deleted`)
VALUES
	(1,'商学斌','258775519@qq.com','湖北智奥线业有限公司','15527788153','CN','polyester','湖北智奥线业有限公司湖北智奥线业有限公司','湖北智奥线业有限公司湖北智奥线业有限公司湖北智奥线业有限公司','',NULL,0,'zh',NULL,NULL,NULL,NULL,NULL,NULL,'::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36',NULL,'2026-04-06 13:28:33',2,'2026-04-09 21:56:51',1),
	(2,'商学斌','258775519@qq.com','湖北智奥线业','18827633950','VN',NULL,'产品询盘','测试测试','4c01a8fc976f48a75953efb0012339eb.jpg',NULL,0,'zh','40/2','10T','Semi-bleached White',NULL,NULL,NULL,'::1','Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36',NULL,'2026-04-09 21:38:27',NULL,'2026-04-09 21:38:27',0);

/*!40000 ALTER TABLE `inquiry` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 product
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` int NOT NULL COMMENT '分类ID',
  `cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '主图',
  `price` decimal(10,2) DEFAULT '0.00' COMMENT '价格',
  `sort` int DEFAULT '100' COMMENT '排序',
  `status` tinyint DEFAULT '1' COMMENT '1=上架 0=下架',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `create_by` int DEFAULT NULL,
  `update_by` int DEFAULT NULL,
  `is_deleted` tinyint DEFAULT '0',
  `model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '规格型号 如40/2,20/2,60/2',
  `material` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '材质',
  `color` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '颜色',
  `length` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '线长/码数',
  `tenacity` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT '强力/拉力',
  PRIMARY KEY (`id`),
  KEY `cate_id` (`cate_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品';

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;

INSERT INTO `product` (`id`, `cate_id`, `cover`, `price`, `sort`, `status`, `create_time`, `update_time`, `create_by`, `update_by`, `is_deleted`, `model`, `material`, `color`, `length`, `tenacity`)
VALUES
	(1,5,'',0.00,100,1,'2026-04-02 11:18:07','2026-04-02 11:42:06',2,2,1,'','','','',''),
	(2,5,'/oss/20260409/25efa637-138d-4c5b-bb7c-7b4f1b9d8237.jpeg',2.00,100,1,'2026-04-02 11:19:31','2026-04-09 10:22:18',2,2,0,'40/2','','Raw White','5000Y','Medium Tenacity');

/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 product_category
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_category`;

CREATE TABLE `product_category` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int DEFAULT '0' COMMENT '父分类ID',
  `sort` int DEFAULT '100' COMMENT '排序',
  `status` tinyint DEFAULT '1' COMMENT '1=启用',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `create_by` int DEFAULT NULL COMMENT '用户ID',
  `update_by` int DEFAULT NULL,
  `is_deleted` tinyint DEFAULT '0',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品分类';

LOCK TABLES `product_category` WRITE;
/*!40000 ALTER TABLE `product_category` DISABLE KEYS */;

INSERT INTO `product_category` (`id`, `parent_id`, `sort`, `status`, `create_time`, `create_by`, `update_by`, `is_deleted`, `update_time`)
VALUES
	(1,0,100,1,'2026-04-01 16:01:42',2,2,1,'2026-04-02 09:37:10'),
	(2,0,100,1,'2026-04-01 16:08:16',2,2,1,'2026-04-02 09:37:10'),
	(3,0,100,1,'2026-04-01 16:15:10',2,2,1,'2026-04-02 09:37:10'),
	(4,0,100,1,'2026-04-01 16:37:00',2,2,1,'2026-04-02 09:37:04'),
	(5,0,1,1,'2026-04-01 16:40:24',2,2,0,'2026-04-06 10:18:14'),
	(6,0,100,1,'2026-04-04 17:15:34',2,2,0,'2026-04-04 17:15:34'),
	(7,0,100,0,'2026-04-04 17:16:44',2,2,0,'2026-04-06 10:14:45'),
	(8,0,2,1,'2026-04-04 17:17:58',2,2,0,'2026-04-06 10:18:20'),
	(9,0,3,1,'2026-04-06 10:14:35',2,2,0,'2026-04-06 10:18:27');

/*!40000 ALTER TABLE `product_category` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 product_category_lang
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_category_lang`;

CREATE TABLE `product_category_lang` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `cate_id` int NOT NULL COMMENT '分类ID',
  `lang` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '语言 en/ar/th/ms/id',
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `create_by` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '修改人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT '0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`),
  UNIQUE KEY `cate_lang_unique` (`cate_id`,`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品分类多语言';

LOCK TABLES `product_category_lang` WRITE;
/*!40000 ALTER TABLE `product_category_lang` DISABLE KEYS */;

INSERT INTO `product_category_lang` (`id`, `cate_id`, `lang`, `name`, `create_by`, `create_time`, `update_by`, `update_time`, `is_deleted`)
VALUES
	(13,6,'zh','棉线',2,'2026-04-04 17:15:34',2,'2026-04-04 17:15:34',0),
	(14,6,'en','Cotton Thread',2,'2026-04-04 17:15:34',2,'2026-04-04 17:15:34',0),
	(15,6,'ar','خيط قطني',2,'2026-04-04 17:15:34',2,'2026-04-04 17:15:34',0),
	(16,6,'vi','Sợi bông',2,'2026-04-04 17:15:34',2,'2026-04-04 17:15:34',0),
	(17,6,'id','Benang Katun',2,'2026-04-04 17:15:34',2,'2026-04-04 17:15:34',0),
	(18,6,'th','ด้ายฝ้าย',2,'2026-04-04 17:15:34',2,'2026-04-04 17:15:34',0),
	(19,6,'km','ខ្សែបន្ទាប់',2,'2026-04-04 17:15:34',2,'2026-04-04 17:15:34',0),
	(20,6,'fr','Fil de Coton',2,'2026-04-04 17:15:34',2,'2026-04-04 17:15:34',0),
	(21,6,'it','Filato di Cotone',2,'2026-04-04 17:15:34',2,'2026-04-04 17:15:34',0),
	(45,7,'ar','خيط نايلون',2,'2026-04-06 10:14:45',2,'2026-04-06 10:14:45',0),
	(46,7,'en','Nylon Thread',2,'2026-04-06 10:14:45',2,'2026-04-06 10:14:45',0),
	(47,7,'fr','Fil en Nylon',2,'2026-04-06 10:14:45',2,'2026-04-06 10:14:45',0),
	(48,7,'id','Benang Nilon',2,'2026-04-06 10:14:45',2,'2026-04-06 10:14:45',0),
	(49,7,'it','Filato in Nylon',2,'2026-04-06 10:14:45',2,'2026-04-06 10:14:45',0),
	(50,7,'km','ខ្សែនីឡុង',2,'2026-04-06 10:14:45',2,'2026-04-06 10:14:45',0),
	(51,7,'th','ด้ายไนลอน',2,'2026-04-06 10:14:45',2,'2026-04-06 10:14:45',0),
	(52,7,'vi','Sợi nylon',2,'2026-04-06 10:14:45',2,'2026-04-06 10:14:45',0),
	(53,7,'zh','尼龙线',2,'2026-04-06 10:14:45',2,'2026-04-06 10:14:45',0),
	(59,5,'ar','خيط البوليستر',2,'2026-04-06 10:18:14',2,'2026-04-06 10:18:14',0),
	(60,5,'en','Polyester Thread',2,'2026-04-06 10:18:14',2,'2026-04-06 10:18:14',0),
	(61,5,'fr','Fil de polyester',2,'2026-04-06 10:18:14',2,'2026-04-06 10:18:14',0),
	(62,5,'id','Benang Poliester',2,'2026-04-06 10:18:14',2,'2026-04-06 10:18:14',0),
	(63,5,'it','Filato in poliestere',2,'2026-04-06 10:18:14',2,'2026-04-06 10:18:14',0),
	(64,5,'km','ខ្សែប៉ូលីអេស្ទ័រ',2,'2026-04-06 10:18:14',2,'2026-04-06 10:18:14',0),
	(65,5,'th','ด้ายโพลีเอสเตอร์',2,'2026-04-06 10:18:14',2,'2026-04-06 10:18:14',0),
	(66,5,'vi','Sợi Polyester',2,'2026-04-06 10:18:14',2,'2026-04-06 10:18:14',0),
	(67,5,'zh','涤纶线',2,'2026-04-06 10:18:14',2,'2026-04-06 10:18:14',0),
	(68,8,'ar','خيط عالي المقاومة',2,'2026-04-06 10:18:20',2,'2026-04-06 10:18:20',0),
	(69,8,'en','High Tenacity Thread',2,'2026-04-06 10:18:20',2,'2026-04-06 10:18:20',0),
	(70,8,'fr','Fil à Haute Résistance',2,'2026-04-06 10:18:20',2,'2026-04-06 10:18:20',0),
	(71,8,'id','Benang Kekuatan Tinggi',2,'2026-04-06 10:18:20',2,'2026-04-06 10:18:20',0),
	(72,8,'it','Filato ad Alta Resistenza',2,'2026-04-06 10:18:20',2,'2026-04-06 10:18:20',0),
	(73,8,'km','ខ្សែកម្លាំងខ្ពស់',2,'2026-04-06 10:18:20',2,'2026-04-06 10:18:20',0),
	(74,8,'th','ด้ายความแรงสูง',2,'2026-04-06 10:18:20',2,'2026-04-06 10:18:20',0),
	(75,8,'vi','Sợi bền lực cao',2,'2026-04-06 10:18:20',2,'2026-04-06 10:18:20',0),
	(76,8,'zh','高强线',2,'2026-04-06 10:18:20',2,'2026-04-06 10:18:20',0),
	(77,9,'ar','خيط ناعم الدانير',2,'2026-04-06 10:18:27',2,'2026-04-06 10:18:27',0),
	(78,9,'en','Fine Denier Thread',2,'2026-04-06 10:18:27',2,'2026-04-06 10:18:27',0),
	(79,9,'id','Benang Halus',2,'2026-04-06 10:18:27',2,'2026-04-06 10:18:27',0),
	(80,9,'th','ด้ายละเอียด',2,'2026-04-06 10:18:27',2,'2026-04-06 10:18:27',0),
	(81,9,'zh','细旦精致线',2,'2026-04-06 10:18:27',2,'2026-04-06 10:18:27',0);

/*!40000 ALTER TABLE `product_category_lang` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 product_lang
# ------------------------------------------------------------

DROP TABLE IF EXISTS `product_lang`;

CREATE TABLE `product_lang` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL COMMENT '产品ID',
  `lang` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '语言 en/ar/th/ms/id',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '产品标题',
  `content` longtext COLLATE utf8mb4_unicode_ci COMMENT '详情内容',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'SEO关键词',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '' COMMENT 'SEO描述',
  `create_by` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '修改人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT '0' COMMENT '逻辑删除标识',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_lang_unique` (`product_id`,`lang`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='产品多语言';

LOCK TABLES `product_lang` WRITE;
/*!40000 ALTER TABLE `product_lang` DISABLE KEYS */;

INSERT INTO `product_lang` (`id`, `product_id`, `lang`, `title`, `content`, `keywords`, `description`, `create_by`, `create_time`, `update_by`, `update_time`, `is_deleted`)
VALUES
	(3,2,'zh','全球供应链的深度调整','<p>全球供应链的深度调整，给中国缝纫线出口带来了结构性的压力，主要体现在以下几个方面：</p><p style=\"text-align: start;\">1. 传统市场份额遭遇挤压，订单转移压力持续。近年来，受国际贸易环境变化及成本等因素驱动，部分服装制造业产能向越南、柬埔寨、孟加拉国等东南亚及南亚国家转移。这直接导致了对上游缝纫线等原材料订单的牵引效应。数据显示，我国对部分传统主力出口市场的针织服装及附件出口出现下滑，而同期我国缝制机械对越南、印度、孟加拉等地的出口额却呈现两位数以上的显著增长，这从侧面印证了下游成衣制造产能的迁移趋势，对国内缝纫线企业的出口订单构成了直接分流。</p><p style=\"text-align: start;\">2. 贸易壁垒与技术门槛不断升高。除了关税波动带来的成本不确定性，欧美等主要市场日益严苛的环保、社会责任及技术标准，正成为新的“绿色壁垒”。例如，OEKO-TEX、GRS（全球回收标准）等认证已成为进入高端市场的敲门砖。然而，行业整体在绿色转型上仍面临动力不足、研发投入偏低（普遍不足5%）的困境，高端原材料如己二腈等仍部分依赖进口，使得部分企业在应对国际新规时显得被动。</p>','全球供应链的深度调整','全球供应链的深度调整全球供应链的深度调整全球供应链的深度调整全球供应链的深度调整全球供应链的深度调整全球供应链的深度调整',2,'2026-04-09 10:22:18',2,'2026-04-09 10:22:18',0);

/*!40000 ALTER TABLE `product_lang` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_config
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_config`;

CREATE TABLE `sys_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `config_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置名称',
  `config_key` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置key',
  `config_value` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置值',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人ID',
  `is_deleted` tinyint NOT NULL DEFAULT '0' COMMENT '逻辑删除标识(0-未删除 1-已删除)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统配置表';

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;

INSERT INTO `sys_config` (`id`, `config_name`, `config_key`, `config_value`, `remark`, `create_time`, `create_by`, `update_time`, `update_by`, `is_deleted`)
VALUES
	(1,'系统限流QPS','IP_QPS_THRESHOLD_LIMIT','10','单个IP请求的最大每秒查询数（QPS）阈值Key','2026-03-31 11:17:06',1,NULL,NULL,0);

/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_dept
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_dept`;

CREATE TABLE `sys_dept` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) NOT NULL COMMENT '部门名称',
  `code` varchar(100) NOT NULL COMMENT '部门编号',
  `parent_id` bigint DEFAULT '0' COMMENT '父节点id',
  `tree_path` varchar(255) NOT NULL COMMENT '父节点id路径',
  `sort` smallint DEFAULT '0' COMMENT '显示顺序',
  `status` tinyint DEFAULT '1' COMMENT '状态(1-正常 0-禁用)',
  `create_by` bigint DEFAULT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '修改人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT '0' COMMENT '逻辑删除标识(1-已删除 0-未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_code` (`code`) USING BTREE COMMENT '部门编号唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='部门管理表';

LOCK TABLES `sys_dept` WRITE;
/*!40000 ALTER TABLE `sys_dept` DISABLE KEYS */;

INSERT INTO `sys_dept` (`id`, `name`, `code`, `parent_id`, `tree_path`, `sort`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `is_deleted`)
VALUES
	(1,'智奥线业','ZHIAO',0,'0',1,1,1,NULL,2,'2026-04-11 15:26:21',0),
	(2,'研发部门','RD001',1,'0,1',1,1,2,NULL,2,'2026-03-31 11:17:06',0),
	(3,'业务部门','YW001',1,'0/1',1,1,2,NULL,2,'2026-04-11 15:31:15',0);

/*!40000 ALTER TABLE `sys_dept` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_dict
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_dict`;

CREATE TABLE `sys_dict` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `dict_code` varchar(50) DEFAULT NULL COMMENT '类型编码',
  `name` varchar(50) DEFAULT NULL COMMENT '类型名称',
  `status` tinyint(1) DEFAULT '0' COMMENT '状态(0:正常;1:禁用)',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '修改人ID',
  `is_deleted` tinyint DEFAULT '0' COMMENT '是否删除(1-删除，0-未删除)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_dict_code` (`dict_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据字典类型表';

LOCK TABLES `sys_dict` WRITE;
/*!40000 ALTER TABLE `sys_dict` DISABLE KEYS */;

INSERT INTO `sys_dict` (`id`, `dict_code`, `name`, `status`, `remark`, `create_time`, `create_by`, `update_time`, `update_by`, `is_deleted`)
VALUES
	(1,'gender','性别',1,NULL,'2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1,0),
	(2,'notice_type','通知类型',1,NULL,'2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1,0),
	(3,'notice_level','通知级别',1,NULL,'2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1,0),
	(4,'language','语言',1,'外贸国际站，多语言适配','2026-04-02 14:02:23',2,'2026-04-02 14:02:23',2,0),
	(5,'model','规格',1,NULL,'2026-04-05 22:58:38',2,'2026-04-05 22:58:38',2,0),
	(6,'color','颜色',1,NULL,'2026-04-05 23:51:35',2,'2026-04-05 23:51:35',2,0),
	(7,'length','长度',1,NULL,'2026-04-05 23:51:54',2,'2026-04-05 23:51:54',2,0),
	(8,'tenacity','强力',1,NULL,'2026-04-05 23:52:12',2,'2026-04-05 23:52:12',2,0);

/*!40000 ALTER TABLE `sys_dict` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_dict_item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_dict_item`;

CREATE TABLE `sys_dict_item` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dict_code` varchar(50) DEFAULT NULL COMMENT '关联字典编码，与sys_dict表中的dict_code对应',
  `value` varchar(50) DEFAULT NULL COMMENT '字典项值',
  `label` varchar(100) DEFAULT NULL COMMENT '字典项标签',
  `tag_type` varchar(50) DEFAULT NULL COMMENT '标签类型，用于前端样式展示（如success、warning等）',
  `status` tinyint DEFAULT '0' COMMENT '状态（1-正常，0-禁用）',
  `sort` int DEFAULT '0' COMMENT '排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '修改人ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据字典项表';

LOCK TABLES `sys_dict_item` WRITE;
/*!40000 ALTER TABLE `sys_dict_item` DISABLE KEYS */;

INSERT INTO `sys_dict_item` (`id`, `dict_code`, `value`, `label`, `tag_type`, `status`, `sort`, `remark`, `create_time`, `create_by`, `update_time`, `update_by`)
VALUES
	(1,'gender','1','男','primary',1,1,NULL,'2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1),
	(2,'gender','2','女','danger',1,2,NULL,'2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1),
	(3,'gender','0','保密','info',1,3,NULL,'2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1),
	(4,'notice_type','1','系统升级','success',1,1,'','2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1),
	(5,'notice_type','2','系统维护','primary',1,2,'','2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1),
	(6,'notice_type','3','安全警告','danger',1,3,'','2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1),
	(7,'notice_type','4','假期通知','success',1,4,'','2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1),
	(8,'notice_type','5','公司新闻','primary',1,5,'','2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1),
	(9,'notice_type','99','其他','info',1,99,'','2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1),
	(10,'notice_level','L','低','info',1,1,'','2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1),
	(11,'notice_level','M','中','warning',1,2,'','2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1),
	(12,'notice_level','H','高','danger',1,3,'','2026-03-31 11:17:06',1,'2026-03-31 11:17:06',1),
	(13,'language','zh','中国','N',1,1,NULL,'2026-04-02 14:03:22',2,'2026-04-02 15:12:16',2),
	(14,'language','en','欧美','N',1,1,NULL,'2026-04-02 14:05:08',2,'2026-04-02 14:05:08',2),
	(15,'language','ar','中东','N',1,1,NULL,'2026-04-02 14:06:14',2,'2026-04-02 14:06:14',2),
	(16,'language','vi','越南','N',1,1,NULL,'2026-04-02 14:06:36',2,'2026-04-02 14:06:36',2),
	(17,'language','id','印尼','N',1,1,NULL,'2026-04-02 14:06:57',2,'2026-04-02 14:06:57',2),
	(18,'language','th','泰国','N',1,1,NULL,'2026-04-02 14:39:11',2,'2026-04-02 14:39:11',2),
	(19,'language','km','柬埔寨','N',1,1,NULL,'2026-04-02 14:39:57',2,'2026-04-02 14:39:57',2),
	(20,'language','fr','法国','N',1,1,NULL,'2026-04-02 14:40:22',2,'2026-04-02 14:40:22',2),
	(21,'language','it','意大利','N',1,1,NULL,'2026-04-02 14:40:29',2,'2026-04-02 14:40:29',2),
	(22,'model','20/2','20/2','N',1,1,NULL,'2026-04-05 23:34:31',2,'2026-04-05 23:34:31',2),
	(23,'model','20/3','20/3','N',1,1,NULL,'2026-04-05 23:34:44',2,'2026-04-05 23:34:44',2),
	(24,'model','30/2','30/2','N',1,1,NULL,'2026-04-05 23:35:10',2,'2026-04-05 23:35:10',2),
	(25,'model','40/2','40/2','P',1,1,NULL,'2026-04-05 23:35:28',2,'2026-04-05 23:37:36',2),
	(26,'model','40/3','40/3','N',1,1,NULL,'2026-04-05 23:35:39',2,'2026-04-05 23:35:39',2),
	(27,'model','50/2','50/2','N',1,1,NULL,'2026-04-05 23:36:03',2,'2026-04-05 23:36:03',2),
	(28,'model','60/2','60/2','N',1,1,NULL,'2026-04-05 23:36:25',2,'2026-04-05 23:36:25',2),
	(29,'model','60/3','60/3','N',1,1,NULL,'2026-04-05 23:36:37',2,'2026-04-05 23:36:37',2),
	(30,'model','80/2','80/2','N',1,1,NULL,'2026-04-05 23:36:51',2,'2026-04-05 23:36:51',2),
	(31,'color','Raw White','本白','N',1,1,NULL,'2026-04-05 23:53:00',2,'2026-04-05 23:53:00',2),
	(32,'color','Semi-bleached White','半漂白','N',1,1,NULL,'2026-04-05 23:53:17',2,'2026-04-05 23:53:17',2),
	(33,'color','Black','黑色','N',1,1,NULL,'2026-04-05 23:53:27',2,'2026-04-05 23:53:27',2),
	(34,'color','Red','红色','N',1,1,NULL,'2026-04-05 23:53:37',2,'2026-04-05 23:53:37',2),
	(35,'color','Blue','蓝色','N',1,1,NULL,'2026-04-05 23:53:51',2,'2026-04-05 23:53:51',2),
	(36,'color','Yellow','黄色','N',1,1,NULL,'2026-04-05 23:54:17',2,'2026-04-05 23:54:17',2),
	(37,'color','Green','绿色','N',1,1,NULL,'2026-04-05 23:55:17',2,'2026-04-05 23:55:17',2),
	(38,'color','Navy','藏青','N',1,1,NULL,'2026-04-05 23:55:29',2,'2026-04-05 23:55:29',2),
	(39,'color','Grey','灰色','N',1,1,NULL,'2026-04-05 23:55:42',2,'2026-04-05 23:55:42',2),
	(40,'color','Coffee','咖啡色','N',1,1,NULL,'2026-04-05 23:56:14',2,'2026-04-05 23:56:14',2),
	(41,'color','Custom Color','可定制染色','N',1,1,NULL,'2026-04-05 23:56:57',2,'2026-04-05 23:56:57',2),
	(42,'length','3000Y','3000Y','N',1,1,NULL,'2026-04-05 23:58:21',2,'2026-04-05 23:58:21',2),
	(43,'length','4000Y','4000Y','N',1,1,NULL,'2026-04-05 23:58:30',2,'2026-04-05 23:58:30',2),
	(44,'length','5000Y','5000Y','N',1,1,NULL,'2026-04-05 23:58:38',2,'2026-04-05 23:58:38',2),
	(45,'length','8000Y','8000Y','N',1,1,NULL,'2026-04-05 23:58:46',2,'2026-04-05 23:58:46',2),
	(46,'length','10000Y','10000Y','N',1,1,NULL,'2026-04-05 23:58:53',2,'2026-04-05 23:58:53',2),
	(47,'length','16000Y','16000Y','N',1,1,NULL,'2026-04-05 23:59:06',2,'2026-04-05 23:59:06',2),
	(48,'tenacity','High Tenacity','高强力','N',1,1,NULL,'2026-04-06 00:00:42',2,'2026-04-06 00:00:42',2),
	(49,'tenacity','Medium Tenacity','中强力','N',1,1,NULL,'2026-04-06 00:00:58',2,'2026-04-06 00:00:58',2),
	(50,'tenacity','Medium-Low Tenacity','中低强力','N',1,1,NULL,'2026-04-06 00:01:11',2,'2026-04-06 00:01:11',2),
	(51,'tenacity','Low Tenacity','低强力','N',1,1,NULL,'2026-04-06 00:01:24',2,'2026-04-06 00:01:24',2);

/*!40000 ALTER TABLE `sys_dict_item` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_log
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_log`;

CREATE TABLE `sys_log` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `module` tinyint NOT NULL COMMENT '模块，数字枚举，参考 LogModule 枚举',
  `action_type` tinyint NOT NULL COMMENT '操作类型，数字枚举，参考 ActionType 枚举',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '前端显示标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '自定义日志内容',
  `operator_id` bigint NOT NULL COMMENT '操作人ID',
  `operator_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作人名称',
  `request_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求路径',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '请求方法',
  `ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'IP地址',
  `province` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '省份',
  `city` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '城市',
  `device` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '设备',
  `os` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作系统',
  `browser` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '浏览器',
  `status` tinyint DEFAULT '1' COMMENT '0失败 1成功',
  `error_msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '错误信息',
  `execution_time` int DEFAULT NULL COMMENT '执行时间(ms)',
  `create_time` datetime DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_module_action_time` (`module`,`action_type`,`create_time`),
  KEY `idx_operator_time` (`operator_id`,`create_time`),
  KEY `idx_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统操作日志表';

LOCK TABLES `sys_log` WRITE;
/*!40000 ALTER TABLE `sys_log` DISABLE KEYS */;

INSERT INTO `sys_log` (`id`, `module`, `action_type`, `title`, `content`, `operator_id`, `operator_name`, `request_uri`, `request_method`, `ip`, `province`, `city`, `device`, `os`, `browser`, `status`, `error_msg`, `execution_time`, `create_time`)
VALUES
	(1,2,5,'用户管理-删除',NULL,2,'admin','/api/v1/users/3','DELETE','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,45,'2026-03-31 13:55:09'),
	(2,2,4,'用户管理-修改',NULL,2,'admin','/api/v1/users/7','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,38,'2026-03-31 13:56:18'),
	(3,5,5,'菜单管理-删除',NULL,2,'admin','/api/v1/menus/504','DELETE','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,79,'2026-03-31 14:00:37'),
	(4,5,5,'菜单管理-删除',NULL,2,'admin','/api/v1/menus/502','DELETE','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,10,'2026-03-31 14:00:40'),
	(5,5,5,'菜单管理-删除',NULL,2,'admin','/api/v1/menus/501','DELETE','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,7,'2026-03-31 14:00:42'),
	(6,5,5,'菜单管理-删除',NULL,2,'admin','/api/v1/menus/503','DELETE','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,8,'2026-03-31 14:00:45'),
	(7,5,5,'菜单管理-删除',NULL,2,'admin','/api/v1/menus/4','DELETE','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,11,'2026-03-31 14:00:47'),
	(8,5,5,'菜单管理-删除',NULL,2,'admin','/api/v1/menus/913','DELETE','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,16,'2026-03-31 14:01:24'),
	(9,5,5,'菜单管理-删除',NULL,2,'admin','/api/v1/menus/912','DELETE','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,7,'2026-03-31 14:01:27'),
	(10,5,5,'菜单管理-删除',NULL,2,'admin','/api/v1/menus/911','DELETE','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,12,'2026-03-31 14:01:29'),
	(11,5,5,'菜单管理-删除',NULL,2,'admin','/api/v1/menus/910','DELETE','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,9,'2026-03-31 14:01:31'),
	(12,5,5,'菜单管理-删除',NULL,2,'admin','/api/v1/menus/8','DELETE','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,34,'2026-03-31 14:01:34'),
	(13,3,6,'角色管理-授权',NULL,2,'admin','/api/v1/roles/2/menus','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,108,'2026-03-31 21:53:33'),
	(14,3,6,'角色管理-授权',NULL,2,'admin','/api/v1/roles/2/menus','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,41,'2026-03-31 22:01:58'),
	(15,3,6,'角色管理-授权',NULL,2,'admin','/api/v1/roles/2/menus','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,127,'2026-04-01 10:03:47'),
	(16,3,6,'角色管理-授权',NULL,2,'admin','/api/v1/roles/2/menus','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,55,'2026-04-01 10:06:51'),
	(17,3,6,'角色管理-授权',NULL,2,'admin','/api/v1/roles/2/menus','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,53,'2026-04-01 10:08:04'),
	(18,3,6,'角色管理-授权',NULL,2,'admin','/api/v1/roles/2/menus','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,80,'2026-04-01 10:13:01'),
	(19,2,4,'用户管理-修改',NULL,2,'admin','/api/v1/users/profile','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,68,'2026-04-02 01:01:15'),
	(20,3,6,'角色管理-授权',NULL,2,'admin','/api/v1/roles/2/menus','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,88,'2026-04-02 13:39:19'),
	(21,3,6,'角色管理-授权',NULL,2,'admin','/api/v1/roles/2/menus','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,67,'2026-04-02 13:56:53'),
	(22,6,4,'字典管理-修改',NULL,2,'admin','/api/v1/dicts/language/items/13','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,71,'2026-04-02 14:04:20'),
	(23,6,4,'字典管理-修改',NULL,2,'admin','/api/v1/dicts/language/items/13','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,294,'2026-04-02 15:12:16'),
	(24,3,6,'角色管理-授权',NULL,2,'admin','/api/v1/roles/2/menus','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,48,'2026-04-05 19:22:54'),
	(25,6,4,'字典管理-修改',NULL,2,'admin','/api/v1/dicts/model/items/25','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,43,'2026-04-05 23:37:36'),
	(26,4,4,'部门管理-修改',NULL,2,'admin','/api/v1/depts/1','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,145,'2026-04-11 15:26:21'),
	(27,2,5,'用户管理-删除',NULL,2,'admin','/api/v1/users/4,5,6,7','DELETE','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,58,'2026-04-11 15:27:00'),
	(28,2,4,'用户管理-修改',NULL,2,'admin','/api/v1/users/2','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',0,'Business Exception',15,'2026-04-11 15:27:35'),
	(29,2,4,'用户管理-修改',NULL,2,'admin','/api/v1/users/2','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',0,'Business Exception',4,'2026-04-11 15:27:41'),
	(30,2,4,'用户管理-修改',NULL,2,'admin','/api/v1/users/2','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',0,'Business Exception',12,'2026-04-11 15:27:55'),
	(31,4,4,'部门管理-修改',NULL,2,'admin','/api/v1/depts/3','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',0,'Business Exception',10,'2026-04-11 15:31:00'),
	(32,4,4,'部门管理-修改',NULL,2,'admin','/api/v1/depts/3','PUT','::1',NULL,NULL,'macOS 10.15.7','macOS 10.15.7','Chrome 146.0.0.0',1,NULL,35,'2026-04-11 15:31:15');

/*!40000 ALTER TABLE `sys_log` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `parent_id` bigint NOT NULL COMMENT '父菜单ID',
  `tree_path` varchar(255) DEFAULT NULL COMMENT '父节点ID路径',
  `name` varchar(64) NOT NULL COMMENT '菜单名称',
  `type` char(1) NOT NULL COMMENT '菜单类型（C-目录 M-菜单 B-按钮）',
  `route_name` varchar(255) DEFAULT NULL COMMENT '路由名称（Vue Router 中用于命名路由）',
  `route_path` varchar(128) DEFAULT NULL COMMENT '路由路径（Vue Router 中定义的 URL 路径）',
  `component` varchar(128) DEFAULT NULL COMMENT '组件路径（组件页面完整路径，相对于 src/views/，缺省后缀 .vue）',
  `perm` varchar(128) DEFAULT NULL COMMENT '【按钮】权限标识',
  `always_show` tinyint DEFAULT '0' COMMENT '【目录】只有一个子路由是否始终显示（1-是 0-否）',
  `keep_alive` tinyint DEFAULT '0' COMMENT '【菜单】是否开启页面缓存（1-是 0-否）',
  `visible` tinyint(1) DEFAULT '1' COMMENT '显示状态（1-显示 0-隐藏）',
  `sort` int DEFAULT '0' COMMENT '排序',
  `icon` varchar(64) DEFAULT NULL COMMENT '菜单图标',
  `redirect` varchar(128) DEFAULT NULL COMMENT '跳转路径',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `params` json DEFAULT NULL COMMENT '路由参数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统菜单表';

LOCK TABLES `sys_menu` WRITE;
/*!40000 ALTER TABLE `sys_menu` DISABLE KEYS */;

INSERT INTO `sys_menu` (`id`, `parent_id`, `tree_path`, `name`, `type`, `route_name`, `route_path`, `component`, `perm`, `always_show`, `keep_alive`, `visible`, `sort`, `icon`, `redirect`, `create_time`, `update_time`, `params`)
VALUES
	(1,0,'0','系统管理','C','','/system','Layout',NULL,NULL,NULL,1,4,'system','/system/user','2026-03-31 11:17:06','2026-03-31 22:01:49',NULL),
	(2,0,'0','代码生成','C','','/codegen','Layout',NULL,NULL,NULL,0,2,'code','/codegen/index','2026-03-31 11:17:06','2026-04-01 09:37:43',NULL),
	(5,0,'0','接口文档','C','','/api','Layout',NULL,NULL,NULL,0,5,'api','','2026-03-31 11:17:06','2026-03-31 21:52:18',NULL),
	(6,0,'0','组件封装','C','','/component','Layout',NULL,NULL,NULL,1,6,'menu','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(7,0,'0','功能演示','C','','/function','Layout',NULL,NULL,NULL,0,7,'menu','','2026-03-31 11:17:06','2026-04-02 18:52:26',NULL),
	(9,0,'0','路由参数','C','','/route-param','Layout',NULL,NULL,NULL,0,9,'el-icon-ElementPlus','','2026-03-31 11:17:06','2026-04-01 09:37:33',NULL),
	(210,1,'0,1','用户管理','M','User','user','system/user/index',NULL,NULL,1,1,1,'el-icon-User',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(220,1,'0,1','角色管理','M','Role','role','system/role/index',NULL,NULL,1,1,2,'role',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(230,1,'0,1','菜单管理','M','SysMenu','menu','system/menu/index',NULL,NULL,1,1,3,'menu',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(240,1,'0,1','部门管理','M','Dept','dept','system/dept/index',NULL,NULL,1,1,4,'tree',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(250,1,'0,1','字典管理','M','Dict','dict','system/dict/index',NULL,NULL,1,1,5,'dict',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(251,1,'0,1','字典项','M','DictItem','dict-item','system/dict/dict-item',NULL,0,1,0,6,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(260,1,'0,1','系统日志','M','Log','log','system/log/index',NULL,0,1,1,7,'document',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(270,1,'0,1','系统配置','M','Config','config','system/config/index',NULL,0,1,1,8,'setting',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(280,1,'0,1','通知公告','M','Notice','notice','system/notice/index',NULL,NULL,NULL,1,9,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(310,2,'0,2','代码生成','M','Codegen','codegen','codegen/index',NULL,NULL,1,1,1,'code',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(601,5,'0,5','Apifox','M','Apifox','apifox','demo/api/apifox',NULL,0,1,1,1,'api','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(701,6,'0,6','富文本编辑器','M','WangEditor','wang-editor','demo/wang-editor',NULL,NULL,1,1,2,'','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(702,6,'0,6','图片上传','M','Upload','upload','demo/upload',NULL,NULL,1,1,3,'','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(703,6,'0,6','图标选择器','M','IconSelect','icon-select','demo/icon-select',NULL,NULL,1,1,4,'','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(704,6,'0,6','字典组件','M','DictDemo','dict-demo','demo/dictionary',NULL,NULL,1,1,4,'','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(705,6,'0,6','增删改查','M','Curd','curd','demo/curd/index',NULL,NULL,1,1,0,'','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(706,6,'0,6','列表选择器','M','TableSelect','table-select','demo/table-select/index',NULL,NULL,1,1,1,'','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(707,6,'0,6','拖拽组件','M','Drag','drag','demo/drag',NULL,NULL,NULL,1,5,'','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(708,6,'0,6','滚动文本','M','TextScroll','text-scroll','demo/text-scroll',NULL,NULL,NULL,1,6,'','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(709,6,'0,6','自适应表格操作列','M','AutoOperationColumn','operation-column','demo/auto-operation-column',NULL,NULL,1,1,1,'','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(801,7,'0,7','Icons','M','IconDemo','icon-demo','demo/icons',NULL,NULL,1,1,2,'el-icon-Notification','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(802,7,'0,7','字典实时同步','M','DictSync','dict-sync','demo/dict-sync',NULL,NULL,NULL,1,3,'','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(803,7,'0,7','VxeTable','M','VxeTable','vxe-table','demo/vxe-table/index',NULL,NULL,1,1,4,'el-icon-MagicStick','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(804,7,'0,7','CURD单文件','M','CurdSingle','curd-single','demo/curd-single',NULL,NULL,1,1,5,'el-icon-Reading','','2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(1001,9,'0,9','参数(type=1)','M','RouteParamType1','route-param-type1','demo/route-param',NULL,0,1,1,1,'el-icon-Star',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06','{\"type\": \"1\"}'),
	(1002,9,'0,9','参数(type=2)','M','RouteParamType2','route-param-type2','demo/route-param',NULL,0,1,1,2,'el-icon-StarFilled',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06','{\"type\": \"2\"}'),
	(2101,210,'0,1,210','用户查询','B',NULL,'',NULL,'sys:user:list',NULL,NULL,1,1,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2102,210,'0,1,210','用户新增','B',NULL,'',NULL,'sys:user:create',NULL,NULL,1,2,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2103,210,'0,1,210','用户编辑','B',NULL,'',NULL,'sys:user:update',NULL,NULL,1,3,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2104,210,'0,1,210','用户删除','B',NULL,'',NULL,'sys:user:delete',NULL,NULL,1,4,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2105,210,'0,1,210','重置密码','B',NULL,'',NULL,'sys:user:reset-password',NULL,NULL,1,5,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2106,210,'0,1,210','用户导入','B',NULL,'',NULL,'sys:user:import',NULL,NULL,1,6,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2107,210,'0,1,210','用户导出','B',NULL,'',NULL,'sys:user:export',NULL,NULL,1,7,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2201,220,'0,1,220','角色查询','B',NULL,'',NULL,'sys:role:list',NULL,NULL,1,1,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2202,220,'0,1,220','角色新增','B',NULL,'',NULL,'sys:role:create',NULL,NULL,1,2,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2203,220,'0,1,220','角色编辑','B',NULL,'',NULL,'sys:role:update',NULL,NULL,1,3,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2204,220,'0,1,220','角色删除','B',NULL,'',NULL,'sys:role:delete',NULL,NULL,1,4,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2205,220,'0,1,220','角色分配权限','B',NULL,'',NULL,'sys:role:assign',NULL,NULL,1,5,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2301,230,'0,1,230','菜单查询','B',NULL,'',NULL,'sys:menu:list',NULL,NULL,1,1,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2302,230,'0,1,230','菜单新增','B',NULL,'',NULL,'sys:menu:create',NULL,NULL,1,2,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2303,230,'0,1,230','菜单编辑','B',NULL,'',NULL,'sys:menu:update',NULL,NULL,1,3,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2304,230,'0,1,230','菜单删除','B',NULL,'',NULL,'sys:menu:delete',NULL,NULL,1,4,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2401,240,'0,1,240','部门查询','B',NULL,'',NULL,'sys:dept:list',NULL,NULL,1,1,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2402,240,'0,1,240','部门新增','B',NULL,'',NULL,'sys:dept:create',NULL,NULL,1,2,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2403,240,'0,1,240','部门编辑','B',NULL,'',NULL,'sys:dept:update',NULL,NULL,1,3,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2404,240,'0,1,240','部门删除','B',NULL,'',NULL,'sys:dept:delete',NULL,NULL,1,4,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2501,250,'0,1,250','字典查询','B',NULL,'',NULL,'sys:dict:list',NULL,NULL,1,1,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2502,250,'0,1,250','字典新增','B',NULL,'',NULL,'sys:dict:create',NULL,NULL,1,2,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2503,250,'0,1,250','字典编辑','B',NULL,'',NULL,'sys:dict:update',NULL,NULL,1,3,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2504,250,'0,1,250','字典删除','B',NULL,'',NULL,'sys:dict:delete',NULL,NULL,1,4,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2511,251,'0,1,251','字典项查询','B',NULL,'',NULL,'sys:dict-item:list',NULL,NULL,1,1,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2512,251,'0,1,251','字典项新增','B',NULL,'',NULL,'sys:dict-item:create',NULL,NULL,1,2,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2513,251,'0,1,251','字典项编辑','B',NULL,'',NULL,'sys:dict-item:update',NULL,NULL,1,3,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2514,251,'0,1,251','字典项删除','B',NULL,'',NULL,'sys:dict-item:delete',NULL,NULL,1,4,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2601,260,'0,1,260','日志查询','B',NULL,'',NULL,'sys:log:list',NULL,NULL,1,1,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2701,270,'0,1,270','系统配置查询','B',NULL,'',NULL,'sys:config:list',0,1,1,1,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2702,270,'0,1,270','系统配置新增','B',NULL,'',NULL,'sys:config:create',0,1,1,2,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2703,270,'0,1,270','系统配置修改','B',NULL,'',NULL,'sys:config:update',0,1,1,3,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2704,270,'0,1,270','系统配置删除','B',NULL,'',NULL,'sys:config:delete',0,1,1,4,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2705,270,'0,1,270','系统配置刷新','B',NULL,'',NULL,'sys:config:refresh',0,1,1,5,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2801,280,'0,1,280','通知查询','B',NULL,'',NULL,'sys:notice:list',NULL,NULL,1,1,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2802,280,'0,1,280','通知新增','B',NULL,'',NULL,'sys:notice:create',NULL,NULL,1,2,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2803,280,'0,1,280','通知编辑','B',NULL,'',NULL,'sys:notice:update',NULL,NULL,1,3,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2804,280,'0,1,280','通知删除','B',NULL,'',NULL,'sys:notice:delete',NULL,NULL,1,4,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2805,280,'0,1,280','通知发布','B',NULL,'',NULL,'sys:notice:publish',0,1,1,5,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2806,280,'0,1,280','通知撤回','B',NULL,'',NULL,'sys:notice:revoke',0,1,1,6,'',NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',NULL),
	(2807,0,'2807','产品中心','C',NULL,'/product','Layout',NULL,1,1,1,3,'juejin',NULL,'2026-03-31 15:57:27','2026-03-31 21:36:09',NULL),
	(2808,2807,'2807,2808','产品列表','M','List','list','product/list/index',NULL,0,1,1,1,NULL,NULL,'2026-03-31 16:00:41','2026-03-31 16:08:28',NULL),
	(2809,2807,'2807,2809','产品分类','M','Category','category','product/category/index',NULL,0,1,1,1,NULL,NULL,'2026-03-31 16:02:53','2026-03-31 16:08:21',NULL),
	(2810,0,'2810','文章管理','C',NULL,'/article','Layout',NULL,1,1,1,1,'el-icon-Document',NULL,'2026-03-31 21:50:11','2026-03-31 21:50:11',NULL),
	(2811,2810,'2810,2811','文章列表','M','ArticleList','list','article/list/index',NULL,0,1,1,1,NULL,NULL,'2026-03-31 22:01:04','2026-04-01 10:41:42',NULL),
	(2812,2810,'2810,2812','文章分类','M','ArticleCategory','category','article/category/index',NULL,0,1,1,1,NULL,NULL,'2026-03-31 22:01:41','2026-04-01 10:41:54',NULL),
	(2813,0,'2813','单面管理','C','','/company','Layout',NULL,0,1,1,20,'client',NULL,'2026-04-02 13:39:00','2026-04-02 13:58:21',NULL),
	(2814,2813,'2813,2814','单页管理','M','Company','company','company/index',NULL,0,1,1,1,NULL,NULL,'2026-04-02 13:56:18','2026-04-02 13:56:18','[]'),
	(2815,2814,'2813,2814,2815','询盘查询','B',NULL,'',NULL,'inquiry:list',NULL,NULL,1,1,'',NULL,'2026-04-05 19:14:43','2026-04-05 19:14:43',NULL),
	(2816,2814,'2813,2814,2816','询盘查看','B',NULL,'',NULL,'inquiry:detail',NULL,NULL,1,2,'',NULL,'2026-04-05 19:14:43','2026-04-05 19:14:43',NULL),
	(2817,2814,'2813,2814,2817','询盘编辑','B',NULL,'',NULL,'inquiry:update',NULL,NULL,1,3,'',NULL,'2026-04-05 19:14:43','2026-04-05 19:14:43',NULL),
	(2818,2814,'2813,2814,2818','询盘删除','B',NULL,'',NULL,'inquiry:delete',NULL,NULL,1,4,'',NULL,'2026-04-05 19:14:43','2026-04-05 19:14:43',NULL),
	(2819,0,'2819','询盘管理','C',NULL,'/inquiry','Layout',NULL,0,1,1,21,'wechat',NULL,'2026-04-05 19:21:21','2026-04-05 19:21:31','[]'),
	(2820,2819,'2819,2820','询盘管理','M','Inquiry','inquiry','inquiry/list/index',NULL,0,1,1,1,NULL,NULL,'2026-04-05 19:22:27','2026-04-05 19:22:27','[]');

/*!40000 ALTER TABLE `sys_menu` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_notice
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_notice`;

CREATE TABLE `sys_notice` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(50) DEFAULT NULL COMMENT '通知标题',
  `content` text COMMENT '通知内容',
  `type` tinyint NOT NULL COMMENT '通知类型（关联字典编码：notice_type）',
  `level` varchar(5) NOT NULL COMMENT '通知等级（字典code：notice_level）',
  `target_type` tinyint NOT NULL COMMENT '目标类型（1: 全体, 2: 指定）',
  `target_user_ids` varchar(255) DEFAULT NULL COMMENT '目标人ID集合（多个使用英文逗号,分割）',
  `publisher_id` bigint DEFAULT NULL COMMENT '发布人ID',
  `publish_status` tinyint DEFAULT '0' COMMENT '发布状态（0: 未发布, 1: 已发布, -1: 已撤回）',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `revoke_time` datetime DEFAULT NULL COMMENT '撤回时间',
  `create_by` bigint NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '是否删除（0: 未删除, 1: 已删除）',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统通知公告表';

LOCK TABLES `sys_notice` WRITE;
/*!40000 ALTER TABLE `sys_notice` DISABLE KEYS */;

INSERT INTO `sys_notice` (`id`, `title`, `content`, `type`, `level`, `target_type`, `target_user_ids`, `publisher_id`, `publish_status`, `publish_time`, `revoke_time`, `create_by`, `create_time`, `update_by`, `update_time`, `is_deleted`)
VALUES
	(1,'v3.0.0 版本发布 - 多租户功能上线','<p>🎉 新版本发布，主要更新内容：</p><p>1. 新增多租户功能，支持租户隔离和数据管理</p><p>2. 优化系统性能，提升响应速度</p><p>3. 完善权限管理，增强安全性</p><p>4. 修复已知问题，提升系统稳定性</p>',1,'H',1,NULL,1,1,'2024-12-15 10:00:00',NULL,1,'2024-12-15 10:00:00',2,'2026-03-31 15:35:16',1),
	(2,'系统维护通知 - 2024年12月20日','<p>⏰ 系统维护通知</p><p>系统将于 <strong>2024年12月20日（本周五）凌晨 2:00-4:00</strong> 进行例行维护升级。</p><p>维护期间系统将暂停服务，请提前做好数据备份工作。</p><p>给您带来的不便，敬请谅解！</p>',2,'H',1,NULL,1,1,'2024-12-18 14:30:00',NULL,1,'2024-12-18 14:30:00',2,'2026-03-31 15:35:16',1),
	(3,'安全提醒 - 防范钓鱼邮件','<p>⚠️ 安全提醒</p><p>近期发现有不法分子通过钓鱼邮件进行网络攻击，请大家提高警惕：</p><p>1. 不要点击来源不明的邮件链接</p><p>2. 不要下载可疑附件</p><p>3. 遇到可疑邮件请及时联系IT部门</p><p>4. 定期修改密码，使用强密码策略</p>',3,'H',1,NULL,1,1,'2024-12-10 09:00:00',NULL,1,'2024-12-10 09:00:00',2,'2026-03-31 15:35:16',1),
	(4,'元旦假期安排通知','<p>📅 元旦假期安排</p><p>根据国家法定节假日安排，公司元旦假期时间为：</p><p><strong>2024年12月30日（周一）至 2025年1月1日（周三）</strong>，共3天。</p><p>2024年12月29日（周日）正常上班。</p><p>祝大家元旦快乐，假期愉快！</p>',4,'M',1,NULL,1,1,'2024-12-25 16:00:00',NULL,1,'2024-12-25 16:00:00',2,'2026-03-31 15:35:16',1),
	(5,'新产品发布会邀请','<p>🎊 新产品发布会邀请</p><p>公司将于 <strong>2025年1月15日下午14:00</strong> 在总部会议室举办新产品发布会。</p><p>届时将展示最新研发的产品和技术成果，欢迎全体员工参加。</p><p>请各部门提前安排好工作，准时参加。</p>',5,'M',1,NULL,1,1,'2024-12-28 11:00:00',NULL,1,'2024-12-28 11:00:00',2,'2026-03-31 15:35:16',1),
	(6,'v2.16.1 版本更新','<p>✨ 版本更新</p><p>v2.16.1 版本已发布，主要修复内容：</p><p>1. 修复 WebSocket 重复连接导致的后台线程阻塞问题</p><p>2. 优化通知公告功能，提升用户体验</p><p>3. 修复部分已知bug</p><p>建议尽快更新到最新版本。</p>',1,'M',1,NULL,1,1,'2024-12-05 15:30:00',NULL,1,'2024-12-05 15:30:00',1,'2024-12-05 15:30:00',0),
	(7,'年终总结会议通知','<p>📋 年终总结会议通知</p><p>各部门年终总结会议将于 <strong>2024年12月30日上午9:00</strong> 召开。</p><p>请各部门负责人提前准备好年度工作总结和下年度工作计划。</p><p>会议地点：总部大会议室</p>',5,'M',2,'1,2',1,1,'2024-12-22 10:00:00',NULL,1,'2024-12-22 10:00:00',2,'2026-03-31 15:35:16',1),
	(8,'系统功能优化完成','<p>✅ 系统功能优化</p><p>已完成以下功能优化：</p><p>1. 优化用户管理界面，提升操作体验</p><p>2. 增强数据导出功能，支持更多格式</p><p>3. 优化搜索功能，提升查询效率</p><p>4. 修复部分界面显示问题</p>',1,'L',1,NULL,1,1,'2024-12-12 14:20:00',NULL,1,'2024-12-12 14:20:00',2,'2026-03-31 15:35:16',1),
	(9,'员工培训计划','<p>📚 员工培训计划</p><p>为提升员工专业技能，公司将于 <strong>2025年1月8日-10日</strong> 组织技术培训。</p><p>培训内容：</p><p>1. 新技术框架应用</p><p>2. 代码规范与最佳实践</p><p>3. 系统架构设计</p><p>请各部门合理安排工作，确保培训顺利进行。</p>',5,'M',1,NULL,1,1,'2024-12-20 09:30:00',NULL,1,'2024-12-20 09:30:00',2,'2026-03-31 15:35:16',1),
	(10,'数据备份提醒','<p>💾 数据备份提醒</p><p>请各部门注意定期备份重要数据，建议每周至少备份一次。</p><p>备份方式：</p><p>1. 使用系统自带备份功能</p><p>2. 手动导出重要数据</p><p>3. 联系IT部门协助备份</p><p>数据安全，人人有责！</p>',3,'L',1,NULL,1,1,'2024-12-08 08:00:00',NULL,1,'2024-12-08 08:00:00',2,'2026-03-31 15:35:16',1);

/*!40000 ALTER TABLE `sys_notice` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL COMMENT '角色名称',
  `code` varchar(32) NOT NULL COMMENT '角色编码',
  `sort` int DEFAULT NULL COMMENT '显示顺序',
  `status` tinyint(1) DEFAULT '1' COMMENT '角色状态(1-正常 0-停用)',
  `data_scope` tinyint DEFAULT NULL COMMENT '数据权限(1-所有数据 2-部门及子部门数据 3-本部门数据 4-本人数据 5-自定义部门数据)',
  `create_by` bigint DEFAULT NULL COMMENT '创建人 ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint DEFAULT NULL COMMENT '更新人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '逻辑删除标识(0-未删除 1-已删除)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uk_name` (`name`) USING BTREE COMMENT '角色名称唯一索引',
  UNIQUE KEY `uk_code` (`code`) USING BTREE COMMENT '角色编码唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统角色表';

LOCK TABLES `sys_role` WRITE;
/*!40000 ALTER TABLE `sys_role` DISABLE KEYS */;

INSERT INTO `sys_role` (`id`, `name`, `code`, `sort`, `status`, `data_scope`, `create_by`, `create_time`, `update_by`, `update_time`, `is_deleted`)
VALUES
	(1,'超级管理员','ROOT',1,1,1,NULL,'2026-03-31 11:17:06',NULL,'2026-03-31 11:17:06',0),
	(2,'系统管理员','ADMIN',2,1,1,NULL,'2026-03-31 11:17:06',NULL,NULL,0),
	(3,'访问游客','GUEST',3,1,3,NULL,'2026-03-31 11:17:06',NULL,'2026-03-31 11:17:06',0),
	(4,'部门主管','DEPT_MANAGER',4,1,2,NULL,'2026-03-31 11:17:06',NULL,'2026-03-31 11:17:06',0),
	(5,'部门成员','DEPT_MEMBER',5,1,3,NULL,'2026-03-31 11:17:06',NULL,'2026-03-31 11:17:06',0),
	(6,'普通员工','EMPLOYEE',6,1,4,NULL,'2026-03-31 11:17:06',NULL,'2026-03-31 11:17:06',0),
	(7,'自定义权限用户','CUSTOM_USER',7,1,5,NULL,'2026-03-31 11:17:06',NULL,'2026-03-31 11:17:06',0);

/*!40000 ALTER TABLE `sys_role` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_role_dept
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role_dept`;

CREATE TABLE `sys_role_dept` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  UNIQUE KEY `uk_roleid_deptid` (`role_id`,`dept_id`) USING BTREE COMMENT '角色部门唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色部门关联表';

LOCK TABLES `sys_role_dept` WRITE;
/*!40000 ALTER TABLE `sys_role_dept` DISABLE KEYS */;

INSERT INTO `sys_role_dept` (`role_id`, `dept_id`)
VALUES
	(7,1),
	(7,2);

/*!40000 ALTER TABLE `sys_role_dept` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_role_menu
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_role_menu`;

CREATE TABLE `sys_role_menu` (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  UNIQUE KEY `uk_roleid_menuid` (`role_id`,`menu_id`) USING BTREE COMMENT '角色菜单唯一索引'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色菜单关联表';

LOCK TABLES `sys_role_menu` WRITE;
/*!40000 ALTER TABLE `sys_role_menu` DISABLE KEYS */;

INSERT INTO `sys_role_menu` (`role_id`, `menu_id`)
VALUES
	(2,1),
	(2,2),
	(2,5),
	(2,6),
	(2,7),
	(2,9),
	(2,210),
	(2,220),
	(2,230),
	(2,240),
	(2,250),
	(2,251),
	(2,260),
	(2,270),
	(2,280),
	(2,310),
	(2,601),
	(2,701),
	(2,702),
	(2,703),
	(2,704),
	(2,705),
	(2,706),
	(2,707),
	(2,708),
	(2,709),
	(2,801),
	(2,802),
	(2,803),
	(2,804),
	(2,1001),
	(2,1002),
	(2,2101),
	(2,2102),
	(2,2103),
	(2,2104),
	(2,2105),
	(2,2106),
	(2,2107),
	(2,2201),
	(2,2202),
	(2,2203),
	(2,2204),
	(2,2205),
	(2,2301),
	(2,2302),
	(2,2303),
	(2,2304),
	(2,2401),
	(2,2402),
	(2,2403),
	(2,2404),
	(2,2501),
	(2,2502),
	(2,2503),
	(2,2504),
	(2,2511),
	(2,2512),
	(2,2513),
	(2,2514),
	(2,2601),
	(2,2701),
	(2,2702),
	(2,2703),
	(2,2704),
	(2,2705),
	(2,2801),
	(2,2802),
	(2,2803),
	(2,2804),
	(2,2805),
	(2,2806),
	(2,2807),
	(2,2808),
	(2,2809),
	(2,2810),
	(2,2811),
	(2,2812),
	(2,2813),
	(2,2814),
	(2,2815),
	(2,2816),
	(2,2817),
	(2,2818),
	(2,2819),
	(2,2820),
	(4,1),
	(4,210),
	(4,220),
	(4,2101),
	(4,2102),
	(4,2103),
	(4,2104),
	(4,2105),
	(4,2106),
	(4,2107),
	(4,2201),
	(4,2202),
	(4,2203),
	(4,2204),
	(4,2205),
	(5,1),
	(5,210),
	(5,220),
	(5,2101),
	(5,2102),
	(5,2103),
	(5,2104),
	(5,2105),
	(5,2106),
	(5,2107),
	(5,2201),
	(5,2202),
	(5,2203),
	(5,2204),
	(5,2205),
	(6,1),
	(6,210),
	(6,220),
	(6,2101),
	(6,2102),
	(6,2103),
	(6,2104),
	(6,2105),
	(6,2106),
	(6,2107),
	(6,2201),
	(6,2202),
	(6,2203),
	(6,2204),
	(6,2205),
	(7,1),
	(7,210),
	(7,220),
	(7,2101),
	(7,2102),
	(7,2103),
	(7,2104),
	(7,2105),
	(7,2106),
	(7,2107),
	(7,2201),
	(7,2202),
	(7,2203),
	(7,2204),
	(7,2205);

/*!40000 ALTER TABLE `sys_role_menu` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(64) DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(64) DEFAULT NULL COMMENT '昵称',
  `gender` tinyint(1) DEFAULT '1' COMMENT '性别((1-男 2-女 0-保密)',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `dept_id` int DEFAULT NULL COMMENT '部门ID',
  `avatar` varchar(255) DEFAULT NULL COMMENT '用户头像',
  `mobile` varchar(20) DEFAULT NULL COMMENT '联系方式',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态(1-正常 0-禁用)',
  `email` varchar(128) DEFAULT NULL COMMENT '用户邮箱',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint DEFAULT NULL COMMENT '创建人ID',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint DEFAULT NULL COMMENT '修改人ID',
  `is_deleted` tinyint(1) DEFAULT '0' COMMENT '逻辑删除标识(0-未删除 1-已删除)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统用户表';

LOCK TABLES `sys_user` WRITE;
/*!40000 ALTER TABLE `sys_user` DISABLE KEYS */;

INSERT INTO `sys_user` (`id`, `username`, `nickname`, `gender`, `password`, `dept_id`, `avatar`, `mobile`, `status`, `email`, `create_time`, `create_by`, `update_time`, `update_by`, `is_deleted`)
VALUES
	(1,'rootroot','有来技术',0,'$2a$10$xVWsNOhHrCxh5UbpCE7/HuJ.PAOKcYAqRxD2CO2nVnJS.IAXkr5aq',NULL,'https://foruda.gitee.com/images/1723603502796844527/03cdca2a_716974.gif','18812345677',1,'youlaitech@163.com','2026-03-31 11:17:06',NULL,'2026-03-31 11:17:06',NULL,0),
	(2,'admin','系统管理员',1,'$2a$10$xVWsNOhHrCxh5UbpCE7/HuJ.PAOKcYAqRxD2CO2nVnJS.IAXkr5aq',1,'/20260402/c7fce521-7b11-44db-a220-e788a8680837.jpg','18827633950',1,'258775519@qq.com','2026-03-31 11:17:06',NULL,'2026-04-02 01:01:15',2,0);

/*!40000 ALTER TABLE `sys_user` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_user_notice
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user_notice`;

CREATE TABLE `sys_user_notice` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
  `notice_id` bigint NOT NULL COMMENT '公共通知id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `is_read` tinyint DEFAULT '0' COMMENT '读取状态（0: 未读, 1: 已读）',
  `read_time` datetime DEFAULT NULL COMMENT '阅读时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint DEFAULT '0' COMMENT '逻辑删除(0: 未删除, 1: 已删除)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户通知公告关联表';

LOCK TABLES `sys_user_notice` WRITE;
/*!40000 ALTER TABLE `sys_user_notice` DISABLE KEYS */;

INSERT INTO `sys_user_notice` (`id`, `notice_id`, `user_id`, `is_read`, `read_time`, `create_time`, `update_time`, `is_deleted`)
VALUES
	(1,1,2,1,NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',0),
	(2,2,2,1,NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',0),
	(3,3,2,1,NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',0),
	(4,4,2,1,NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',0),
	(5,5,2,1,NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',0),
	(6,6,2,1,NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',0),
	(7,7,2,1,NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',0),
	(8,8,2,1,NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',0),
	(9,9,2,1,NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',0),
	(10,10,2,1,NULL,'2026-03-31 11:17:06','2026-03-31 11:17:06',0);

/*!40000 ALTER TABLE `sys_user_notice` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_user_role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user_role`;

CREATE TABLE `sys_user_role` (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户角色关联表';

LOCK TABLES `sys_user_role` WRITE;
/*!40000 ALTER TABLE `sys_user_role` DISABLE KEYS */;

INSERT INTO `sys_user_role` (`user_id`, `role_id`)
VALUES
	(1,1),
	(2,2);

/*!40000 ALTER TABLE `sys_user_role` ENABLE KEYS */;
UNLOCK TABLES;


# 转储表 sys_user_social
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sys_user_social`;

CREATE TABLE `sys_user_social` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `platform` varchar(20) NOT NULL COMMENT '平台类型(WECHAT_MINI/WECHAT_MP/ALIPAY/QQ/APPLE)',
  `openid` varchar(64) NOT NULL COMMENT '平台openid',
  `unionid` varchar(64) DEFAULT NULL COMMENT '微信unionid',
  `nickname` varchar(64) DEFAULT NULL COMMENT '第三方昵称',
  `avatar` varchar(255) DEFAULT NULL COMMENT '第三方头像URL',
  `session_key` varchar(128) DEFAULT NULL COMMENT '微信session_key',
  `verified` tinyint(1) DEFAULT '1' COMMENT '是否已验证(1-已验证 0-未验证)',
  `create_time` datetime DEFAULT NULL COMMENT '绑定时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_platform_openid` (`platform`,`openid`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_unionid` (`unionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户第三方账号绑定表';




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
