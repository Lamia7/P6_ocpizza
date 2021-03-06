-- SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
-- SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

--
-- Schema ocpizza
--
DROP SCHEMA IF EXISTS `ocpizza` ;

--
-- Schema ocpizza
--
CREATE SCHEMA IF NOT EXISTS `ocpizza` DEFAULT CHARACTER SET utf8mb4 ;
USE ocpizza;

--
-- Table `ocpizza`.`address`
--
CREATE TABLE IF NOT EXISTS `ocpizza`.`address` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `address1` VARCHAR(100) NOT NULL,
  `address2` VARCHAR(100) NULL,
  `zip_code` VARCHAR(5) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE INDEX `by_city_idx` ON `ocpizza`.`address` (`city` ASC);


--
-- Table `ocpizza`.`restaurant`
--
CREATE TABLE IF NOT EXISTS `ocpizza`.`restaurant` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `address_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `address_id`),
  CONSTRAINT `fk_restaurant_address_id`
    FOREIGN KEY (`address_id`)
    REFERENCES `ocpizza`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `by_address_idx` ON `ocpizza`.`restaurant` (`address_id` ASC);

CREATE UNIQUE INDEX `name_UNIQUE` ON `ocpizza`.`restaurant` (`name` ASC);


--
-- Table `ocpizza`.`client`
--
CREATE TABLE IF NOT EXISTS `ocpizza`.`client` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(10) NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NULL,
  `address_id` INT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_client_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `ocpizza`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `by_address_idx` ON `ocpizza`.`client` (`address_id` ASC);

CREATE INDEX `by_last_name_idx` ON `ocpizza`.`client` (`last_name` ASC);

CREATE UNIQUE INDEX `email_UNIQUE` ON `ocpizza`.`client` (`email` ASC);


--
-- Table `ocpizza`.`purchase`
--
CREATE TABLE IF NOT EXISTS `ocpizza`.`purchase` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `purchase_date` DATETIME NOT NULL,
  `total_price` DECIMAL(4,2) NULL,
  `client_id` INT UNSIGNED NOT NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  `address_id` INT UNSIGNED NOT NULL,
  `delivery_method` ENUM('LIVRER', 'EMPORTER') NOT NULL,
  `payment_method` ENUM('Espèces', 'CB', 'Titre Restaurant', 'Chèque') NOT NULL,
  `purchase_status` ENUM('En attente confirmation restaurant', 'En préparation', 'En attente de livraison', 'En attente de retrait', 'Livraison en cours', 'Commande retirée', 'Commande livrée', 'Annulée') NOT NULL,
  `payment_status` ENUM('Paiement en attente', 'Paiement effectué') NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_purchase_client`
    FOREIGN KEY (`client_id`)
    REFERENCES `ocpizza`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchase_restaurant`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `ocpizza`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchase_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `ocpizza`.`address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `ocpizza`.`purchase` (`id` ASC);

CREATE INDEX `by_client_idx` ON `ocpizza`.`purchase` (`client_id` ASC);

CREATE INDEX `by_restaurant_idx` ON `ocpizza`.`purchase` (`restaurant_id` ASC);

CREATE INDEX `by_address_idx` ON `ocpizza`.`purchase` (`address_id` ASC);

CREATE INDEX `by_date_idx` ON `ocpizza`.`purchase` (`purchase_date` ASC);


--
-- Table `ocpizza`.`pizza`
--
CREATE TABLE IF NOT EXISTS `ocpizza`.`pizza` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE INDEX `by_price_idx` ON `ocpizza`.`pizza` (`price` ASC);

CREATE UNIQUE INDEX `name_UNIQUE` ON `ocpizza`.`pizza` (`name` ASC);


--
-- Table `ocpizza`.`ingredient`
--
CREATE TABLE IF NOT EXISTS `ocpizza`.`ingredient` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `name_UNIQUE` ON `ocpizza`.`ingredient` (`name` ASC);


--
-- Table `ocpizza`.`ingredient_pizza`
--
CREATE TABLE IF NOT EXISTS `ocpizza`.`ingredient_pizza` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `recipe` TEXT(500) NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  `ingredient_id` INT UNSIGNED NOT NULL,
  `pizza_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `ingredient_id`, `pizza_id`),
  CONSTRAINT `fk_ingredient_pizza_pizza_id`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `ocpizza`.`pizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredient_pizza_ingredient_id`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `ocpizza`.`ingredient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `by_ingredient_idx` ON `ocpizza`.`ingredient_pizza` (`ingredient_id` ASC);

CREATE INDEX `by_pizza_idx` ON `ocpizza`.`ingredient_pizza` (`pizza_id` ASC);


--
-- Table `ocpizza`.`pizza_purchase`
--
CREATE TABLE IF NOT EXISTS `ocpizza`.`pizza_purchase` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `pizza_unit` INT NOT NULL,
  `pizza_id` INT UNSIGNED NOT NULL,
  `purchase_id` INT UNSIGNED NOT NULL,
  `unit_price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`id`, `pizza_id`, `purchase_id`),
  CONSTRAINT `fk_pizza_purchase_pizza_id`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `ocpizza`.`pizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizza_purchase_purchase_id`
    FOREIGN KEY (`purchase_id`)
    REFERENCES `ocpizza`.`purchase` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `by_pizza_idx` ON `ocpizza`.`pizza_purchase` (`pizza_id` ASC);

CREATE INDEX `by_purchase_idx` ON `ocpizza`.`pizza_purchase` (`purchase_id` ASC);


--
-- Table `ocpizza`.`team`
--
CREATE TABLE IF NOT EXISTS `ocpizza`.`team` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(10) NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  `role` ENUM('Gérant', 'Responsable', 'Pizzaïolo', 'Livreur') NOT NULL,
  PRIMARY KEY (`id`, `restaurant_id`),
  CONSTRAINT `fk_team_restaurant_id`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `ocpizza`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `by_restaurant_idx` ON `ocpizza`.`team` (`restaurant_id` ASC);

CREATE UNIQUE INDEX `email_UNIQUE` ON `ocpizza`.`team` (`email` ASC);


--
-- Table `ocpizza`.`ingredient_restaurant`
--
CREATE TABLE IF NOT EXISTS `ocpizza`.`ingredient_restaurant` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `available_stock` INT NOT NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  `ingredient_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `restaurant_id`, `ingredient_id`),
  CONSTRAINT `fk_ingredient_restaurant_restaurant_id`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `ocpizza`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingredient_ingredient_ingredient_id`
    FOREIGN KEY (`ingredient_id`)
    REFERENCES `ocpizza`.`ingredient` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `by_ingredient_idx` ON `ocpizza`.`ingredient_restaurant` (`ingredient_id` ASC);

CREATE INDEX `by_restaurant_idx` ON `ocpizza`.`ingredient_restaurant` (`restaurant_id` ASC);


--
-- Table `ocpizza`.`pizza_restaurant`
--
CREATE TABLE IF NOT EXISTS `ocpizza`.`pizza_restaurant` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `available_amount` INT UNSIGNED NOT NULL,
  `pizza_id` INT UNSIGNED NOT NULL,
  `restaurant_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `pizza_id`, `restaurant_id`),
  CONSTRAINT `fk_pizza_restaurant_pizza_id`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `ocpizza`.`pizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizza_restaurant_restaurant_id`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `ocpizza`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `by_restaurant_idx` ON `ocpizza`.`pizza_restaurant` (`restaurant_id` ASC);

CREATE INDEX `by_pizza_idx` ON `ocpizza`.`pizza_restaurant` (`pizza_id` ASC);


-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
