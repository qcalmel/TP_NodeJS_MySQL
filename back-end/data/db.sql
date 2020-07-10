-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema shopping_list
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema shopping_list
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `shopping_list` DEFAULT CHARACTER SET utf8 ;
USE `shopping_list` ;

-- -----------------------------------------------------
-- Table `shopping_list`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shopping_list`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `category_name_UNIQUE` ON `shopping_list`.`category` (`category_name` ASC);


-- -----------------------------------------------------
-- Table `shopping_list`.`article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shopping_list`.`article` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `article_name` VARCHAR(45) NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `FK_product_category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `shopping_list`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `article_name_UNIQUE` ON `shopping_list`.`article` (`article_name` ASC);



-- -----------------------------------------------------
-- Table `shopping_list`.`list`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shopping_list`.`list` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `list_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `list_name_UNIQUE` ON `shopping_list`.`list` (`list_name` ASC);


-- -----------------------------------------------------
-- Table `shopping_list`.`list_article`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `shopping_list`.`list_article` (
  `article_id` INT NOT NULL,
  `list_id` INT NOT NULL,
  PRIMARY KEY (`article_id`, `list_id`),
  CONSTRAINT `fk_list_product_product1`
    FOREIGN KEY (`article_id`)
    REFERENCES `shopping_list`.`article` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_list_product_list1`
    FOREIGN KEY (`list_id`)
    REFERENCES `shopping_list`.`list` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_list_article_list1_idx` ON `shopping_list`.`list_article` (`list_id` ASC);

CREATE INDEX `fk_list_article_article1_idx` ON `shopping_list`.`list_article` (`article_id` ASC);

CREATE OR REPLACE VIEW view_article as SELECT a.*, c.category_name, l.list_name FROM article as a INNER JOIN category as c INNER JOIN list as l INNER JOIN list_article as l_a  ON a.category_id = c.id AND l_a.article_id = a.id AND l.id = l_a.list_id WHERE l.list_name = 'temporary_list';

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

 INSERT INTO `category` (`id`,`category_name`) VALUES 
 (2,'Alcools'),
 (1,'Boulangerie'),
 (3,'Pharmacie');

 INSERT INTO `list` (`id`,`list_name`) VALUES 
 (3,'liste Noel'),
 (2,'liste test'),
 (1,'temporary_list');

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

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
