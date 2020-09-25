-- -----------------------------------------------------
-- Schema ocpizza
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ocpizza` ;
USE `ocpizza` ;

-- -----------------------------------------------------
-- Table `ocpizza`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocpizza`.`restaurant` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `adress` VARCHAR(100) NOT NULL,
  `zip_code` VARCHAR(5) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE UNIQUE INDEX `id_UNIQUE` ON `ocpizza`.`restaurant` (`id` ASC);


-- -----------------------------------------------------
-- Table `ocpizza`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocpizza`.`client` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(30) NOT NULL,
  `adress` VARCHAR(100) NULL,
  `zip_code` VARCHAR(5) NULL,
  `phone_number` VARCHAR(10) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE UNIQUE INDEX `id_UNIQUE` ON `ocpizza`.`client` (`id` ASC);


-- -----------------------------------------------------
-- Table `ocpizza`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocpizza`.`order` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NOT NULL,
  `delivery_method` VARCHAR(45) NULL,
  `payment_status` TINYINT NOT NULL,
  `date` DATETIME NOT NULL,
  `total_price` DECIMAL(4,2) NULL,
  `pizza_quantity` INT(2) NULL,
  `pizza_id` INT NOT NULL,
  `pizza_recipe_id` INT NOT NULL,
  `pizza_ingredient_id` INT UNSIGNED NOT NULL,
  `client_id` INT NOT NULL,
  `restaurant_id` INT NOT NULL,
  PRIMARY KEY (`id`, `pizza_id`, `pizza_recipe_id`, `pizza_ingredient_id`, `client_id`, `restaurant_id`),
  CONSTRAINT `fk_order_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `ocpizza`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `ocpizza`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE UNIQUE INDEX `id_UNIQUE` ON `ocpizza`.`order` (`id` ASC);

CREATE INDEX `fk_order_client1_idx` ON `ocpizza`.`order` (`client_id` ASC);

CREATE INDEX `fk_order_restaurant1_idx` ON `ocpizza`.`order` (`restaurant_id` ASC);


-- -----------------------------------------------------
-- Table `ocpizza`.`recipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocpizza`.`recipe` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `content` TEXT(500) NOT NULL,
  `ingredient_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `ingredient_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE UNIQUE INDEX `id_UNIQUE` ON `ocpizza`.`recipe` (`id` ASC);


-- -----------------------------------------------------
-- Table `ocpizza`.`pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocpizza`.`pizza` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(4,2) NOT NULL,
  `recipe_id` INT NOT NULL,
  `order_id` INT UNSIGNED NOT NULL,
  `order_pizza_id` INT NOT NULL,
  `order_pizza_recipe_id` INT NOT NULL,
  `order_pizza_ingredient_id` INT UNSIGNED NOT NULL,
  `order_client_id` INT NOT NULL,
  `recipe_id` INT UNSIGNED NOT NULL,
  `recipe_ingredient_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `recipe_id`, `order_id`, `order_pizza_id`, `order_pizza_recipe_id`, `order_pizza_ingredient_id`, `order_client_id`, `recipe_id`, `recipe_ingredient_id`),
  CONSTRAINT `fk_pizza_recipe`
    FOREIGN KEY (`recipe_ingredient_id`)
    REFERENCES `ocpizza`.`recipe` (`ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE UNIQUE INDEX `id_UNIQUE` ON `ocpizza`.`pizza` (`id` ASC);

CREATE INDEX `fk_pizza_recipe1_idx` ON `ocpizza`.`pizza` (`recipe_ingredient_id` ASC);


-- -----------------------------------------------------
-- Table `ocpizza`.`ingredient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocpizza`.`ingredient` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  `quantity` INT(2) NOT NULL,
  `recipe_id` INT UNSIGNED NOT NULL,
  `recipe_ingredient_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `recipe_id`, `recipe_ingredient_id`),
  CONSTRAINT `fk_ingredient_recipe1`
    FOREIGN KEY (`recipe_id` , `recipe_ingredient_id`)
    REFERENCES `ocpizza`.`recipe` (`id` , `ingredient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE UNIQUE INDEX `id_UNIQUE` ON `ocpizza`.`ingredient` (`id` ASC);

CREATE INDEX `fk_ingredient_recipe1_idx` ON `ocpizza`.`ingredient` (`recipe_id` ASC, `recipe_ingredient_id` ASC);


-- -----------------------------------------------------
-- Table `ocpizza`.`restaurant_has_client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocpizza`.`restaurant_has_client` (
  `restaurant_id` INT NOT NULL,
  `client_id` INT NOT NULL,
  PRIMARY KEY (`restaurant_id`, `client_id`),
  CONSTRAINT `fk_restaurant_has_client_restaurant`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `ocpizza`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurant_has_client_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `ocpizza`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE INDEX `fk_restaurant_has_client_client1_idx` ON `ocpizza`.`restaurant_has_client` (`client_id` ASC);

CREATE INDEX `fk_restaurant_has_client_restaurant_idx` ON `ocpizza`.`restaurant_has_client` (`restaurant_id` ASC);


-- -----------------------------------------------------
-- Table `ocpizza`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocpizza`.`role` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_UNIQUE` ON `ocpizza`.`role` (`id` ASC);


-- -----------------------------------------------------
-- Table `ocpizza`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocpizza`.`user` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(100) NOT NULL,
  `pasword` VARCHAR(50) NOT NULL,
  `role_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `role_id`),
  CONSTRAINT `fk_user_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `ocpizza`.`role` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE UNIQUE INDEX `id_UNIQUE` ON `ocpizza`.`user` (`id` ASC);

CREATE UNIQUE INDEX `username_UNIQUE` ON `ocpizza`.`user` (`username` ASC);

CREATE INDEX `fk_user_role1_idx` ON `ocpizza`.`user` (`role_id` ASC);


-- -----------------------------------------------------
-- Table `ocpizza`.`user_has_restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocpizza`.`user_has_restaurant` (
  `user_id` INT NOT NULL,
  `restaurant_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `restaurant_id`),
  CONSTRAINT `fk_user_has_restaurant_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `ocpizza`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_restaurant_restaurant1`
    FOREIGN KEY (`restaurant_id`)
    REFERENCES `ocpizza`.`restaurant` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE INDEX `fk_user_has_restaurant_restaurant1_idx` ON `ocpizza`.`user_has_restaurant` (`restaurant_id` ASC);

CREATE INDEX `fk_user_has_restaurant_user1_idx` ON `ocpizza`.`user_has_restaurant` (`user_id` ASC);


-- -----------------------------------------------------
-- Table `ocpizza`.`order_has_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ocpizza`.`order_has_pizza` (
  `order_id` INT UNSIGNED NOT NULL,
  `order_pizza_id` INT NOT NULL,
  `order_pizza_recipe_id` INT NOT NULL,
  `order_pizza_ingredient_id` INT UNSIGNED NOT NULL,
  `order_client_id` INT NOT NULL,
  `order_restaurant_id` INT NOT NULL,
  `pizza_id` INT NOT NULL,
  `pizza_recipe_id` INT NOT NULL,
  `pizza_order_id` INT UNSIGNED NOT NULL,
  `pizza_order_pizza_id` INT NOT NULL,
  `pizza_order_pizza_recipe_id` INT NOT NULL,
  `pizza_order_pizza_ingredient_id` INT UNSIGNED NOT NULL,
  `pizza_order_client_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `order_pizza_id`, `order_pizza_recipe_id`, `order_pizza_ingredient_id`, `order_client_id`, `order_restaurant_id`, `pizza_id`, `pizza_recipe_id`, `pizza_order_id`, `pizza_order_pizza_id`, `pizza_order_pizza_recipe_id`, `pizza_order_pizza_ingredient_id`, `pizza_order_client_id`),
  CONSTRAINT `fk_order_has_pizza_order1`
    FOREIGN KEY (`order_id` , `order_pizza_id` , `order_pizza_recipe_id` , `order_pizza_ingredient_id` , `order_client_id` , `order_restaurant_id`)
    REFERENCES `ocpizza`.`order` (`id` , `pizza_id` , `pizza_recipe_id` , `pizza_ingredient_id` , `client_id` , `restaurant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_has_pizza_pizza1`
    FOREIGN KEY (`pizza_id` , `pizza_recipe_id` , `pizza_order_id` , `pizza_order_pizza_id` , `pizza_order_pizza_recipe_id` , `pizza_order_pizza_ingredient_id` , `pizza_order_client_id`)
    REFERENCES `ocpizza`.`pizza` (`id` , `recipe_id` , `order_id` , `order_pizza_id` , `order_pizza_recipe_id` , `order_pizza_ingredient_id` , `order_client_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;
