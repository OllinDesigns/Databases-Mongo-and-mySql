DROP SCHEMA IF EXISTS `optician`;

CREATE SCHEMA IF NOT EXISTS `optician` DEFAULT CHARACTER SET utf8MB4;
USE `optician`;

CREATE TABLE `optician`.`SUPPLIER` (
  `supplier_id` INT NOT NULL AUTO_INCREMENT,
  `supplier_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `street` VARCHAR(50) NOT NULL,
  `housenr` VARCHAR(50) NOT NULL,
  `floor` VARCHAR(10) NULL DEFAULT NULL,
  `door` VARCHAR(10) NULL DEFAULT NULL,
  `city` VARCHAR(50) NOT NULL,
  `postal_code` VARCHAR(50) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  `telephone` VARCHAR(20) NOT NULL,
  `fax` INT NULL DEFAULT NULL,
  `nif` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

INSERT INTO optician.supplier (supplier_name, last_name, street, housenr, floor, door, city, postal_code, country, telephone, fax, nif)
VALUES
  ('Gaz', 'Mawete', 'Freedom Avenue', '10', '1a', '2', 'Kinshasa', 'rw430', 'Democratic Republic of Congo', '9845523', '9845444', '309712'),
  ('Femi', 'Kuti', 'Afrobeat Street', '15', '3', '2', 'Lagos', 'ng110', 'Nigeria', '7358192', '9845555', '408516'),
  ('Angelique', 'Kidjo', 'Soul Avenue', '20', '4b', '1', 'Cotonou', 'bj320', 'Benin', '5632897', '9845666', '510309'),
  ('Salif', 'Keita', 'Mali Road', '8', '2c', '3', 'Bamako', 'ml330', 'Mali', '6785241', '9845777',  '207908');

CREATE TABLE IF NOT EXISTS `optician`.`CUSTOMERS` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `customer_name` VARCHAR(45) NOT NULL,
  `customer_postcode` VARCHAR(10) NOT NULL,
  `customer_phone` VARCHAR(45) NOT NULL,
  `customer_email` VARCHAR(45) NOT NULL,
  `customer_registrationdate` DATE NOT NULL,
  `recomendedby` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;

INSERT INTO optician.customers (customer_name, customer_postcode, customer_phone, customer_email, customer_registrationdate, recomendedby)
VALUES
('Wilfried Zaha', '23800', '6223385', 'wilfridozaha@gmail.com', '2018-03-05', 'Munnira Katongole'),
('Franck Kessie', '16400', '6403360', 'elkessie@gmail.com', '2019-04-14', ''),
('Mohamed Salah', '23800', '6223385', 'salah@example.com', '2018-03-05', 'Sadio Mané'),
('Sadio Mané', '16400', '6403360', 'mane@example.com', '2019-04-14', ''),
('Pierre-Emerick Aubameyang', '12345', '5551234', 'aubameyang@example.com', '2020-01-01', 'Kalidou Koulibaly'),
('Riyad Mahrez', '54321', '5554321', 'mahrez@example.com', '2020-02-02', ''),
('Hakim Ziyech', '98765', '5559876', 'ziyech@example.com', '2020-03-03', 'Albert Okocha'),
('Thomas Partey', '24680', '5552468', 'partey@example.com', '2020-04-04', 'Sadio Mané'),
('Kalidou Koulibaly', '13579', '5551357', 'koulibaly@example.com', '2020-05-05', 'Zoneziwoh Mbondgulo-Wondieh'),
('Glanis Changachirere', '97531', '5559753', 'changachirere@example.com', '2020-06-06', 'Alex Iwobi'),
('Albert Okocha', '86420', '5558642', 'zaha@example.com', '2020-07-07', ''),
('Alex Iwobi', '75309', '5557530', 'iwobi@example.com', '2020-08-08', ''),
('Eric Bailly', '59287', '5555928', 'bailly@example.com', '2020-09-09', ''),
('Zoneziwoh Mbondgulo-Wondieh', '48176', '5554817', 'mbondgulo@example.com', '2020-10-10', 'Wilfried Zaha'),
('Naby Keita', '37065', '5553706', 'keita@example.com', '2020-11-11', ''),
('Munnira Katongole', '26954', '5552695', 'katongole@example.com', '2020-12-12', ''),
('Farida Charity', '15843', '5551584', 'farida@example.com', '2021-01-01', 'Zoneziwoh Mbondgulo-Wondieh');

CREATE TABLE IF NOT EXISTS `optician`.`GLASSES` (
  `glass_id` INT NOT NULL AUTO_INCREMENT,
  `brand` VARCHAR(30) NOT NULL,
  `supplier` INT NOT NULL,
  `graduation` VARCHAR(45) NOT NULL,
  `frame_type` VARCHAR(45) NOT NULL,
  `frame_color` VARCHAR(45) NOT NULL,
  `glass_color` VARCHAR(45) NOT NULL,
  `price` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`glass_id`),
  INDEX `getSupplier_idx` (`supplier` ASC) VISIBLE,
  CONSTRAINT `getSupplier`
    FOREIGN KEY (`supplier`)
    REFERENCES `optician`.`SUPPLIER` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

INSERT INTO optician.glasses (brand, supplier, graduation, frame_type, frame_color, glass_color, price)
VALUES
  ('Ray-Ban', '11', '23.2', 'paste frame', 'red', 'transparent', '50.50'),
  ('Oakley', '12', '15.2', 'metallic frame', 'orange', 'pink', '88.9'),
  ('Gucci', '13', '18.5', 'floating frame', 'black', 'gray', '120.00'),
  ('Fendi', '14', '21.7', 'paste frame', 'purple', 'brown', '95.75'),
  ('Ray-Ban', '11', '20.3', 'floating frame', 'blue', 'green', '110.25'),
  ('Oakley', '12', '18.9', 'metallic frame', 'silver', 'gray', '75.50'),
  ('Gucci', '13', '16.4', 'paste frame', 'brown', 'brown', '95.00'),
  ('Fendi', '14', '22.1', 'floating frame', 'gold', 'yellow', '135.00'),
  ('Ray-Ban', '11', '19.6', 'metallic frame', 'black', 'gray', '99.99'),
  ('Oakley', '12', '17.8', 'paste frame', 'white', 'transparent', '70.50');

CREATE TABLE IF NOT EXISTS `optician`.`SALES` (
  `sale_id` INT NOT NULL AUTO_INCREMENT,
  `sale_date` DATE NOT NULL,
  `soldby_employee` VARCHAR(45) NOT NULL,
  `soldto_customer` INT NOT NULL,
  `glass_id` INT NULL,
  PRIMARY KEY (`sale_id`),
  INDEX `getItem_idx` (`glass_id` ASC) VISIBLE,
  INDEX `soldTo_idx` (`soldto_customer` ASC) VISIBLE,
  CONSTRAINT `glassId`
    FOREIGN KEY (`glass_id`)
    REFERENCES `optician`.`GLASSES` (`glass_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `soldTo`
    FOREIGN KEY (`soldto_customer`)
    REFERENCES `optician`.`CUSTOMERS` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
  
  INSERT INTO optician.sales (sale_date, soldby_employee, soldto_customer, glass_id)
VALUES
  ('2019-06-20', 'Paula Gomez', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2022-05-28', 'Immanuel Kant', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2021-11-11', 'Delfin Quishpe', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2019-06-20', 'Paula Gomez', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2022-05-28', 'Immanuel Kant', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2021-11-11', 'Delfin Quishpe', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2019-06-20', 'Paula Gomez', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2022-05-28', 'Immanuel Kant', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2021-11-11', 'Delfin Quishpe', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2019-06-20', 'Paula Gomez', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2022-05-28', 'Immanuel Kant', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2021-11-11', 'Delfin Quishpe', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2019-06-20', 'Paula Gomez', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2022-05-28', 'Immanuel Kant', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2021-11-11', 'Delfin Quishpe', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2019-06-20', 'Paula Gomez', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2022-05-28', 'Immanuel Kant', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2021-11-11', 'Delfin Quishpe', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2019-06-20', 'Paula Gomez', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2022-05-28', 'Immanuel Kant', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2021-11-11', 'Delfin Quishpe', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2019-06-20', 'Paula Gomez', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2022-05-28', 'Immanuel Kant', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2021-11-11', 'Delfin Quishpe', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2019-06-20', 'Paula Gomez', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2022-05-28', 'Immanuel Kant', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2021-11-11', 'Delfin Quishpe', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2019-06-20', 'Paula Gomez', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2022-05-28', 'Immanuel Kant', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2021-11-11', 'Delfin Quishpe', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2019-06-20', 'Paula Gomez', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2022-05-28', 'Immanuel Kant', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7)),
  ('2021-11-11', 'Delfin Quishpe', FLOOR(1 + RAND() * 17), FLOOR(11 + RAND() * 7));
  
  # This is what is asked by the 'entrega'

### List the total purchases of a customer.

SELECT c.customer_id, c.customer_name, COUNT(*) AS 'total purchases of made by a customer'
FROM optician.customers c
JOIN optician.sales s ON c.customer_id = s.soldto_customer
WHERE c.customer_id = 11
GROUP BY c.customer_id, c.customer_name;

### List the different glasses that an employee has sold during a year.
-- SOLUTION:

SELECT s.sale_id,  g.brand AS 'these are the glasses than Mr Quishpe sold in 2021', s.soldby_employee, s.sale_date
FROM optician.sales s
JOIN optician.glasses g ON s.glass_id = g.glass_id
JOIN optician.customers c ON s.soldto_customer = c.customer_id
WHERE s.soldby_employee = 'Delfin Quishpe'
  AND YEAR(s.sale_date) = 2021;
  
  
## List the different suppliers who have supplied glasses sold successfully by the optician.
-- SOLUTION:
  
SELECT s.supplier_id, g.glass_id, g.brand, s.supplier_name AS 'These suppliers supplied glasses that were sold', s.last_name, sl.sale_date
FROM optician.supplier s
JOIN optician.glasses g ON s.supplier_id = g.supplier
JOIN optician.sales sl ON g.glass_id = sl.glass_id;
  
  -- The optician's purchasing policy is that glasses of one brand will be bought from a single supplier (so you can get more good prices out of them), 
-- but they can buy glasses of several brands from one supplier. He wants to know about the glasses: The brand, the graduation of each of the glasses,
-- the type of frame (floating, paste or metallic), the color of the frame, the color of each glass, the price.
-- SOLUTION: This query joins the supplier_id with the columns of the glasses table that provide this infos.

SELECT glasses.glass_id, supplier_id, glasses.brand, glasses.graduation, glasses.frame_type, glasses.frame_color, glasses.glass_color , glasses.price
FROM glasses
JOIN supplier
	ON glasses.supplier = supplier.supplier_id;


-- Of the customers you want to store: 
### Name, postal address, telephone, email, registration date.
### When a new customer arrives, store the customer who has been recommended by the establishment (as long as someone has recommended it).
-- SOLUTION: This query gets this infos from the customers table

SELECT customer_id, customer_name, customer_postcode, customer_email, customer_registrationdate, recomendedby
FROM customers;


### Our system must indicate who was the employee who sold each pair of glasses.
-- SOLUTION: 

SELECT s.sale_id, s.glass_id, g.brand, c.customer_name, c.customer_id, s.sale_date, s.soldby_employee
FROM optician.sales s
JOIN optician.glasses g ON s.glass_id = g.glass_id
JOIN optician.customers c ON s.soldto_customer = c.customer_id;


### Defines a sales time period. 
-- SOLUTION:

SELECT *
FROM optician.sales
WHERE sale_date BETWEEN '2021-01-01' AND '2021-12-31';
