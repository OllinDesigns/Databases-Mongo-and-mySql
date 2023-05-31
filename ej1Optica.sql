-- Level 1 - Exercise 1 - Optics

-- Script to create the database

-- CREATE SCHEMA IF NOT EXISTS `optician` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;

USE `optician`;

-- do I need the script to create the tables?


-- the optician wants to know who is the supplier of each of the glasses. In particular, you want to know about each supplier: 
-- Name, address (street, number, floor, door, city, postal code and country), telephone, fax, NIF.
-- SOLUTION:

SELECT supplier_id, glasses.glass_id, glasses.brand, supplier_name, last_name, street, housenr, floor, door, city, postal_code, country, telephone, fax, nif
FROM supplier
JOIN glasses
	ON supplier.supplier_id = glasses.supplier;
 
 
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
WHERE sale_date BETWEEN '2023-01-01' AND '2023-12-31';


### List the different glasses that an employee has sold during a year.
-- SOLUTION:

SELECT s.sale_id,  g.brand, s.soldby_employee, s.sale_date
FROM optician.sales s
JOIN optician.glasses g ON s.glass_id = g.glass_id
JOIN optician.customers c ON s.soldto_customer = c.customer_id
WHERE s.soldby_employee = 'Delfin Quishpe'
  AND YEAR(s.sale_date) = 2023;
  
  
## List the different suppliers who have supplied glasses sold successfully by the optician.
-- SOLUTION:
  
SELECT s.supplier_id, g.glass_id, g.brand, s.supplier_name, s.last_name, sl.sale_date
FROM optician.supplier s
JOIN optician.glasses g ON s.supplier_id = g.supplier
JOIN optician.sales sl ON g.glass_id = sl.glass_id;



 
