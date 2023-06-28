DROP SCHEMA IF EXISTS pizzeria;

CREATE DATABASE IF NOT EXISTS pizzeria DEFAULT CHARACTER SET utf8MB4;
USE pizzeria;

CREATE TABLE IF NOT EXISTS `pizzeria`.`categories` (
  `cat_id` INT NOT NULL AUTO_INCREMENT,
  `cat_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cat_id`),
  UNIQUE INDEX `cat_name_UNIQUE` (`cat_name` ASC) VISIBLE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`customer` (
  `customer_id` INT NOT NULL,
  `customer_name` VARCHAR(45) NOT NULL,
  `customer_surname` VARCHAR(45) NOT NULL,
  `customer_address` VARCHAR(80) NOT NULL,
  `customer_postalcode` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NOT NULL,
  `customer_phone` VARCHAR(45) NOT NULL,
  `active_order` ENUM('yes', 'no') NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) INVISIBLE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`store` (
  `store_id` INT NOT NULL,
  `store_name` VARCHAR(45) NOT NULL,
  `store_address` VARCHAR(45) NOT NULL,
  `store_postcode` VARCHAR(45) NOT NULL,
  `store_town` VARCHAR(45) NOT NULL,
  `province` VARCHAR(45) NULL,
  PRIMARY KEY (`store_id`),
  UNIQUE INDEX `store_id_UNIQUE` (`store_id` ASC) VISIBLE
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`employee` (
  `employee_id` INT NOT NULL,
  `employee_name` VARCHAR(45) NOT NULL,
  `employee_lastname` VARCHAR(45) NOT NULL,
  `employee_nif` VARCHAR(45) NOT NULL,
  `employee_phone` VARCHAR(45) NOT NULL,
  `employee_position` ENUM('cook', 'delivery person') NOT NULL,
  `employee_store` INT NOT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE INDEX `employee_id_UNIQUE` (`employee_id` ASC) VISIBLE,
  INDEX `store_id_idx` (`employee_store` ASC) VISIBLE,
  CONSTRAINT `store_id`
    FOREIGN KEY (`employee_store`)
    REFERENCES `pizzeria`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`products` (
  `product_id` INT NOT NULL,
  `product_name` VARCHAR(45) NOT NULL,
  `product_description` VARCHAR(100) NOT NULL,
  `product_image` VARCHAR(45) NOT NULL,
  `product_price` DECIMAL(6,3) NOT NULL,
  `product_category` INT NULL,
  `is_pizza` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`product_id`),
  INDEX `product_category_idx` (`product_category` ASC) VISIBLE,
  CONSTRAINT `product_category_id`
    FOREIGN KEY (`product_category`)
    REFERENCES `pizzeria`.`categories` (`cat_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `pizzeria`.`orders` (
  `order_id` INT NOT NULL,
  `order_total_price` DECIMAL(6,3),
  `quantity_of_products` INT,
  `order_by_customer` INT NOT NULL,
  `order_by_store` INT NOT NULL,
  `order_for_delivery` VARCHAR(45) NOT NULL, -- true or false
  `delivery_employee` INT NULL,
  `delivery_datetime` DATETIME NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  UNIQUE INDEX `orderByCustomer_idx` (`order_by_customer` ASC) VISIBLE,
  INDEX `orderByStore_idx` (`order_by_store` ASC) VISIBLE,
  INDEX `deliver_idx` (`delivery_employee` ASC) VISIBLE,
  CONSTRAINT `orderByCustomer`
    FOREIGN KEY (`order_by_customer`)
    REFERENCES `pizzeria`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `orderByStore`
    FOREIGN KEY (`order_by_store`)
    REFERENCES `pizzeria`.`store` (`store_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `deliver`
    FOREIGN KEY (`delivery_employee`)
    REFERENCES `pizzeria`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `check_delivery_employee`
    CHECK (
      (order_for_delivery = 'false' AND delivery_employee IS NULL) OR
      (order_for_delivery = 'true' AND delivery_employee IS NOT NULL)
    )
)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `pizzeria`.`ordered_items` (
  `orderedItems_id` INT NOT NULL,
  `orders_orderId` INT NOT NULL,
  `orderedItems_productId` INT NOT NULL,
  `orderedItems_productPrice` DECIMAL(6,3),
  `orderedItems_productquantity` INT,
  `orderedItems_priceByProductQuantity` DECIMAL(6,3),
  PRIMARY KEY (`orderedItems_id`),
  INDEX `productId_idx` (`orderedItems_productId` ASC) VISIBLE,
  INDEX `orderIdFromOrders_idx` (`orders_orderId` ASC) VISIBLE,
  CONSTRAINT `productId`
    FOREIGN KEY (`orderedItems_productId`)
    REFERENCES `pizzeria`.`products` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `orderIdFromOrders`
    FOREIGN KEY (`orders_orderId`)
    REFERENCES `pizzeria`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

DELIMITER $$

-- TRIGGER_INSERT_ORDERED_ITEMS
CREATE TRIGGER `pizzeria`.`trigger_insert_ordered_items` 
BEFORE INSERT ON `pizzeria`.`ordered_items`
FOR EACH ROW
BEGIN
  -- Update the price of the ordered item based on the product price
  SET NEW.orderedItems_productPrice = (
    SELECT product_price
    FROM PRODUCTS
    WHERE product_id = NEW.orderedItems_productId
  );
  
  -- Update the price by product quantity
  SET NEW.orderedItems_priceByProductQuantity = NEW.orderedItems_productPrice * NEW.orderedItems_productquantity;
  
  -- Update the total price of the order
  -- UPDATE ORDERS
  -- SET order_total_price = IFNULL(order_total_price, 0) + NEW.orderedItems_priceByProductQuantity
  -- WHERE order_id = NEW.orders_orderId;
END$$

-- TRIGGER_UPDATE_ORDERED_ITEMS
CREATE TRIGGER `pizzeria`.`trigger_update_ordered_items`
AFTER INSERT ON `pizzeria`.`ordered_items`
FOR EACH ROW
BEGIN
  DECLARE total_price DECIMAL(6,3);

  SELECT SUM(products.product_price * NEW.orderedItems_productquantity) -- Multiply the price by the quantity
  INTO total_price
  FROM products
  WHERE products.product_id = NEW.orderedItems_productId;

  -- UPDATE ORDERS
  -- SET order_total_price = IFNULL(order_total_price, 0) + total_price
  -- WHERE order_id = NEW.orders_orderId;
END$$

-- Trigger to check delivery employee position
CREATE TRIGGER `pizzeria`.`check_delivery_employee_position`
BEFORE INSERT ON `pizzeria`.`orders`
FOR EACH ROW
BEGIN
  DECLARE employee_position ENUM('cook', 'delivery person');
  
  SELECT employee_position INTO employee_position
  FROM `pizzeria`.`employee`
  WHERE `employee_id` = NEW.delivery_employee;
  
  IF employee_position != 'delivery person' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid delivery employee position';
  END IF;
END$$

DELIMITER ;


INSERT INTO `pizzeria`.`categories` (`cat_name`) VALUES 
('Pizzas'),
('Hamburgers'),
('Drinks');

INSERT INTO `pizzeria`.`customer` (`customer_id`, `customer_name`, `customer_surname`, `customer_address`, `customer_postalcode`, `city`, `province`, `customer_phone`, `active_order` ) VALUES 
('001', 'Fulgencio', 'Pantana', 'Oak Street 23', '18001', 'Nairobi', 'NBI', '2505334', 'YES' ),
('002', 'Munnira', 'Katongole', 'Eucalypt Road 666', '23004', 'Kisumu', 'KSM', '644937898', 'NO' ),
('003', 'Zoneziwoh', 'Mbondgulo-Wondieh', 'Bonsai Avenue 69', '43002', 'Akure', 'Ondo', '46497898', 'NO' ),
('004', 'Aisha', 'Abdullahi', 'Palm Grove 12', '76009', 'Lagos', 'Lagos', '123456789', 'YES'),
('005', 'John', 'Smith', 'Maple Lane 45', '98002', 'Seattle', 'Washington', '987654321', 'NO'),
('006', 'Maria', 'Gonzalez', 'Cedar Street 78', '10001', 'New York', 'New York', '555123456', 'YES'),
('007', 'Satoshi', 'Nakamoto', 'Bitcoin Avenue 1', '12345', 'Tokyo', 'Tokyo', '999888777', 'NO'),
('008', 'Lila', 'Chopra', 'Rosewood Drive 30', '56001', 'Mumbai', 'Maharashtra', '111222333', 'YES'),
('009', 'Alex', 'Johnson', 'Pine Street 99', '90210', 'Los Angeles', 'California', '777666555', 'NO'),
('010', 'Sophie', 'Lefebvre', 'Rue de Paris 7', '75001', 'Paris', 'Île-de-France', '333444555', 'YES'),
('011', 'Muhammad', 'Ali', 'Boulevard 45', '20001', 'Cairo', 'Cairo', '666555444', 'NO'),
('012', 'Elena', 'Ivanova', 'Red Square 1', '101000', 'Moscow', 'Moscow', '888999111', 'YES'),
('013', 'Diego', 'Fernandez', 'Avenida del Sol 123', '28001', 'Madrid', 'Madrid', '222333444', 'NO'),
('014', 'Fatima', 'Mohammed', 'Oasis Road 8', '41001', 'Riyadh', 'Riyadh', '777333888', 'YES'),
('015', 'Hiroshi', 'Tanaka', 'Sakura Street 21', '100-0001', 'Tokyo', 'Tokyo', '999111222', 'NO'),
('016', 'Isabella', 'Martinez', 'Vineyard Lane 65', '90001', 'Los Angeles', 'California', '666777888', 'YES'),
('017', 'Luca', 'Bianchi', 'Via Roma 10', '20121', 'Milan', 'Lombardy', '111222333', 'NO'),
('018', 'Liam', 'Johnson', 'Maple Avenue 3', '10001', 'New York', 'New York', '555666777', 'YES'),
('019', 'Emilia', 'Andersson', 'Birch Street 8', '113 57', 'Stockholm', 'Stockholm', '999888777', 'NO'),
('020', 'Ahmed', 'Saeed', 'Sheikh Zayed Road 55', '12345', 'Dubai', 'Dubai', '777666555', 'YES');

INSERT INTO `pizzeria`.`store` (`store_id`, `store_name`, `store_address`, `store_postcode`, `store_town`, `province` ) VALUES 
('001', 'Cheesy Times Nairobi', 'Camel Street 96', '18099', 'Nairobi', 'NBI'),
('002', 'Cheesy Times Tokyo', 'Yakuza Street 777', '12345', 'Tokyo', 'Tokyo');

INSERT INTO `pizzeria`.`employee` (`employee_id`, `employee_name`, `employee_lastname`, `employee_nif`, `employee_phone`, `employee_position`, `employee_store`) VALUES 
('002', 'Amadou', 'Diop', '20099807', '2255336', 'cook', '1'),
('003', 'Amina', 'Ba', '21088907', '2362057', 'cook', '1'),
('004', 'Moussa', 'Gueye', '22079808', '2462068', 'delivery person', '1'),
('005', 'Rama', 'Kane', '23069908', '2562079', 'delivery person', '1'),
('006', 'Ibrahim', 'Ndiaye', '24060009', '2662080', 'delivery person', '1'),
('007', 'Julia', 'Smith', '25050109', '2762091', 'cook', '2'),
('008', 'Liam', 'Johnson', '26040209', '2862102', 'cook', '2'),
('009', 'Emma', 'Garcia', '27030310', '2962113', 'delivery person', '2'),
('010', 'Oliver', 'Martinez', '28020410', '3062124', 'delivery person', '2'),
('011', 'Sophia', 'Lee', '29010510', '3162135', 'delivery person', '2');

INSERT INTO `pizzeria`.`products` (`product_id`, `product_name`, `product_description`, `product_image`, `product_price`, `product_category`, `is_pizza`) VALUES 
('001', 'Extra Cheesy Delight', 'a very cheesy pizza', 'C:\Users\Bastet\Pictures\Camera Roll\cheesy1.png', '7.50', '1', '1'),
('002', 'Cheesy Supreme', 'A pizza loaded with an assortment of cheesy toppings', 'C:\path\to\cheesy_supreme.png', '9.99', '1', '1'),
('003', 'Ultimate Cheesy Delight', 'Indulge in the ultimate cheesy experience with this pizza', 'C:\path\to\ultimate_cheesy_delight.png', '8.99', '1', '1'),
('004', 'Cheesy Heaven', 'A heavenly combination of cheeses on this pizza', 'C:\path\to\cheesy_heaven.png', '7.99', '1', '1'),
('005', 'Cheesy Feast', 'A delightful feast of cheesy goodness on this pizza', 'C:\path\to\cheesy_feast.png', '8.49', '1', '1'),
('006', 'Cheesylicious', 'Experience the liciousness of this incredibly cheesy pizza', 'C:\path\to\cheesylicious.png', '9.49', '1', '1'),
('007', 'Cheesy Beef Burger', 'A mouthwatering beef burger with a cheesy twist', 'C:\path\to\cheesy_beef_burger.png', '6.99', '2', '0'),
('008', 'Double Cheesy Burger', 'Two juicy patties and extra cheese make this burger extra delicious', 'C:\path\to\double_cheesy_burger.png', '7.99', '2', '0'),
('009', 'Cheesy Chicken Burger', 'A cheesy delight featuring tender chicken and melted cheese', 'C:\path\to\cheesy_chicken_burger.png', '6.49', '2', '0'),
('010', 'Cheesy Veggie Burger', 'A vegetarian-friendly option with a cheesy burst of flavors', 'C:\path\to\cheesy_veggie_burger.png', '5.99', '2', '0'),
('011', 'Cheesy Beer', 'A cheesy flavored beer for cheese and beer lovers', 'C:\path\to\cheesy_beer.png', '4.99', '3', '0'),
('012', 'Cheesy Beer Deluxe', 'A deluxe version of cheesy beer with extra flavors', 'C:\path\to\cheesy_beer_deluxe.png', '5.99', '3', '0'),
('013', 'Impaled IPA', 'A hoppy and cheesy IPA beer for beer enthusiasts', 'C:\path\to\impaled_ipa.png', '6.49', '3', '0'),
('014', 'Cheesy Cocktail', 'A cheesy twist on a classic cocktail', 'C:\path\to\cheesy_cocktail.png', '7.99', '3', '0'),
('015', 'Cheesy Cocktail Surprise', 'A surprising blend of cheesy flavors in a cocktail', 'C:\path\to\cheesy_cocktail_surprise.png', '8.49', '3', '0'),
('016', 'Cheesy Long Drink', 'A long drink with a delightful cheesy touch', 'C:\path\to\cheesy_long_drink.png', '6.99', '3', '0'),
('017', 'Cheesy Long Drink Refresh', 'A refreshing long drink with a cheesy twist', 'C:\path\to\cheesy_long_drink_refresh.png', '7.49', '3', '0'),
('018', 'Cheesy Soft Drink', 'A soft drink with a cheesy flavor combination', 'C:\path\to\cheesy_soft_drink.png', '3.99', '3', '0'),
('019', 'Cheesy Soft Drink Burst', 'A burst of cheesy goodness in a fizzy soft drink', 'C:\path\to\cheesy_soft_drink_burst.png', '4.49', '3', '0'),
('020', 'Cheesy Soft Drink Twist', 'A twisted blend of cheesy flavors in a soft drink', 'C:\path\to\cheesy_soft_drink_twist.png', '4.49', '3', '0');

INSERT INTO `pizzeria`.`orders` (`order_id`, `order_total_price`, `quantity_of_products`, `order_by_customer`, `order_by_store`, `order_for_delivery`, `delivery_employee`, `delivery_datetime`) VALUES 
  ('001', 45.22, '4', '3', '1', 'true', '4', '2020-05-17 00:00:00'),
  ('002', 72.50, '2', '8', '2', 'false', NULL, '2021-08-10 10:30:00'),
  ('003', 18.90, '3', '12', '1', 'true', '7', '2022-03-05 15:45:00'),
  ('004', 54.75, '5', '5', '2', 'true', '6', '2022-11-21 18:15:00'),
  ('005', 36.80, '1', '18', '1', 'false', NULL, '2023-01-02 09:00:00'),
  ('006', 92.10, '4', '15', '2', 'true', '8', '2023-04-17 16:30:00'),
  ('007', 68.40, '2', '7', '1', 'true', '5', '2023-05-30 12:45:00'),
  ('008', 26.70, '3', '2', '2', 'false', NULL, '2023-06-05 14:20:00'),
  ('009', 81.90, '5', '10', '1', 'true', '3', '2023-06-07 19:00:00'),
  ('010', 42.60, '1', '19', '2', 'false', NULL, '2023-06-08 11:10:00'),
  ('011', 64.35, '3', '14', '1', 'true', '4', '2022-07-15 13:30:00'),
  ('012', 38.50, '4', '6', '2', 'false', NULL, '2022-09-28 17:20:00'),
  ('013', 72.80, '2', '9', '1', 'true', '7', '2023-02-19 11:45:00'),
  ('014', 53.90, '5', '11', '2', 'true', '6', '2023-04-06 20:10:00'),
  ('015', 19.75, '1', '4', '2', 'false', NULL, '2023-01-15 08:40:00'),
  ('016', 89.20, '4', '16', '1', 'true', '8', '2023-05-10 15:15:00'),
  ('017', 61.60, '2', '13', '2', 'true', '5', '2023-05-25 11:30:00'),
  ('018', 28.90, '3', '1', '1', 'false', NULL, '2023-06-01 08:00:00');

INSERT INTO `pizzeria`.`ordered_items` (`orderedItems_id`, `orders_orderId`, `orderedItems_productId`, `orderedItems_productquantity`) VALUES
  ('001', '001', '18', '4'),
  ('002', '001', '2', '4'),
  ('003', '001', '13', '4'),
  ('004', '001', '14', '4'),
  ('005', '002', '1', '2'),
  ('006', '002', '2', '2'),
  ('007', '003', '1', '3'),
  ('008', '003', '2', '3'),
  ('009', '003', '3', '3'),
  ('010', '004', '1', '5'),
  ('011', '004', '12', '5'),
  ('012', '004', '13', '5'),
  ('013', '004', '14', '5'),
  ('014', '004', '5', '5'),
  ('015', '005', '14', '1'),
  ('016', '006', '8', '4'),
  ('017', '006', '7', '4'),
  ('018', '006', '9', '4'),
  ('019', '006', '10', '4'),
  ('020', '007', '1', '2'),
  ('021', '007', '12', '2'),
  ('022', '008', '11', '3'),
  ('023', '008', '17', '3'),
  ('024', '008', '3', '3'),
  ('025', '009', '1', '5'),
  ('026', '009', '2', '5'),
  ('027', '009', '3', '5'),
  ('028', '009', '4', '5'),
  ('029', '009', '5', '5'),
  ('030', '010', '1', '1'),
  ('031', '011', '3', '3'),
  ('032', '011', '4', '3'),
  ('033', '011', '5', '3'),
  ('035', '012', '7', '4'),
  ('036', '012', '8', '4'),
  ('037', '012', '9', '4'),
  ('038', '012', '10', '4'),
  ('039', '013', '11', '2'),
  ('040', '013', '12', '2'),
  ('041', '013', '13', '2'),
  ('042', '014', '14', '5'),
  ('043', '014', '15', '5'),
	('044', '014', '14', '5'),
  ('045', '014', '15', '5'),
	('046', '014', '13', '5'),
  ('047', '015', '16', '1'),
  ('048', '016', '3', '4'),
  ('049', '016', '14', '4'),
  ('050', '016', '5', '4'),
  ('051', '016', '16', '4'),
  ('052', '017', '7', '2'),
  ('053', '017', '18', '2'),
  ('054', '018', '9', '3'),
  ('055', '018', '10', '3'),
  ('056', '018', '16', '3');
  
-- Delivery Exercise
  
-- ## List how many products of type "Beverages". have been sold in a certain locality.

SELECT COUNT(*) AS 'total drinks sold in CheesyTimes Nairobi'
FROM ordered_items oi
JOIN products p ON oi.orderedItems_productId = p.product_id
JOIN categories c ON p.product_category = c.cat_id
JOIN orders o ON oi.orders_orderId = o.order_id
WHERE c.cat_id = 3 AND o.order_by_store = 1;
     
-- ## List how many orders a certain employee has made.

SELECT e.employee_name, e.employee_lastname,
COUNT(*) AS 'oders sold by this employee'
FROM orders o
JOIN employee e ON o.delivery_employee = e.employee_id
WHERE e.employee_id = 4 AND o.delivery_employee = 4;
