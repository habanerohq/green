# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: localhost (MySQL 5.1.39-log)
# Database: inspiritive
# Generation Time: 2012-07-09 13:00:36 +1000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table cellar_items
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cellar_items`;

CREATE TABLE `cellar_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `record_id` int(11) DEFAULT NULL,
  `record_type` varchar(255) DEFAULT NULL,
  `item` text,
  `pantry_type` varchar(255) DEFAULT NULL,
  `stacked_at` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table cellar_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cellar_migrations`;

CREATE TABLE `cellar_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `index_cellar_migrations_on_version` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table habanero_beds
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_beds`;

CREATE TABLE `habanero_beds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `span` int(11) DEFAULT NULL,
  `offset` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `layout_id` int(11) DEFAULT NULL,
  `row_id` int(11) DEFAULT NULL,
  `row_position` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_habanero_beds_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_beds` WRITE;
/*!40000 ALTER TABLE `habanero_beds` DISABLE KEYS */;

INSERT INTO `habanero_beds` (`id`, `span`, `offset`, `name`, `layout_id`, `row_id`, `row_position`, `slug`)
VALUES
	(1,12,NULL,'Top',1,1,7,'top'),
	(2,12,NULL,'Header',1,1,8,'header'),
	(3,12,NULL,'Content Top',1,1,9,'content-top'),
	(4,3,NULL,'Sidebar',1,2,14,'sidebar'),
	(5,9,NULL,'Content',1,2,8,'content'),
	(6,12,NULL,'Footer',1,3,7,'footer'),
	(7,12,NULL,'Content Bottom',2,3,5,'content-bottom'),
	(8,12,NULL,'Top',2,4,1,'top--2'),
	(9,12,NULL,'Header',2,4,2,'header--2'),
	(10,12,NULL,'Content Top',2,4,3,'content-top--2'),
	(11,3,NULL,'Left',2,5,1,'left'),
	(12,6,NULL,'Content',2,5,2,'content--2'),
	(13,12,NULL,'Footer',2,6,2,'footer--2'),
	(14,3,NULL,'Right',2,5,3,'right'),
	(15,12,NULL,'Top',3,7,1,'top--3'),
	(16,12,NULL,'Header',3,7,2,'header--3'),
	(17,12,NULL,'Content Top',3,8,1,'content-top--3'),
	(18,8,NULL,'Content',3,8,2,'content--3'),
	(19,4,NULL,'Sidebar',3,8,3,'sidebar--2'),
	(20,12,NULL,'Content Bottom',3,8,4,'content-bottom--2'),
	(21,12,NULL,'Footer',3,9,1,'footer--3');

/*!40000 ALTER TABLE `habanero_beds` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_brands
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_brands`;

CREATE TABLE `habanero_brands` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `documentation` text,
  PRIMARY KEY (`id`),
  KEY `index_habanero_brands_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_brands` WRITE;
/*!40000 ALTER TABLE `habanero_brands` DISABLE KEYS */;

INSERT INTO `habanero_brands` (`id`, `name`, `slug`, `documentation`)
VALUES
	(1,'ActiveRecord','activerecord','<p>Technical database stuff.</p>'),
	(2,'Habanero','habanero','<p>This brand contains most of the stuff needed to get Green working.</p>'),
	(3,'Tabasco','tabasco','<p>Allows the upload of images, grouped into any number of galleries.</p>');

/*!40000 ALTER TABLE `habanero_brands` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_categories`;

CREATE TABLE `habanero_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `abbreviation` varchar(255) DEFAULT NULL,
  `strategy` text,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_habanero_categories_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_categories` WRITE;
/*!40000 ALTER TABLE `habanero_categories` DISABLE KEYS */;

INSERT INTO `habanero_categories` (`id`, `abbreviation`, `strategy`, `name`, `parent_id`, `lft`, `rgt`, `brand_id`, `slug`)
VALUES
	(1,NULL,NULL,'Scene Category',NULL,1,4,2,'scene-category'),
	(2,NULL,NULL,'Basic administration',1,2,3,2,'basic-administration'),
	(3,NULL,NULL,'Variety category',NULL,5,10,2,'variety-category'),
	(4,NULL,NULL,'Basic trait',3,6,7,2,'basic-trait'),
	(5,NULL,NULL,'Highlighter Category',NULL,11,14,2,'highlighter-category'),
	(6,NULL,NULL,'Primary',5,12,13,2,'primary'),
	(7,NULL,NULL,'Condition Predicate',NULL,15,36,2,'condition-predicate'),
	(8,'eq',NULL,'equals',7,16,17,2,'equals'),
	(9,'matches',NULL,'matches',7,18,19,2,'matches'),
	(10,'not_eq',NULL,'does not equal',7,20,21,2,'does-not-equal'),
	(11,'does_not_match',NULL,'does not match',7,22,23,2,'does-not-match'),
	(12,'lt',NULL,'is less than',7,24,25,2,'is-less-than'),
	(13,'lteq',NULL,'is not greater than',7,26,27,2,'is-not-greater-than'),
	(14,'gt',NULL,'is greater than',7,28,29,2,'is-greater-than'),
	(15,'gteq',NULL,'is not less than',7,30,31,2,'is-not-less-than'),
	(16,'in',NULL,'is included in',7,32,33,2,'is-included-in'),
	(17,'not_in',NULL,'is not included in',7,34,35,2,'is-not-included-in'),
	(18,NULL,NULL,'Content Processing Options',NULL,37,44,2,'content-processing-options'),
	(19,'markdown',NULL,'Markdown',18,38,39,2,'markdown'),
	(20,'wysiwym',NULL,'What you see is what you mean',18,40,41,2,'what-you-see-is-what-you-mean'),
	(21,'html',NULL,'HTML',18,42,43,2,'html'),
	(22,NULL,NULL,'Theme Trait',3,8,9,2,'theme-trait'),
	(23,NULL,'<p>A method of classifying image galleries</p>','Gallery Category',NULL,45,48,3,'gallery-category'),
	(24,NULL,NULL,'Site Assets',23,46,47,3,'site-assets');

/*!40000 ALTER TABLE `habanero_categories` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_conditions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_conditions`;

CREATE TABLE `habanero_conditions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) DEFAULT NULL,
  `trait_id` int(11) DEFAULT NULL,
  `grader_id` int(11) DEFAULT NULL,
  `grader_position` int(11) DEFAULT NULL,
  `predicate_id` int(11) DEFAULT NULL,
  `predicate2_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_conditions` WRITE;
/*!40000 ALTER TABLE `habanero_conditions` DISABLE KEYS */;

INSERT INTO `habanero_conditions` (`id`, `value`, `trait_id`, `grader_id`, `grader_position`, `predicate_id`, `predicate2_id`)
VALUES
	(1,'Shed',57,2,1,9,NULL),
	(2,'Workplaces',145,8,1,8,NULL),
	(3,'landing',145,9,1,8,NULL),
	(4,'Home',57,9,2,10,NULL);

/*!40000 ALTER TABLE `habanero_conditions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_feature_placements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_feature_placements`;

CREATE TABLE `habanero_feature_placements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template` varchar(255) DEFAULT NULL,
  `no_html` tinyint(1) DEFAULT NULL,
  `paginate` tinyint(1) DEFAULT NULL,
  `span` int(11) DEFAULT NULL,
  `feature_id` int(11) DEFAULT NULL,
  `scene_id` int(11) DEFAULT NULL,
  `bed_id` int(11) DEFAULT NULL,
  `bed_position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_feature_placements` WRITE;
/*!40000 ALTER TABLE `habanero_feature_placements` DISABLE KEYS */;

INSERT INTO `habanero_feature_placements` (`id`, `template`, `no_html`, `paginate`, `span`, `feature_id`, `scene_id`, `bed_id`, `bed_position`)
VALUES
	(1,'site',NULL,NULL,NULL,4,1,15,50),
	(2,'grid',NULL,NULL,NULL,2,3,12,1),
	(3,'search',NULL,NULL,NULL,2,3,11,4),
	(4,'site',NULL,NULL,NULL,4,3,8,52),
	(5,'site',NULL,NULL,NULL,4,6,8,7),
	(6,'site',NULL,NULL,NULL,4,2,8,8),
	(7,'site',NULL,NULL,NULL,4,5,8,9),
	(8,'site',NULL,NULL,NULL,4,4,8,11),
	(9,'site',NULL,NULL,NULL,4,7,8,46),
	(10,'around_here',NULL,NULL,NULL,4,7,8,2),
	(11,'around_here',NULL,NULL,NULL,4,3,8,3),
	(12,'around_here',NULL,NULL,NULL,4,6,8,4),
	(13,'around_here',NULL,NULL,NULL,4,2,8,32),
	(14,'around_here',NULL,NULL,NULL,4,5,8,10),
	(15,'around_here',NULL,NULL,NULL,4,4,8,13),
	(16,'site',NULL,NULL,NULL,4,8,8,31),
	(17,'around_here',NULL,NULL,NULL,4,8,8,22),
	(18,'connections',NULL,NULL,NULL,1,9,4,36),
	(19,'show',NULL,NULL,NULL,6,1,18,1),
	(20,'plan',NULL,NULL,NULL,7,11,12,7),
	(21,'site',NULL,NULL,NULL,4,11,8,39),
	(22,'around_here',NULL,NULL,NULL,4,11,10,38),
	(23,'edit',NULL,NULL,NULL,8,12,5,13),
	(24,'new',NULL,NULL,NULL,8,13,5,14),
	(25,'new',NULL,NULL,NULL,1,14,5,4),
	(26,'edit',NULL,NULL,NULL,1,16,5,7),
	(27,'grid',NULL,1,NULL,9,10,12,10),
	(28,'search',NULL,NULL,NULL,9,10,11,45),
	(29,'grid',NULL,1,NULL,16,4,12,4),
	(30,'search',NULL,NULL,NULL,16,4,11,1),
	(31,'grid',NULL,1,NULL,17,5,12,2),
	(32,'search',NULL,NULL,NULL,17,5,11,2),
	(33,'grid',NULL,1,NULL,18,6,12,3),
	(34,'search',NULL,NULL,NULL,18,6,11,3),
	(35,'grid',NULL,1,NULL,19,2,12,23),
	(36,'search',NULL,NULL,NULL,19,2,11,7),
	(37,'trellis',NULL,NULL,NULL,11,8,14,48),
	(38,'grid',NULL,1,NULL,20,8,12,25),
	(39,'search',NULL,NULL,NULL,20,8,11,8),
	(40,'site',NULL,NULL,NULL,4,17,1,10),
	(41,'site',NULL,NULL,NULL,4,18,8,12),
	(42,'site',NULL,NULL,NULL,4,19,8,14),
	(43,'navigation',NULL,NULL,NULL,5,17,1,15),
	(44,'show',NULL,NULL,NULL,15,15,5,5),
	(45,'navigation',NULL,NULL,NULL,5,18,1,1),
	(46,'navigation',NULL,NULL,NULL,5,19,1,2),
	(47,'grid',NULL,NULL,NULL,21,1,19,26),
	(48,'grid',NULL,NULL,NULL,22,1,19,27),
	(49,'grid',NULL,NULL,NULL,23,3,14,26),
	(50,'grid',NULL,NULL,NULL,22,4,14,47),
	(51,'show',NULL,NULL,NULL,15,11,11,36),
	(52,'connections',NULL,NULL,NULL,15,11,11,37),
	(53,'site',NULL,NULL,NULL,4,20,8,41),
	(54,'around_here',NULL,NULL,NULL,4,20,10,42),
	(55,'show',NULL,NULL,NULL,15,20,11,41),
	(56,'connections',NULL,NULL,NULL,15,20,11,42),
	(57,'thumbs',NULL,1,NULL,24,20,12,29),
	(58,'site',NULL,NULL,NULL,4,21,8,42),
	(59,'around_here',NULL,NULL,NULL,4,21,10,43),
	(60,'grid',NULL,1,NULL,25,21,12,30),
	(61,'search',NULL,NULL,NULL,25,21,11,43);

/*!40000 ALTER TABLE `habanero_feature_placements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_features
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_features`;

CREATE TABLE `habanero_features` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `template` varchar(255) DEFAULT NULL,
  `no_html` tinyint(1) DEFAULT NULL,
  `paginate` tinyint(1) DEFAULT NULL,
  `columns` int(11) DEFAULT NULL,
  `span` int(11) DEFAULT NULL,
  `body` text,
  `documentation` text,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `grader_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `variety_id` int(11) DEFAULT NULL,
  `scene_id` int(11) DEFAULT NULL,
  `highlighter_id` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `body_format_id` int(11) DEFAULT NULL,
  `picture_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_habanero_features_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_features` WRITE;
/*!40000 ALTER TABLE `habanero_features` DISABLE KEYS */;

INSERT INTO `habanero_features` (`id`, `type`, `title`, `template`, `no_html`, `paginate`, `columns`, `span`, `body`, `documentation`, `name`, `parent_id`, `lft`, `rgt`, `grader_id`, `brand_id`, `variety_id`, `scene_id`, `highlighter_id`, `slug`, `body_format_id`, `picture_id`)
VALUES
	(1,'Habanero::VarietyFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Edit Variety',NULL,1,2,NULL,2,NULL,NULL,NULL,'edit-variety',NULL,NULL),
	(2,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'Scene Grid',NULL,3,4,1,2,NULL,11,16,'scene-grid',NULL,NULL),
	(3,'Habanero::CollectiveSceneFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Top Gardens',NULL,5,6,7,2,NULL,NULL,NULL,'top-gardens',NULL,NULL),
	(4,'Habanero::NavigationFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Navigation',NULL,7,8,NULL,2,NULL,NULL,NULL,'navigation',NULL,NULL),
	(5,'Habanero::CollectiveSceneFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Green workplaces',NULL,9,10,8,2,NULL,NULL,NULL,'green-workplaces',NULL,NULL),
	(6,'Habanero::ContentFeature','Generating new shoots across the web',NULL,NULL,NULL,NULL,NULL,'<p>Some getting started copy goes here.</p>',NULL,'Green welcome',NULL,11,12,NULL,2,NULL,NULL,NULL,'green-welcome',NULL,NULL),
	(7,'Habanero::ScenicFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Scene Arranger',NULL,13,14,NULL,2,24,NULL,NULL,'scene-arranger',NULL,NULL),
	(8,'Habanero::HighlightingFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Edit Highlighter',NULL,15,16,NULL,2,30,12,23,'edit-highlighter',NULL,NULL),
	(9,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Grid',NULL,17,18,NULL,2,NULL,15,NULL,'grid',NULL,NULL),
	(10,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Layout trellis',NULL,19,20,NULL,2,NULL,17,6,'layout-trellis',NULL,NULL),
	(11,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Site Trellis',NULL,21,22,NULL,2,NULL,17,9,'site-trellis',NULL,NULL),
	(12,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Feature Trellis',NULL,23,24,NULL,2,NULL,17,12,'feature-trellis',NULL,NULL),
	(13,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Variety Trellis',NULL,25,26,NULL,2,NULL,17,13,'variety-trellis',NULL,NULL),
	(14,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Category Trellis',NULL,27,28,NULL,2,NULL,17,1,'category-trellis',NULL,NULL),
	(15,'Habanero::VarietyFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Show Variety',NULL,29,30,NULL,2,NULL,17,NULL,'show-variety',NULL,NULL),
	(16,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'Variety Grid',NULL,31,32,3,2,NULL,17,17,'variety-grid',NULL,NULL),
	(17,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'Feature grid',NULL,33,34,5,2,NULL,17,18,'feature-grid',NULL,NULL),
	(18,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'Category grid',NULL,35,36,6,2,NULL,17,19,'category-grid',NULL,NULL),
	(19,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Layout grid',NULL,37,38,NULL,2,11,17,NULL,'layout-grid',NULL,NULL),
	(20,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'Garden placement grid',NULL,39,40,NULL,2,43,17,NULL,'garden-placement-grid',NULL,NULL),
	(21,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sites',NULL,41,42,NULL,2,21,17,NULL,'sites',NULL,NULL),
	(22,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Brands',NULL,43,44,NULL,2,8,17,NULL,'brands',NULL,NULL),
	(23,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Gardens',NULL,45,46,NULL,2,23,17,50,'gardens',NULL,NULL),
	(24,'Tabasco::GalleriaFeature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Gallery',NULL,47,48,NULL,3,55,20,NULL,'gallery',NULL,NULL),
	(25,'Habanero::CollectiveVarietyFeature',NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,'Gallery grid',NULL,49,50,NULL,3,52,21,NULL,'gallery-grid',NULL,NULL);

/*!40000 ALTER TABLE `habanero_features` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_garden_placements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_garden_placements`;

CREATE TABLE `habanero_garden_placements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `site_id` int(11) DEFAULT NULL,
  `site_position` int(11) DEFAULT NULL,
  `garden_id` int(11) DEFAULT NULL,
  `theme_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table habanero_gardens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_gardens`;

CREATE TABLE `habanero_gardens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `theme_id` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `signpost` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_habanero_gardens_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_gardens` WRITE;
/*!40000 ALTER TABLE `habanero_gardens` DISABLE KEYS */;

INSERT INTO `habanero_gardens` (`id`, `name`, `parent_id`, `lft`, `rgt`, `template_id`, `target_id`, `brand_id`, `theme_id`, `slug`, `signpost`)
VALUES
	(1,'Green',NULL,1,12,NULL,NULL,2,NULL,'green','/green'),
	(2,'Workplaces',1,2,3,NULL,NULL,2,NULL,'workplaces','/workplaces'),
	(3,'Variety',1,4,5,NULL,NULL,2,NULL,'variety','/variety'),
	(4,'Templates',NULL,13,14,NULL,NULL,2,NULL,'templates',NULL),
	(5,'Scene',1,6,7,NULL,NULL,2,NULL,'scene','/scene'),
	(6,'Highlight',1,8,9,NULL,NULL,2,NULL,'highlight','/highlight'),
	(7,'Gallery',1,10,11,NULL,52,3,NULL,'gallery','/gallery'),
	(8,'Galleries',NULL,15,16,NULL,NULL,3,NULL,'galleries','/galleries');

/*!40000 ALTER TABLE `habanero_gardens` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_graders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_graders`;

CREATE TABLE `habanero_graders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `variety_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_graders` WRITE;
/*!40000 ALTER TABLE `habanero_graders` DISABLE KEYS */;

INSERT INTO `habanero_graders` (`id`, `name`, `variety_id`)
VALUES
	(1,'All Scenes',24),
	(2,'All sheds',24),
	(3,'All varieties',7),
	(4,'All feature',25),
	(5,'All features',25),
	(6,'All categories',32),
	(7,'Top Gardens',23),
	(8,'Green workplaces',24),
	(9,'Landing pages',24);

/*!40000 ALTER TABLE `habanero_graders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_highlighters
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_highlighters`;

CREATE TABLE `habanero_highlighters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `primary` tinyint(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `variety_id` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_habanero_highlighters_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_highlighters` WRITE;
/*!40000 ALTER TABLE `habanero_highlighters` DISABLE KEYS */;

INSERT INTO `habanero_highlighters` (`id`, `primary`, `name`, `parent_id`, `lft`, `rgt`, `variety_id`, `slug`, `category_id`)
VALUES
	(1,NULL,'Category Trellis Highlighter',NULL,1,2,32,'category-trellis-highlighter',NULL),
	(2,NULL,'Category Document Highlighter',NULL,3,4,32,'category-document-highlighter',NULL),
	(3,NULL,'Layout Highlighter',NULL,5,6,11,'layout-highlighter',NULL),
	(4,NULL,'Layout Row Highlighter',NULL,7,8,35,'layout-row-highlighter',NULL),
	(5,NULL,'Bed Highlighter',NULL,9,10,29,'bed-highlighter',NULL),
	(6,NULL,'Layout Trellis Highlighter',NULL,11,14,11,'layout-trellis-highlighter',NULL),
	(7,NULL,'Layout Row Trellis Highlighter',6,12,13,35,'layout-row-trellis-highlighter',NULL),
	(8,NULL,'Bed Trellis Highlighter',NULL,15,16,29,'bed-trellis-highlighter',NULL),
	(9,NULL,'Site Trellis Highlighter',NULL,17,18,21,'site-trellis-highlighter',NULL),
	(10,NULL,'Garden Trellis Highlighter',NULL,19,20,23,'garden-trellis-highlighter',NULL),
	(11,NULL,'Scene Trellis Highlighter',NULL,21,22,24,'scene-trellis-highlighter',NULL),
	(12,NULL,'Feature Trellis Highlighter',NULL,23,24,25,'feature-trellis-highlighter',NULL),
	(13,NULL,'Brand Trellis Highlighter',NULL,25,26,8,'brand-trellis-highlighter',NULL),
	(14,NULL,'Variety Trellis Highlighter',NULL,27,28,7,'variety-trellis-highlighter',NULL),
	(15,NULL,'Highlighter Trellis Highlighter',NULL,29,30,30,'highlighter-trellis-highlighter',NULL),
	(16,NULL,'Scene Grid Columns',NULL,31,32,24,'scene-grid-columns',NULL),
	(17,NULL,'Variety Grid Columns',NULL,33,34,7,'variety-grid-columns',NULL),
	(18,NULL,'Feature grid columns',NULL,35,36,25,'feature-grid-columns',NULL),
	(19,NULL,'Category grid columns',NULL,37,38,32,'category-grid-columns',NULL),
	(20,1,'Scene document',NULL,39,40,24,'scene-document',NULL),
	(21,1,'Garden document',NULL,41,42,23,'garden-document',NULL),
	(22,1,'Site document',NULL,43,44,21,'site-document',NULL),
	(23,1,'Highlighter document',NULL,45,46,30,'highlighter-document',NULL),
	(24,1,'Layout document',NULL,47,48,11,'layout-document',NULL),
	(25,1,'Layout row document',NULL,49,50,35,'layout-row-document',NULL),
	(26,1,'Bed document',NULL,51,52,29,'bed-document',NULL),
	(27,1,'Brand document',NULL,53,54,8,'brand-document',NULL),
	(28,1,'Variety document',NULL,55,56,7,'variety-document',NULL),
	(29,1,'Variety feature document',NULL,57,58,27,'variety-feature-document',NULL),
	(30,1,'Collective variety feature document',NULL,59,60,37,'collective-variety-feature-document',NULL),
	(31,1,'Content feature document',NULL,61,62,26,'content-feature-document',NULL),
	(32,1,'Collective scene feature document',NULL,63,64,44,'collective-scene-feature-document',NULL),
	(33,1,'Category document',NULL,65,66,32,'category-document',NULL),
	(34,1,'Association trait document',NULL,67,68,19,'association-trait-document',NULL),
	(35,1,'Blob trait document',NULL,69,70,9,'blob-trait-document',NULL),
	(36,1,'Category trait document',NULL,71,72,34,'category-trait-document',NULL),
	(37,1,'Date trait document',NULL,73,74,12,'date-trait-document',NULL),
	(38,1,'Trait document',NULL,75,76,2,'trait-document',NULL),
	(39,1,'Name trait document',NULL,77,78,40,'name-trait-document',NULL),
	(40,1,'Nest trait document',NULL,79,80,22,'nest-trait-document',NULL),
	(41,1,'Relation trait document',NULL,81,82,18,'relation-trait-document',NULL),
	(42,1,'Signpost trait document',NULL,83,84,33,'signpost-trait-document',NULL),
	(43,1,'Slug trait document',NULL,85,86,36,'slug-trait-document',NULL),
	(44,1,'String trait document',NULL,87,88,3,'string-trait-document',NULL),
	(45,1,'Text trait document',NULL,89,90,6,'text-trait-document',NULL),
	(46,1,'True false trait document',NULL,91,92,5,'true-false-trait-document',NULL),
	(47,1,'Range trait document',NULL,93,94,20,'range-trait-document',6),
	(48,1,'Tag trait document',NULL,95,96,42,'tag-trait-document',NULL),
	(49,1,'Condition document',NULL,97,98,39,'condition-document',6),
	(50,NULL,'Garden grid narrow',NULL,99,100,23,'garden-grid-narrow',NULL),
	(51,1,'Picture feature document',NULL,101,102,56,'picture-feature-document',NULL);

/*!40000 ALTER TABLE `habanero_highlighters` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_layout_rows
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_layout_rows`;

CREATE TABLE `habanero_layout_rows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fluid` tinyint(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `layout_id` int(11) DEFAULT NULL,
  `layout_position` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_habanero_layout_rows_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_layout_rows` WRITE;
/*!40000 ALTER TABLE `habanero_layout_rows` DISABLE KEYS */;

INSERT INTO `habanero_layout_rows` (`id`, `fluid`, `name`, `layout_id`, `layout_position`, `slug`)
VALUES
	(1,NULL,'Header',1,1,'header'),
	(2,NULL,'Body',1,2,'body'),
	(3,NULL,'Footer',1,3,'footer'),
	(4,1,'Header',2,1,'header--2'),
	(5,1,'Body',2,2,'body--2'),
	(6,NULL,'Footer',2,3,'footer--2'),
	(7,NULL,'Header',3,1,'header--3'),
	(8,NULL,'Body',3,2,'body--3'),
	(9,NULL,'Footer',3,3,'footer--3');

/*!40000 ALTER TABLE `habanero_layout_rows` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_layouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_layouts`;

CREATE TABLE `habanero_layouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `template_name` varchar(255) DEFAULT NULL,
  `fluid` tinyint(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_habanero_layouts_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_layouts` WRITE;
/*!40000 ALTER TABLE `habanero_layouts` DISABLE KEYS */;

INSERT INTO `habanero_layouts` (`id`, `template_name`, `fluid`, `name`, `brand_id`, `slug`)
VALUES
	(1,NULL,NULL,'Habanero',2,'habanero'),
	(2,'habanero',1,'Green workplace',2,'green-workplace'),
	(3,'habanero',NULL,'Side bar right',2,'side-bar-right');

/*!40000 ALTER TABLE `habanero_layouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_scenes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_scenes`;

CREATE TABLE `habanero_scenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `layout_id` int(11) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  `garden_id` int(11) DEFAULT NULL,
  `garden_position` int(11) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `next_scene_id` int(11) DEFAULT NULL,
  `theme_id` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `signpost` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_habanero_scenes_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_scenes` WRITE;
/*!40000 ALTER TABLE `habanero_scenes` DISABLE KEYS */;

INSERT INTO `habanero_scenes` (`id`, `name`, `layout_id`, `template_id`, `garden_id`, `garden_position`, `target_id`, `next_scene_id`, `theme_id`, `slug`, `signpost`, `category_id`)
VALUES
	(1,'Index',3,NULL,1,1,NULL,NULL,NULL,'index','/',2),
	(2,'Scene Layout Board',2,NULL,2,5,11,NULL,NULL,'scene-layout-board','/layouts',NULL),
	(3,'Garden design office',2,NULL,2,6,21,NULL,NULL,'garden-design-office','/design-office',NULL),
	(4,'Nursery',2,NULL,2,7,7,NULL,NULL,'nursery','/nursery',NULL),
	(5,'Feature Shed',2,NULL,2,8,25,NULL,NULL,'feature-shed','/features',NULL),
	(6,'Category Book',2,NULL,2,9,32,NULL,NULL,'category-book','/categories',NULL),
	(7,'Index',2,NULL,2,10,NULL,NULL,NULL,'index','/',2),
	(8,'Site construction',2,NULL,2,1,43,NULL,NULL,'site-construction','/sites',NULL),
	(9,'Acid',1,NULL,4,7,NULL,NULL,NULL,'acid',NULL,2),
	(10,'Search',2,NULL,4,8,NULL,NULL,NULL,'search',NULL,2),
	(11,'Scene',2,NULL,5,1,24,NULL,NULL,'scene','/:variety_type/:id',NULL),
	(12,'Edit Highlighter',1,NULL,6,13,30,NULL,NULL,'edit-highlighter','/:variety_type/:id/edit',NULL),
	(13,'Create Highlighter',1,NULL,6,14,30,12,NULL,'create-highlighter','/:variety_type/new',NULL),
	(14,'Creater',NULL,9,4,1,NULL,NULL,NULL,'creater',NULL,2),
	(15,'Shower',NULL,9,4,2,NULL,NULL,NULL,'shower',NULL,2),
	(16,'Editer',NULL,9,4,3,NULL,NULL,NULL,'editer',NULL,2),
	(17,'Show Variety',NULL,15,3,12,7,NULL,NULL,'show-variety','/:variety_type/:id',NULL),
	(18,'Edit Variety',1,16,3,13,7,NULL,NULL,'edit-variety','/:variety_type/:id/edit',NULL),
	(19,'Create Variety',NULL,14,3,6,7,NULL,NULL,'create-variety','/:variety_type/new',NULL),
	(20,'Gallery',2,NULL,7,1,52,NULL,NULL,'gallery','/:variety_type/:id',NULL),
	(21,'Gallery design board',2,NULL,8,1,52,NULL,NULL,'gallery-design-board','/',NULL);

/*!40000 ALTER TABLE `habanero_scenes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_sites`;

CREATE TABLE `habanero_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `host` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `root_scene_id` int(11) DEFAULT NULL,
  `theme_id` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_habanero_sites_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table habanero_themes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_themes`;

CREATE TABLE `habanero_themes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sans_font_family` varchar(255) DEFAULT NULL,
  `serif_font_family` varchar(255) DEFAULT NULL,
  `mono_font_family` varchar(255) DEFAULT NULL,
  `alt_font_family` varchar(255) DEFAULT NULL,
  `headings_font_family` varchar(255) DEFAULT NULL,
  `headings_font_weight` varchar(255) DEFAULT NULL,
  `grid_columns` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `body_background` varchar(255) DEFAULT NULL,
  `text_color` varchar(255) DEFAULT NULL,
  `link_color` varchar(255) DEFAULT NULL,
  `link_color_hover` varchar(255) DEFAULT NULL,
  `hero_unit_heading_color` varchar(255) DEFAULT NULL,
  `hero_unit_lead_color` varchar(255) DEFAULT NULL,
  `table_background` varchar(255) DEFAULT NULL,
  `table_background_accent` varchar(255) DEFAULT NULL,
  `table_background_hover` varchar(255) DEFAULT NULL,
  `table_border` varchar(255) DEFAULT NULL,
  `navbar_background` varchar(255) DEFAULT NULL,
  `navbar_background_highlight` varchar(255) DEFAULT NULL,
  `navbar_text` varchar(255) DEFAULT NULL,
  `navbar_brand_color` varchar(255) DEFAULT NULL,
  `navbar_link_color` varchar(255) DEFAULT NULL,
  `navbar_link_color_hover` varchar(255) DEFAULT NULL,
  `navbar_link_color_active` varchar(255) DEFAULT NULL,
  `navbar_search_background` varchar(255) DEFAULT NULL,
  `navbar_search_background_focus` varchar(255) DEFAULT NULL,
  `navbar_search_border` varchar(255) DEFAULT NULL,
  `navbar_search_placeholder_color` varchar(255) DEFAULT NULL,
  `dropdown_background` varchar(255) DEFAULT NULL,
  `dropdown_border` varchar(255) DEFAULT NULL,
  `dropdown_link_color` varchar(255) DEFAULT NULL,
  `dropdown_link_color_hover` varchar(255) DEFAULT NULL,
  `dropdown_link_color_background_hover` varchar(255) DEFAULT NULL,
  `placeholder_text` varchar(255) DEFAULT NULL,
  `input_background` varchar(255) DEFAULT NULL,
  `input_border` varchar(255) DEFAULT NULL,
  `input_disabled_background` varchar(255) DEFAULT NULL,
  `form_actions_background` varchar(255) DEFAULT NULL,
  `btn_primary_background` varchar(255) DEFAULT NULL,
  `btn_primary_background_highlight` varchar(255) DEFAULT NULL,
  `warning_text` varchar(255) DEFAULT NULL,
  `warning_background` varchar(255) DEFAULT NULL,
  `error_text` varchar(255) DEFAULT NULL,
  `error_background` varchar(255) DEFAULT NULL,
  `success_text` varchar(255) DEFAULT NULL,
  `success_background` varchar(255) DEFAULT NULL,
  `info_text` varchar(255) DEFAULT NULL,
  `info_background` varchar(255) DEFAULT NULL,
  `hero_unit_background` varchar(255) DEFAULT NULL,
  `grid_column_width` varchar(255) DEFAULT NULL,
  `grid_gutter_width` varchar(255) DEFAULT NULL,
  `fluid_grid_column_width` varchar(255) DEFAULT NULL,
  `fluid_grid_gutter_width` varchar(255) DEFAULT NULL,
  `base_font_size` varchar(255) DEFAULT NULL,
  `base_font_family` varchar(255) DEFAULT NULL,
  `base_line_height` varchar(255) DEFAULT NULL,
  `headings_color` varchar(255) DEFAULT NULL,
  `navbar_height` varchar(255) DEFAULT NULL,
  `input_border_radius` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_habanero_themes_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_themes` WRITE;
/*!40000 ALTER TABLE `habanero_themes` DISABLE KEYS */;

INSERT INTO `habanero_themes` (`id`, `sans_font_family`, `serif_font_family`, `mono_font_family`, `alt_font_family`, `headings_font_family`, `headings_font_weight`, `grid_columns`, `name`, `parent_id`, `lft`, `rgt`, `brand_id`, `slug`, `body_background`, `text_color`, `link_color`, `link_color_hover`, `hero_unit_heading_color`, `hero_unit_lead_color`, `table_background`, `table_background_accent`, `table_background_hover`, `table_border`, `navbar_background`, `navbar_background_highlight`, `navbar_text`, `navbar_brand_color`, `navbar_link_color`, `navbar_link_color_hover`, `navbar_link_color_active`, `navbar_search_background`, `navbar_search_background_focus`, `navbar_search_border`, `navbar_search_placeholder_color`, `dropdown_background`, `dropdown_border`, `dropdown_link_color`, `dropdown_link_color_hover`, `dropdown_link_color_background_hover`, `placeholder_text`, `input_background`, `input_border`, `input_disabled_background`, `form_actions_background`, `btn_primary_background`, `btn_primary_background_highlight`, `warning_text`, `warning_background`, `error_text`, `error_background`, `success_text`, `success_background`, `info_text`, `info_background`, `hero_unit_background`, `grid_column_width`, `grid_gutter_width`, `fluid_grid_column_width`, `fluid_grid_gutter_width`, `base_font_size`, `base_font_family`, `base_line_height`, `headings_color`, `navbar_height`, `input_border_radius`)
VALUES
	(1,NULL,NULL,NULL,'\"Helvetica Neue\", Helvetica, Arial, sans-serif','Rokkitt, Rockwell, Georgia, \"Times New Roman\", Times, serif',NULL,NULL,'Habanero',NULL,1,2,2,'habanero','#0e3d50',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'#042e48','#0d475f',NULL,NULL,'white',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'transparent',NULL,NULL,NULL,NULL,'14px','Georgia, \"Times New Roman\", Times, serif','22px',NULL,'76px',NULL);

/*!40000 ALTER TABLE `habanero_themes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_trait_highlights
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_trait_highlights`;

CREATE TABLE `habanero_trait_highlights` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `highlighter_id` int(11) DEFAULT NULL,
  `highlighter_position` int(11) DEFAULT NULL,
  `trait_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_trait_highlights` WRITE;
/*!40000 ALTER TABLE `habanero_trait_highlights` DISABLE KEYS */;

INSERT INTO `habanero_trait_highlights` (`id`, `highlighter_id`, `highlighter_position`, `trait_id`)
VALUES
	(1,2,1,62),
	(2,2,2,70),
	(3,2,3,11),
	(4,2,4,50),
	(5,3,1,62),
	(6,3,2,5),
	(7,3,3,31),
	(8,4,1,170),
	(9,4,2,62),
	(10,4,3,31),
	(11,5,1,170),
	(12,5,2,161),
	(13,5,3,62),
	(14,5,4,40),
	(15,5,5,41),
	(16,6,1,129),
	(17,6,2,119),
	(18,7,1,171),
	(19,8,1,160),
	(20,10,1,119),
	(21,11,1,160),
	(22,12,1,160),
	(23,13,1,122),
	(24,14,1,167),
	(25,15,1,111),
	(26,15,2,164),
	(27,1,1,167),
	(28,16,1,57),
	(29,16,2,145),
	(30,16,3,143),
	(31,17,1,52),
	(32,17,2,66),
	(33,17,3,115),
	(34,17,4,46),
	(35,18,1,58),
	(36,18,2,68),
	(37,18,3,9),
	(38,19,1,61),
	(39,19,2,70),
	(40,19,3,11),
	(41,19,4,50),
	(42,23,1,60),
	(43,23,2,162),
	(44,23,3,69),
	(45,23,4,30),
	(46,24,1,54),
	(47,24,2,5),
	(48,24,3,26),
	(49,25,1,62),
	(50,25,2,170),
	(51,25,3,31),
	(52,26,1,59),
	(53,26,2,159),
	(54,26,3,161),
	(55,26,4,40),
	(56,26,5,41),
	(57,27,1,53),
	(58,27,2,47),
	(59,28,1,52),
	(60,28,2,115),
	(61,28,3,66),
	(62,28,4,46),
	(63,29,1,58),
	(64,29,2,152),
	(65,29,3,68),
	(66,29,4,154),
	(67,29,5,9),
	(68,30,1,58),
	(69,30,2,152),
	(70,30,3,68),
	(71,30,4,151),
	(72,30,5,155),
	(73,29,6,155),
	(74,30,6,154),
	(75,30,7,9),
	(76,30,8,32),
	(77,31,1,58),
	(78,31,2,152),
	(79,31,3,68),
	(80,31,4,8),
	(81,31,6,9),
	(82,31,7,48),
	(83,32,1,58),
	(84,32,2,152),
	(85,32,3,68),
	(86,32,10,155),
	(87,32,12,32),
	(88,32,4,151),
	(89,33,1,61),
	(90,33,2,70),
	(91,33,3,11),
	(92,33,4,50),
	(93,35,1,51),
	(94,35,2,109),
	(95,35,3,65),
	(96,35,4,21),
	(97,35,5,20),
	(98,35,6,22),
	(99,35,8,45),
	(100,36,1,51),
	(101,36,2,109),
	(102,36,3,65),
	(103,36,4,169),
	(104,36,5,21),
	(105,36,6,20),
	(106,36,7,22),
	(107,36,9,45),
	(108,37,1,51),
	(109,37,2,109),
	(110,37,3,65),
	(111,37,4,21),
	(112,37,5,20),
	(113,37,6,22),
	(114,37,8,45),
	(115,38,1,51),
	(116,38,2,109),
	(117,38,3,65),
	(118,38,4,36),
	(119,38,5,37),
	(120,38,6,38),
	(121,38,7,21),
	(122,38,8,20),
	(123,38,9,22),
	(124,38,11,45),
	(125,39,1,51),
	(126,39,2,109),
	(127,39,3,65),
	(128,39,10,45),
	(129,39,4,22),
	(130,40,1,51),
	(131,40,2,109),
	(132,40,3,65),
	(133,40,4,22),
	(134,40,5,45),
	(135,41,1,51),
	(136,41,2,109),
	(137,41,3,65),
	(138,41,4,23),
	(139,41,5,45),
	(140,42,1,51),
	(141,42,2,109),
	(142,42,3,65),
	(143,42,4,45),
	(144,43,1,51),
	(145,43,2,109),
	(146,43,3,65),
	(147,43,4,172),
	(148,43,5,173),
	(149,43,6,45),
	(150,44,1,51),
	(151,44,2,109),
	(152,44,3,65),
	(153,44,4,35),
	(154,44,5,21),
	(155,44,6,20),
	(156,44,7,22),
	(157,44,8,45),
	(158,45,1,51),
	(159,45,2,109),
	(160,45,3,65),
	(161,45,4,21),
	(162,45,5,20),
	(163,45,6,22),
	(164,45,7,45),
	(165,46,1,51),
	(166,46,2,109),
	(167,46,3,65),
	(168,46,4,20),
	(169,46,5,22),
	(170,46,6,45),
	(171,23,5,256),
	(172,16,4,254),
	(173,47,1,51),
	(174,47,2,109),
	(175,47,3,65),
	(176,47,4,113),
	(177,47,5,45),
	(178,41,6,4),
	(179,41,7,113),
	(180,28,5,25),
	(181,16,5,200),
	(182,48,1,51),
	(183,48,2,109),
	(184,48,3,65),
	(185,48,4,23),
	(186,48,5,45),
	(187,45,8,24),
	(188,30,9,153),
	(189,29,7,153),
	(190,24,4,130),
	(191,9,1,133),
	(192,18,4,152),
	(193,19,5,168),
	(194,33,5,168),
	(195,18,5,153),
	(196,18,6,49),
	(197,49,1,178),
	(198,49,2,177),
	(199,49,3,257),
	(200,49,4,12),
	(201,50,1,56),
	(202,50,2,67),
	(203,50,3,199),
	(204,45,9,34),
	(205,29,8,42),
	(206,30,10,42),
	(207,32,11,42),
	(208,34,1,109),
	(209,34,2,4),
	(210,34,3,3),
	(211,34,4,51),
	(212,34,5,113),
	(213,34,6,23),
	(214,34,7,253),
	(215,34,8,65),
	(216,34,9,22),
	(217,34,10,2),
	(218,34,11,45),
	(219,34,12,27),
	(220,34,13,1),
	(221,20,1,57),
	(222,20,2,145),
	(223,20,3,147),
	(224,20,4,149),
	(225,20,5,254),
	(226,20,6,143),
	(227,20,7,200),
	(228,20,8,141),
	(229,20,9,183),
	(230,22,1,55),
	(231,22,2,6),
	(232,22,3,132),
	(233,22,4,181),
	(234,21,1,56),
	(235,21,2,67),
	(236,21,3,199),
	(237,21,4,135),
	(238,21,5,137),
	(239,21,6,139),
	(240,21,7,182),
	(241,51,1,58),
	(242,51,2,152),
	(243,51,3,68),
	(244,51,4,264);

/*!40000 ALTER TABLE `habanero_trait_highlights` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_traits
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_traits`;

CREATE TABLE `habanero_traits` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variety_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `sort_direction` varchar(255) DEFAULT NULL,
  `relation` varchar(255) DEFAULT NULL,
  `associated_name` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `derived` tinyint(1) DEFAULT NULL,
  `nullable` tinyint(1) DEFAULT NULL,
  `sortable` tinyint(1) DEFAULT NULL,
  `ordered` tinyint(1) DEFAULT NULL,
  `no_html` tinyint(1) DEFAULT NULL,
  `primary` tinyint(1) DEFAULT NULL,
  `serializable` tinyint(1) DEFAULT NULL,
  `limit` int(11) DEFAULT NULL,
  `precision` int(11) DEFAULT NULL,
  `scale` int(11) DEFAULT NULL,
  `default` int(11) DEFAULT NULL,
  `documentation` text,
  `associated_type_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `scope_id` int(11) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `polymorphic` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_habanero_traits_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_traits` WRITE;
/*!40000 ALTER TABLE `habanero_traits` DISABLE KEYS */;

INSERT INTO `habanero_traits` (`id`, `variety_id`, `name`, `type`, `parent_id`, `lft`, `rgt`, `slug`, `sort_direction`, `relation`, `associated_name`, `format`, `derived`, `nullable`, `sortable`, `ordered`, `no_html`, `primary`, `serializable`, `limit`, `precision`, `scale`, `default`, `documentation`, `associated_type_id`, `category_id`, `scope_id`, `target_id`, `polymorphic`)
VALUES
	(1,2,'Type','Habanero::StringTrait',NULL,1,2,'type',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(2,2,'Sort Direction','Habanero::StringTrait',NULL,3,4,'sort-direction',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(3,2,'Relation','Habanero::StringTrait',NULL,5,6,'relation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(4,2,'Associated name','Habanero::StringTrait',NULL,7,8,'associated-name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,11,'Template Name','Habanero::StringTrait',NULL,9,10,'template-name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(6,21,'Host','Habanero::StringTrait',NULL,11,12,'host',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(7,25,'Type','Habanero::StringTrait',NULL,13,14,'type',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(8,25,'Title','Habanero::StringTrait',NULL,15,16,'title',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(9,25,'Template','Habanero::StringTrait',NULL,17,18,'template',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(10,28,'Template','Habanero::StringTrait',NULL,19,20,'template',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(11,32,'Abbreviation','Habanero::StringTrait',NULL,21,22,'abbreviation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(12,39,'Value','Habanero::StringTrait',NULL,23,24,'value',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(13,40,'Format','Habanero::StringTrait',NULL,25,26,'format',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(14,51,'sans font family','Habanero::StringTrait',NULL,27,28,'sans-font-family',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(15,51,'serif font family','Habanero::StringTrait',NULL,29,30,'serif-font-family',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(16,51,'mono font family','Habanero::StringTrait',NULL,31,32,'mono-font-family',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(17,51,'alt font family','Habanero::StringTrait',NULL,33,34,'alt-font-family',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(18,51,'headings font family','Habanero::StringTrait',NULL,35,36,'headings-font-family',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(19,51,'headings font weight','Habanero::StringTrait',NULL,37,38,'headings-font-weight',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(20,2,'Derived','Habanero::TrueFalseTrait',NULL,39,40,'derived',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(21,2,'Nullable','Habanero::TrueFalseTrait',NULL,41,42,'nullable',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(22,2,'Sortable','Habanero::TrueFalseTrait',NULL,43,44,'sortable',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(23,2,'Ordered','Habanero::TrueFalseTrait',NULL,45,46,'ordered',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(24,6,'no html','Habanero::TrueFalseTrait',NULL,47,48,'no-html',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(25,7,'Suppress automatic naming','Habanero::TrueFalseTrait',NULL,49,50,'suppress-automatic-naming',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(26,11,'Fluid','Habanero::TrueFalseTrait',NULL,51,52,'fluid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(27,19,'Primary','Habanero::TrueFalseTrait',NULL,53,54,'primary',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(28,25,'no html','Habanero::TrueFalseTrait',NULL,55,56,'no-html',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(29,28,'no html','Habanero::TrueFalseTrait',NULL,57,58,'no-html',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(30,30,'Primary','Habanero::TrueFalseTrait',NULL,59,60,'primary',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(31,35,'Fluid','Habanero::TrueFalseTrait',NULL,61,62,'fluid',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(32,37,'Paginate','Habanero::TrueFalseTrait',NULL,63,64,'paginate',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(33,28,'Paginate','Habanero::TrueFalseTrait',NULL,65,66,'paginate',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(34,6,'serializable','Habanero::TrueFalseTrait',NULL,67,68,'serializable',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(35,2,'Limit','Habanero::IntegerTrait',NULL,69,70,'limit',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(36,2,'Precision','Habanero::IntegerTrait',NULL,71,72,'precision',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(37,2,'Scale','Habanero::IntegerTrait',NULL,73,74,'scale',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(38,2,'Default','Habanero::IntegerTrait',NULL,75,76,'default',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(39,37,'Columns','Habanero::IntegerTrait',NULL,77,78,'columns',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(40,29,'Span','Habanero::IntegerTrait',NULL,79,80,'span',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(41,29,'Offset','Habanero::IntegerTrait',NULL,81,82,'offset',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(42,25,'span','Habanero::IntegerTrait',NULL,83,84,'span',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(43,28,'span','Habanero::IntegerTrait',NULL,85,86,'span',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(44,51,'grid columns','Habanero::IntegerTrait',NULL,87,88,'grid-columns',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(45,2,'Documentation','Habanero::TextTrait',NULL,89,90,'documentation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(46,7,'Documentation','Habanero::TextTrait',NULL,91,92,'documentation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(47,8,'Documentation','Habanero::TextTrait',NULL,93,94,'documentation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(48,25,'Body','Habanero::TextTrait',NULL,95,96,'body',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(49,25,'Documentation','Habanero::TextTrait',NULL,97,98,'documentation',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(50,32,'Strategy','Habanero::TextTrait',NULL,99,100,'strategy',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(51,2,'Name','Habanero::NameTrait',NULL,101,102,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(52,7,'Name','Habanero::NameTrait',NULL,103,104,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(53,8,'Name','Habanero::NameTrait',NULL,105,106,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(54,11,'Name','Habanero::NameTrait',NULL,107,108,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(55,21,'Name','Habanero::NameTrait',NULL,109,110,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(56,23,'Name','Habanero::NameTrait',NULL,111,112,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(57,24,'Name','Habanero::NameTrait',NULL,113,114,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(58,25,'Name','Habanero::NameTrait',NULL,115,116,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(59,29,'Name','Habanero::NameTrait',NULL,117,118,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(60,30,'Name','Habanero::NameTrait',NULL,119,120,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(61,32,'Name','Habanero::NameTrait',NULL,121,122,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(62,35,'Name','Habanero::NameTrait',NULL,123,124,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(63,38,'Name','Habanero::NameTrait',NULL,125,126,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(64,51,'Name','Habanero::NameTrait',NULL,127,128,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(65,2,'Super Trait','Habanero::NestTrait',NULL,129,130,'super-trait',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(66,7,'Super variety','Habanero::NestTrait',NULL,131,132,'super-variety',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(67,23,'Enclosing garden','Habanero::NestTrait',NULL,133,134,'enclosing-garden',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(68,25,'Enclosing feature','Habanero::NestTrait',NULL,135,136,'enclosing-feature',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(69,30,'Enclosing highlighter','Habanero::NestTrait',NULL,137,138,'enclosing-highlighter',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(70,32,'Super category','Habanero::NestTrait',NULL,139,140,'super-category',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(71,51,'super theme','Habanero::NestTrait',NULL,141,142,'super-theme',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(72,2,'Trait Highlighted Traits','Habanero::RelationTrait',NULL,143,148,'trait-highlighter-traits',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(73,2,'Target Slug Traits','Habanero::RelationTrait',NULL,149,150,'target-slug-traits',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(74,2,'Trait components','Habanero::RelationTrait',NULL,151,156,'trait-components',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Sets up the ability to drive what kinds of components a nested trait, for example range traits, may hold. For use only when the sub-traits of a nest trait are all of the same trait type.',NULL,NULL,NULL,NULL,NULL),
	(75,7,'Variety Traits','Habanero::RelationTrait',NULL,157,162,'variety-traits',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(76,7,'Target Gardens','Habanero::RelationTrait',NULL,163,168,'target-gardens',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(77,7,'Variety Highlighters','Habanero::RelationTrait',NULL,169,174,'variety-highlighters',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(78,7,'Target Scenes','Habanero::RelationTrait',NULL,175,180,'target-scenes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(79,7,'variety features','Habanero::RelationTrait',NULL,181,186,'variety-features',NULL,NULL,'features',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(80,8,'Brand Varieties','Habanero::RelationTrait',NULL,187,192,'brand-varieties',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(81,8,'brand layouts','Habanero::RelationTrait',NULL,193,198,'brand-layouts',NULL,NULL,'layouts',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(82,8,'Brand gardens','Habanero::RelationTrait',NULL,199,204,'brand-gardens',NULL,NULL,'gardens',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(83,8,'Brand categories','Habanero::RelationTrait',NULL,205,210,'brand-categories',NULL,NULL,'categories',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(84,11,'Layout Scenes','Habanero::RelationTrait',NULL,211,216,'layout-scenes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(85,11,'Layout Beds','Habanero::RelationTrait',NULL,217,222,'layout-beds',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(86,11,'Layout Rows','Habanero::RelationTrait',NULL,223,228,'layout-rows',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(87,21,'Sites Root Scene','Habanero::RelationTrait',NULL,229,234,'sites-root-scene',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(88,21,'Site Gardens','Habanero::RelationTrait',NULL,235,240,'site-gardens',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(89,23,'Template Gardens','Habanero::RelationTrait',NULL,241,246,'template-gardens',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(90,23,'Garden Scenes','Habanero::RelationTrait',NULL,247,252,'garden-scenes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(91,23,'garden placements','Habanero::RelationTrait',NULL,253,258,'garden-placements',NULL,NULL,'placements',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(92,24,'Template Scenes','Habanero::RelationTrait',NULL,259,264,'template-scenes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(93,24,'Scene Placements','Habanero::RelationTrait',NULL,265,270,'scene-placements',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(94,24,'Previous Next Scenes','Habanero::RelationTrait',NULL,271,276,'previous-next-scenes',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(95,25,'Feature Placements','Habanero::RelationTrait',NULL,277,282,'feature-placements',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(96,25,'Brand Features','Habanero::RelationTrait',NULL,283,288,'brand-features',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(97,27,'Scene VarietyFeatures','Habanero::RelationTrait',NULL,289,294,'scene-varietiefeatures',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(98,29,'Bed Placements','Habanero::RelationTrait',NULL,295,300,'bed-placements',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(99,30,'Highlighter Highlighted Traits','Habanero::RelationTrait',NULL,301,306,'highlighter-highlighter-traits',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(100,30,'Highlighter Variety Features','Habanero::RelationTrait',NULL,307,312,'highlighter-variety-features',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(101,34,'Category Traits','Habanero::RelationTrait',NULL,313,318,'category-traits',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(102,35,'Row Beds','Habanero::RelationTrait',NULL,319,324,'row-beds',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(103,2,'Scope Traits','Habanero::RelationTrait',NULL,325,330,'scope-traits',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(104,36,'Target Slug Traits','Habanero::RelationTrait',NULL,331,336,'target-slug-traits',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(105,38,'Variety Graders','Habanero::RelationTrait',NULL,337,342,'variety-Grader',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(106,38,'Grader Conditions','Habanero::RelationTrait',NULL,343,348,'grader-conditions',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(107,38,'Grader Features','Habanero::RelationTrait',NULL,349,354,'grader-features',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(108,39,'Trait Conditions','Habanero::RelationTrait',NULL,355,360,'trait-conditions',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(109,2,'Variety','Habanero::AssociationTrait',75,158,159,'variety',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(110,2,'Slug Traits','Habanero::AssociationTrait',104,332,333,'slug-traits',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(111,2,'Highlighted Traits','Habanero::AssociationTrait',72,144,145,'highlighter-traits',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(112,2,'Conditions','Habanero::AssociationTrait',108,356,357,'conditions',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(113,2,'associated type','Habanero::AssociationTrait',74,152,153,'associated-type',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(114,7,'Traits','Habanero::AssociationTrait',75,160,161,'traits',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(115,7,'Brand','Habanero::AssociationTrait',80,188,189,'brand',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(116,7,'Gardens','Habanero::AssociationTrait',76,164,165,'gardens',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(117,7,'Highlighters','Habanero::AssociationTrait',77,170,171,'highlighters',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(118,7,'Graders','Habanero::AssociationTrait',105,338,339,'Grader',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(119,7,'Scenes','Habanero::AssociationTrait',78,176,177,'scenes',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(120,7,'super traits','Habanero::AssociationTrait',74,154,155,'super-traits',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(121,7,'features','Habanero::AssociationTrait',79,182,183,'features',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(122,8,'Varieties','Habanero::AssociationTrait',80,190,191,'varieties',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(123,8,'features','Habanero::AssociationTrait',96,284,285,'features',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(124,8,'layouts','Habanero::AssociationTrait',81,194,195,'layouts',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(125,8,'gardens','Habanero::AssociationTrait',82,200,201,'gardens',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(126,8,'categories','Habanero::AssociationTrait',83,206,207,'categories',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(127,11,'Scenes','Habanero::AssociationTrait',84,212,213,'scenes',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(128,11,'Beds','Habanero::AssociationTrait',85,218,219,'beds',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(129,11,'Rows','Habanero::AssociationTrait',86,224,225,'rows',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(130,11,'brand','Habanero::AssociationTrait',81,196,197,'brand',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(131,19,'Slug Traits','Habanero::AssociationTrait',103,326,327,'slug-traits',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(132,21,'Root Scene','Habanero::AssociationTrait',87,230,231,'root-scene',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(133,21,'gardens','Habanero::AssociationTrait',88,236,237,'gardens--2',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(134,23,'Gardens','Habanero::AssociationTrait',89,242,243,'gardens',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(135,23,'Template','Habanero::AssociationTrait',89,244,245,'template',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(136,23,'Scenes','Habanero::AssociationTrait',90,248,249,'scenes',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(137,23,'Target','Habanero::AssociationTrait',76,166,167,'target',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(138,23,'placements','Habanero::AssociationTrait',91,254,255,'placements',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(139,23,'Brand','Habanero::AssociationTrait',82,202,203,'brand',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(140,24,'Sites','Habanero::AssociationTrait',87,232,233,'sites',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(141,24,'Layout','Habanero::AssociationTrait',84,214,215,'layout',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(142,24,'Scenes','Habanero::AssociationTrait',92,260,261,'scenes',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(143,24,'Template','Habanero::AssociationTrait',92,262,263,'template',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(144,24,'Placements','Habanero::AssociationTrait',95,278,279,'placements',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(145,24,'Garden','Habanero::AssociationTrait',90,250,251,'garden',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(146,24,'VarietyFeatures','Habanero::AssociationTrait',97,290,291,'varietiefeatures',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(147,24,'Target','Habanero::AssociationTrait',78,178,179,'target',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(148,24,'Previous Scenes','Habanero::AssociationTrait',94,272,273,'previous-scenes',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(149,24,'Next Scene','Habanero::AssociationTrait',94,274,275,'next-scene',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(150,25,'Placements','Habanero::AssociationTrait',93,266,267,'placements',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(151,25,'Grader','Habanero::AssociationTrait',107,350,351,'grader',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(152,25,'Brand','Habanero::AssociationTrait',96,286,287,'brand',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(153,25,'variety','Habanero::AssociationTrait',79,184,185,'variety',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(154,27,'Scene','Habanero::AssociationTrait',97,292,293,'scene',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(155,27,'Highlighter','Habanero::AssociationTrait',100,308,309,'highlighter',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(156,28,'Feature','Habanero::AssociationTrait',93,268,269,'feature',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(157,28,'Scene','Habanero::AssociationTrait',95,280,281,'scene',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(158,28,'Bed','Habanero::AssociationTrait',98,296,297,'bed',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(159,29,'Layout','Habanero::AssociationTrait',85,220,221,'layout',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(160,29,'Placements','Habanero::AssociationTrait',98,298,299,'placements',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(161,29,'Row','Habanero::AssociationTrait',102,320,321,'row',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(162,30,'Variety','Habanero::AssociationTrait',77,172,173,'variety',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(163,30,'Highlighted Traits','Habanero::AssociationTrait',99,302,303,'highlighter-traits',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(164,30,'Variety Features','Habanero::AssociationTrait',100,310,311,'variety-features',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(165,31,'Highlighter','Habanero::AssociationTrait',99,304,305,'highlighter',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(166,31,'Trait','Habanero::AssociationTrait',72,146,147,'trait',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(167,32,'Traits','Habanero::AssociationTrait',101,314,315,'traits',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(168,32,'Brand','Habanero::AssociationTrait',83,208,209,'brand',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(169,34,'Category','Habanero::AssociationTrait',101,316,317,'category',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(170,35,'Layout','Habanero::AssociationTrait',86,226,227,'layout',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(171,35,'Beds','Habanero::AssociationTrait',102,322,323,'beds',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(172,36,'Scope','Habanero::AssociationTrait',103,328,329,'scope',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(173,36,'Target','Habanero::AssociationTrait',104,334,335,'target',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(174,38,'Variety','Habanero::AssociationTrait',105,340,341,'variety',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(175,38,'Conditions','Habanero::AssociationTrait',106,344,345,'conditions',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(176,38,'Features','Habanero::AssociationTrait',107,352,353,'features',NULL,'has_many',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(177,39,'Trait','Habanero::AssociationTrait',108,358,359,'trait',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(178,39,'Grader','Habanero::AssociationTrait',106,346,347,'grader',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(179,43,'site','Habanero::AssociationTrait',88,238,239,'site',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(180,43,'garden','Habanero::AssociationTrait',91,256,257,'garden',NULL,'belongs_to',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(181,21,'theme','Habanero::AssociationTrait',NULL,361,362,'theme',NULL,'belongs_to','site',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,NULL,NULL,NULL,NULL),
	(182,23,'theme','Habanero::AssociationTrait',NULL,363,364,'theme',NULL,'belongs_to','garden',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,NULL,NULL,NULL,NULL),
	(183,24,'theme','Habanero::AssociationTrait',NULL,365,366,'theme',NULL,'belongs_to','scene',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,NULL,NULL,NULL,NULL),
	(184,43,'theme','Habanero::AssociationTrait',NULL,367,368,'theme',NULL,'belongs_to','placement',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,51,NULL,NULL,NULL,NULL),
	(185,51,'brand','Habanero::AssociationTrait',NULL,369,370,'brand',NULL,'belongs_to','theme',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,8,NULL,NULL,NULL,NULL),
	(186,2,'Slug','Habanero::SlugTrait',NULL,371,372,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,162,51,NULL),
	(187,7,'Slug','Habanero::SlugTrait',NULL,373,374,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,115,52,NULL),
	(188,8,'Slug','Habanero::SlugTrait',NULL,375,376,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,53,NULL),
	(189,11,'Slug','Habanero::SlugTrait',NULL,377,378,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,54,NULL),
	(190,21,'Slug','Habanero::SlugTrait',NULL,379,380,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,55,NULL),
	(191,23,'Slug','Habanero::SlugTrait',NULL,381,382,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,82,56,NULL),
	(192,24,'Slug','Habanero::SlugTrait',NULL,383,384,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,145,57,NULL),
	(193,25,'Slug','Habanero::SlugTrait',NULL,385,386,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,58,NULL),
	(194,29,'Slug','Habanero::SlugTrait',NULL,387,388,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,59,NULL),
	(195,30,'Slug','Habanero::SlugTrait',NULL,389,390,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,162,60,NULL),
	(196,32,'Slug','Habanero::SlugTrait',NULL,391,392,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,61,NULL),
	(197,35,'Slug','Habanero::SlugTrait',NULL,393,394,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,62,NULL),
	(198,51,'Slug','Habanero::SlugTrait',NULL,395,396,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,64,NULL),
	(199,23,'Signpost','Habanero::SignpostTrait',NULL,397,398,'signpost',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(200,24,'Signpost','Habanero::SignpostTrait',NULL,399,400,'signpost',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(201,51,'body background','Habanero::ColorTrait',NULL,401,402,'body-background',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(202,51,'text color','Habanero::ColorTrait',NULL,403,404,'text-color',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(203,51,'link color','Habanero::ColorTrait',NULL,405,406,'link-color',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(204,51,'link color hover','Habanero::ColorTrait',NULL,407,408,'link-color-hover',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(205,51,'hero unit heading color','Habanero::ColorTrait',NULL,409,410,'hero-unit-heading-color',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(206,51,'hero unit lead color','Habanero::ColorTrait',NULL,411,412,'hero-unit-lead-color',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(207,51,'table background','Habanero::ColorTrait',NULL,413,414,'table-background',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(208,51,'table background accent','Habanero::ColorTrait',NULL,415,416,'table-background-accent',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(209,51,'table background hover','Habanero::ColorTrait',NULL,417,418,'table-background-hover',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(210,51,'table border','Habanero::ColorTrait',NULL,419,420,'table-border',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(211,51,'navbar background','Habanero::ColorTrait',NULL,421,422,'navbar-background',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(212,51,'navbar background highlight','Habanero::ColorTrait',NULL,423,424,'navbar-background-highlight',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(213,51,'navbar text','Habanero::ColorTrait',NULL,425,426,'navbar-text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(214,51,'navbar brand color','Habanero::ColorTrait',NULL,427,428,'navbar-brand-color',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(215,51,'navbar link color','Habanero::ColorTrait',NULL,429,430,'navbar-link-color',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(216,51,'navbar link color hover','Habanero::ColorTrait',NULL,431,432,'navbar-link-color-hover',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(217,51,'navbar link color active','Habanero::ColorTrait',NULL,433,434,'navbar-link-color-active',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(218,51,'navbar search background','Habanero::ColorTrait',NULL,435,436,'navbar-search-background',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(219,51,'navbar search background focus','Habanero::ColorTrait',NULL,437,438,'navbar-search-background-focus',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(220,51,'navbar search border','Habanero::ColorTrait',NULL,439,440,'navbar-search-border',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(221,51,'navbar search placeholder color','Habanero::ColorTrait',NULL,441,442,'navbar-search-placeholder-color',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(222,51,'dropdown background','Habanero::ColorTrait',NULL,443,444,'dropdown-background',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(223,51,'dropdown border','Habanero::ColorTrait',NULL,445,446,'dropdown-border',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(224,51,'dropdown link color','Habanero::ColorTrait',NULL,447,448,'dropdown-link-color',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(225,51,'dropdown link color hover','Habanero::ColorTrait',NULL,449,450,'dropdown-link-color-hover',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(226,51,'dropdown link color background hover','Habanero::ColorTrait',NULL,451,452,'dropdown-link-color-background-hover',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(227,51,'placeholder text','Habanero::ColorTrait',NULL,453,454,'placeholder-text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(228,51,'input background','Habanero::ColorTrait',NULL,455,456,'input-background',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(229,51,'input border','Habanero::ColorTrait',NULL,457,458,'input-border',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(230,51,'input disabled background','Habanero::ColorTrait',NULL,459,460,'input-disabled-background',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(231,51,'form actions background','Habanero::ColorTrait',NULL,461,462,'form-actions-background',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(232,51,'btn primary background','Habanero::ColorTrait',NULL,463,464,'btn-primary-background',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(233,51,'btn primary background highlight','Habanero::ColorTrait',NULL,465,466,'btn-primary-background-highlight',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(234,51,'warning text','Habanero::ColorTrait',NULL,467,468,'warning-text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(235,51,'warning background','Habanero::ColorTrait',NULL,469,470,'warning-background',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(236,51,'error text','Habanero::ColorTrait',NULL,471,472,'error-text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(237,51,'error background','Habanero::ColorTrait',NULL,473,474,'error-background',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(238,51,'success text','Habanero::ColorTrait',NULL,475,476,'success-text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(239,51,'success background','Habanero::ColorTrait',NULL,477,478,'success-background',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(240,51,'info text','Habanero::ColorTrait',NULL,479,480,'info-text',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(241,51,'info background','Habanero::ColorTrait',NULL,481,482,'info-background',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(242,51,'hero unit background','Habanero::ColorTrait',NULL,483,484,'hero-unit-background',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(243,51,'grid column width','Habanero::ScreenDimensionTrait',NULL,485,486,'grid-column-width',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(244,51,'grid gutter width','Habanero::ScreenDimensionTrait',NULL,487,488,'grid-gutter-width',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(245,51,'fluid grid column width','Habanero::ScreenDimensionTrait',NULL,489,490,'fluid-grid-column-width',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(246,51,'fluid grid gutter width','Habanero::ScreenDimensionTrait',NULL,491,492,'fluid-grid-gutter-width',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(247,51,'base font size','Habanero::ScreenDimensionTrait',NULL,493,494,'base-font-size',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(248,51,'base font family','Habanero::ScreenDimensionTrait',NULL,495,496,'base-font-family',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(249,51,'base line height','Habanero::ScreenDimensionTrait',NULL,497,498,'base-line-height',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(250,51,'headings color','Habanero::ScreenDimensionTrait',NULL,499,500,'headings-color',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(251,51,'navbar height','Habanero::ScreenDimensionTrait',NULL,501,502,'navbar-height',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(252,51,'input border radius','Habanero::ScreenDimensionTrait',NULL,503,504,'input-border-radius',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(253,19,'polymorphic','Habanero::TrueFalseTrait',NULL,505,506,'polymorphic',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(254,24,'category','Habanero::CategoryTrait',NULL,507,508,'category',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL),
	(255,25,'body format','Habanero::CategoryTrait',NULL,509,510,'body-format',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,18,NULL,NULL,NULL),
	(256,30,'category','Habanero::CategoryTrait',NULL,511,512,'category',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,5,NULL,NULL,NULL),
	(257,39,'Predicate','Habanero::CategoryTrait',NULL,513,514,'predicate',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,7,NULL,NULL,NULL),
	(258,39,'predicate 2','Habanero::CategoryTrait',NULL,515,516,'predicate-2',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,7,NULL,NULL,NULL),
	(259,54,'caption','Habanero::StringTrait',NULL,517,518,'caption',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(260,52,'Name','Habanero::NameTrait',NULL,519,520,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(261,54,'Name','Habanero::NameTrait',NULL,521,522,'name',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(262,54,'gallery','Habanero::AssociationTrait',NULL,523,524,'gallery',NULL,'belongs_to','picture',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,52,NULL,NULL,NULL,NULL),
	(263,52,'pictures','Habanero::AssociationTrait',NULL,525,526,'pictures',NULL,'has_many','gallery',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,54,NULL,NULL,NULL,NULL),
	(264,56,'picture','Habanero::AssociationTrait',NULL,527,528,'picture',NULL,'belongs_to','features',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,54,NULL,NULL,NULL,NULL),
	(265,52,'brand','Habanero::AssociationTrait',NULL,529,530,'brand',NULL,'belongs_to','gallery',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,8,NULL,NULL,NULL,NULL),
	(266,52,'Slug','Habanero::SlugTrait',NULL,531,532,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,260,NULL),
	(267,54,'Slug','Habanero::SlugTrait',NULL,533,534,'slug',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,561,261,NULL),
	(268,52,'category','Habanero::CategoryTrait',NULL,535,536,'category',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,23,NULL,NULL,NULL),
	(269,54,'image','Tabasco::PictureTrait',NULL,537,538,'image',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `habanero_traits` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table habanero_varieties
# ------------------------------------------------------------

DROP TABLE IF EXISTS `habanero_varieties`;

CREATE TABLE `habanero_varieties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `lft` int(11) DEFAULT NULL,
  `rgt` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `suppress_automatic_naming` tinyint(1) DEFAULT NULL,
  `documentation` text,
  PRIMARY KEY (`id`),
  KEY `index_habanero_varieties_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `habanero_varieties` WRITE;
/*!40000 ALTER TABLE `habanero_varieties` DISABLE KEYS */;

INSERT INTO `habanero_varieties` (`id`, `brand_id`, `name`, `parent_id`, `lft`, `rgt`, `slug`, `suppress_automatic_naming`, `documentation`)
VALUES
	(1,1,'Base',NULL,1,112,'base',NULL,NULL),
	(2,2,'Trait',1,2,53,'trait',NULL,NULL),
	(3,2,'StringTrait',2,3,4,'stringtrait',NULL,NULL),
	(4,2,'IntegerTrait',2,5,6,'integertrait',NULL,NULL),
	(5,2,'TrueFalseTrait',2,7,8,'truefalsetrait',NULL,NULL),
	(6,2,'TextTrait',2,9,10,'texttrait',NULL,NULL),
	(7,2,'Variety',1,54,55,'variety',NULL,NULL),
	(8,2,'Brand',1,56,57,'brand',NULL,NULL),
	(9,2,'BlobTrait',2,11,12,'blobtrait',NULL,NULL),
	(10,2,'CurrencyTrait',2,13,14,'currencytrait',NULL,NULL),
	(11,2,'Layout',1,58,59,'layout',NULL,NULL),
	(12,2,'DateTrait',2,15,16,'datetrait',NULL,NULL),
	(13,2,'DateTimeTrait',2,17,18,'datetimetrait',NULL,NULL),
	(14,2,'DecimalTrait',2,19,20,'decimaltrait',NULL,NULL),
	(15,2,'NumberTrait',2,21,22,'numbertrait',NULL,NULL),
	(16,2,'PercentageTrait',2,23,24,'percentagetrait',NULL,NULL),
	(17,2,'TimeTrait',2,25,26,'timetrait',NULL,NULL),
	(18,2,'RelationTrait',2,27,28,'relationtrait',NULL,NULL),
	(19,2,'AssociationTrait',2,29,30,'associationtrait',NULL,NULL),
	(20,2,'RangeTrait',2,31,32,'rangetrait',NULL,NULL),
	(21,2,'Site',1,60,61,'site',NULL,NULL),
	(22,2,'NestTrait',2,33,34,'nesttrait',NULL,NULL),
	(23,2,'Garden',1,62,63,'garden',NULL,NULL),
	(24,2,'Scene',1,64,65,'scene',NULL,NULL),
	(25,2,'Feature',1,66,87,'feature',NULL,NULL),
	(26,2,'ContentFeature',25,67,68,'contentfeature',NULL,NULL),
	(27,2,'VarietyFeature',25,69,82,'varietyfeature',NULL,NULL),
	(28,2,'FeaturePlacement',1,88,89,'featureplacement',NULL,NULL),
	(29,2,'Bed',1,90,91,'bed',NULL,NULL),
	(30,2,'Highlighter',1,92,93,'highlighter',NULL,NULL),
	(31,2,'TraitHighlight',1,94,95,'traithighlight',NULL,NULL),
	(32,2,'Category',1,96,97,'category',NULL,NULL),
	(33,2,'SignpostTrait',2,35,36,'signposttrait',NULL,NULL),
	(34,2,'CategoryTrait',2,37,38,'categorytrait',NULL,NULL),
	(35,2,'LayoutRow',1,98,99,'layoutrow',NULL,NULL),
	(36,2,'SlugTrait',2,39,40,'slugtrait',NULL,NULL),
	(37,2,'CollectiveVarietyFeature',27,70,73,'collectivevarietyfeature',NULL,NULL),
	(38,2,'Grader',1,100,101,'grader',NULL,NULL),
	(39,2,'Condition',1,102,103,'condition',NULL,NULL),
	(40,2,'NameTrait',2,41,42,'nametrait',NULL,NULL),
	(41,2,'NavigationFeature',25,83,84,'navigationfeature',1,NULL),
	(42,2,'TagTrait',2,43,44,'tagtrait',1,NULL),
	(43,2,'GardenPlacement',1,104,105,'gardenplacement',1,NULL),
	(44,2,'CollectiveSceneFeature',37,71,72,'collectivescenefeature',NULL,'A Variety Collection Feature that allows you to organise and present links to any of your designed scenes.'),
	(45,2,'CarouselFeature',25,85,86,'carouselfeature',1,NULL),
	(46,2,'ScenicFeature',27,74,75,'scenicfeature',1,NULL),
	(47,2,'HighlightingFeature',27,76,77,'highlightingfeature',1,NULL),
	(48,2,'FileTrait',2,45,46,'filetrait',1,'<p>A trait that associates a file with a variety instance.</p><p>Currently implemented with CarrierWave</p>'),
	(49,2,'ColorTrait',2,47,48,'colortrait',1,NULL),
	(50,2,'ScreenDimensionTrait',2,49,50,'screendimensiontrait',1,NULL),
	(51,2,'Theme',1,106,107,'theme',NULL,NULL),
	(52,3,'Gallery',1,108,109,'gallery',NULL,'<p>A grouping of images, for presenting as a group of for more convenient image location.</p>'),
	(53,3,'PictureTrait',2,51,52,'picturetrait',1,'<p>A trait that is used in Tabasco to associate a picture with a gallery, using a CarrierWave uploader called GalleryUploader</p>'),
	(54,3,'Picture',1,110,111,'picture',NULL,NULL),
	(55,3,'GalleriaFeature',27,78,79,'galleriafeature',1,NULL),
	(56,3,'PicturiaFeature',27,80,81,'picturiafeature',1,'<p>A feature that presents a single picture from a gallery</p>');

/*!40000 ALTER TABLE `habanero_varieties` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table jalapeno_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `jalapeno_users`;

CREATE TABLE `jalapeno_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `context_id` int(11) DEFAULT NULL,
  `context_type` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `username` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `unconfirmed_email` varchar(255) DEFAULT NULL,
  `failed_attempts` int(11) DEFAULT '0',
  `unlock_token` varchar(255) DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `authentication_token` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_jalapeno_users_on_email` (`email`),
  UNIQUE KEY `index_jalapeno_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_jalapeno_users_on_confirmation_token` (`confirmation_token`),
  UNIQUE KEY `index_jalapeno_users_on_unlock_token` (`unlock_token`),
  UNIQUE KEY `index_jalapeno_users_on_authentication_token` (`authentication_token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table schema_migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `schema_migrations`;

CREATE TABLE `schema_migrations` (
  `version` varchar(255) NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;

INSERT INTO `schema_migrations` (`version`)
VALUES
	('20120511063330'),
	('20120511063331'),
	('20120511063332'),
	('20120511063336'),
	('20120511063349'),
	('20120530053803');

/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table tabasco_galleries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tabasco_galleries`;

CREATE TABLE `tabasco_galleries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_tabasco_galleries_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tabasco_pictures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tabasco_pictures`;

CREATE TABLE `tabasco_pictures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caption` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `gallery_id` int(11) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_tabasco_pictures_on_slug` (`slug`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table taggings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taggings`;

CREATE TABLE `taggings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) DEFAULT NULL,
  `taggable_id` int(11) DEFAULT NULL,
  `taggable_type` varchar(255) DEFAULT NULL,
  `tagger_id` int(11) DEFAULT NULL,
  `tagger_type` varchar(255) DEFAULT NULL,
  `context` varchar(128) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_taggings_on_tag_id` (`tag_id`),
  KEY `index_taggings_on_taggable_id_and_taggable_type_and_context` (`taggable_id`,`taggable_type`,`context`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
