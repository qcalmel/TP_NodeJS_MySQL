-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.11-MariaDB


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema shopping_list
--

CREATE DATABASE IF NOT EXISTS shopping_list;
USE shopping_list;

--
-- Temporary table structure for view `view_article`
--
DROP TABLE IF EXISTS `view_article`;
DROP VIEW IF EXISTS `view_article`;
CREATE TABLE `view_article` (
  `id` int(11),
  `article_name` varchar(45),
  `category_id` int(11),
  `category_name` varchar(45),
  `list_name` varchar(45)
);

--
-- Definition of table `article`
--

DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `article_name` varchar(45) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `article_name_UNIQUE` (`article_name`),
  KEY `FK_product_category_id` (`category_id`),
  CONSTRAINT `FK_product_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `article`
--

/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` (`id`,`article_name`,`category_id`) VALUES 
 (1,'pain',1),
 (7,'pain de mie',1),
 (8,'pomme',1),
 (9,'poire',1),
 (10,'coubidoubidous',1),
 (13,'fraise',1),
 (17,'wxcwxc',2),
 (31,'vin',2),
 (39,'sdfsdf',3),
 (41,'fgdh',3);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;


--
-- Definition of table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_name_UNIQUE` (`category_name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`id`,`category_name`) VALUES 
 (2,'Alcools'),
 (1,'Boulangerie'),
 (3,'Pharmacie');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;


--
-- Definition of table `list`
--

DROP TABLE IF EXISTS `list`;
CREATE TABLE `list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `list_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `list_name_UNIQUE` (`list_name`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `list`
--

/*!40000 ALTER TABLE `list` DISABLE KEYS */;
INSERT INTO `list` (`id`,`list_name`) VALUES 
 (3,'liste Noel'),
 (2,'liste test'),
 (1,'temporary_list');
/*!40000 ALTER TABLE `list` ENABLE KEYS */;


--
-- Definition of table `list_article`
--

DROP TABLE IF EXISTS `list_article`;
CREATE TABLE `list_article` (
  `article_id` int(11) NOT NULL,
  `list_id` int(11) NOT NULL,
  PRIMARY KEY (`article_id`,`list_id`),
  KEY `fk_list_article_list1_idx` (`list_id`),
  KEY `fk_list_article_article1_idx` (`article_id`),
  CONSTRAINT `fk_list_product_list1` FOREIGN KEY (`list_id`) REFERENCES `list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_list_product_product1` FOREIGN KEY (`article_id`) REFERENCES `article` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `list_article`
--

/*!40000 ALTER TABLE `list_article` DISABLE KEYS */;
INSERT INTO `list_article` (`article_id`,`list_id`) VALUES 
 (1,1),
 (7,2),
 (13,2),
 (17,3),
 (31,1),
 (31,3),
 (39,2),
 (39,3),
 (41,1);
/*!40000 ALTER TABLE `list_article` ENABLE KEYS */;


--
-- Definition of view `view_article`
--

DROP TABLE IF EXISTS `view_article`;
DROP VIEW IF EXISTS `view_article`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_article` AS select `a`.`id` AS `id`,`a`.`article_name` AS `article_name`,`a`.`category_id` AS `category_id`,`c`.`category_name` AS `category_name`,`l`.`list_name` AS `list_name` from (((`article` `a` join `category` `c`) join `list` `l`) join `list_article` `l_a` on(`a`.`category_id` = `c`.`id` and `l_a`.`article_id` = `a`.`id` and `l`.`id` = `l_a`.`list_id`)) where `l`.`list_name` = 'temporary_list';



/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
