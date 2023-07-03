-- 1. List the name of all the products in the product table.
SELECT nombre FROM producto;

-- 2. List the names and prices of all the products in the product table
SELECT nombre, precio FROM producto;

-- 3. List all columns of the product table.
SELECT * FROM producto;

-- 4.  List the name of the products, the price in euros and the price in US dollars (USD).
SELECT 
  p.nombre AS product_name, 
  p.precio AS price_eur, 
  (p.precio * exchange_rate.rate) AS price_usd
FROM 
  producto p
CROSS JOIN 
  (SELECT 1.2 AS rate) AS exchange_rate;
  
-- 5. List the name of the products, the price in euros and the price in US dollars (USD). Use the following aliases for the columns: product name, euros, dollars.
SELECT 
  p.nombre AS 'product name', 
  p.precio AS 'euros', 
  (p.precio * exchange_rate.rate) AS 'dollars'
FROM 
  producto p
CROSS JOIN 
  (SELECT 1.2 AS rate) AS exchange_rate;

-- 6. List the names and prices of all products in the product table, converting the names to uppercase.
SELECT UPPER(nombre) AS product_name, precio
FROM producto;

-- 7. List the names and prices of all products in the product table, converting the names to lowercase.
SELECT LOWER(nombre) AS product_name, precio
FROM producto;

-- 8. List the name of all manufacturers in one column, and in another column capitalize the first two characters of the manufacturer's name.
SELECT nombre AS manufacturer_name, CONCAT(UCASE(LEFT(nombre, 2)), SUBSTRING(nombre, 3)) AS capitalized_name
FROM fabricante;

-- 9 . List the names and prices of all products in the product table, rounding the price value.
SELECT nombre AS product_name, ROUND(precio) AS rounded_price
FROM producto;

-- 10. Lists the names and prices of all products in the product table, truncating the price value to display it without any decimal places.
SELECT nombre AS product_name, TRUNCATE(precio, 0) AS truncated_price
FROM producto;

-- 11. List the code of the manufacturers that have products in the product table.
SELECT codigo_fabricante 
FROM producto;

-- 12. List the code of the manufacturers that have products in the product table, eliminating the codes that appear repeatedly.
SELECT DISTINCT codigo_fabricante 
FROM producto;

-- 13.
SELECT nombre AS manufacturer_name
FROM fabricante
ORDER BY nombre ASC;

-- 14.
SELECT nombre AS manufacturer_name
FROM fabricante
ORDER BY nombre DESC;

-- 15. Lists product names sorted first by name in ascending order and second by price in descending order.
SELECT nombre AS product_name, precio AS product_price
FROM producto
ORDER BY nombre ASC, product_price DESC;

-- 16. Returns a list with the first 5 rows of the manufacturer table.
SELECT *
FROM fabricante
LIMIT 5;

-- 17. Returns a list with 2 rows starting from the fourth row of the manufacturer table. The fourth row must also be included in the answer.
SELECT *
FROM fabricante
LIMIT 3, 2;

-- 18. List the cheapest product name and price. (Use only the ORDER BY and LIMIT clauses). NOTE: I could not use MIN(price) here, I would need GROUP BY.
SELECT nombre AS product_name, precio AS product_price
FROM producto
GROUP BY product_name, product_price
ORDER BY product_price ASC
LIMIT 1;


-- 19. List the name and price of the most expensive product. (Use only the ORDER BY and LIMIT clauses). NOTE: I could not use MAX(price) here, I would need GROUP BY.
SELECT nombre AS product_name, precio AS product_price
FROM producto
GROUP BY product_name, product_price
ORDER BY product_price DESC
LIMIT 1;

-- 20. List the name of all products from the manufacturer whose manufacturer code is equal to 2.
SELECT producto.nombre AS 'product name', producto.codigo_fabricante AS 'manufacturer code'
FROM producto
WHERE codigo_fabricante = 2;

-- 21. Returns a list with the product name, price, and manufacturer name of all products in the database.
SELECT producto.codigo AS 'product_id', producto.nombre AS 'product name', producto.precio AS 'product price', fabricante.nombre AS 'manufacturer name'
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- 22. Returns a list with the product name, price, and manufacturer name of all products in the database. Sort the result by manufacturer name, in alphabetical order.
SELECT producto.codigo AS 'product_id', producto.nombre AS 'product name', producto.precio AS 'product price', fabricante.nombre AS 'manufacturer name'
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
ORDER BY fabricante.nombre ASC;

-- 23. Returns a list with the product code, product name, manufacturer code, and manufacturer name of all products in the database.
SELECT producto.codigo AS 'product code', producto.nombre AS 'product name', fabricante.codigo AS 'manufacturer code', fabricante.nombre AS 'manufacturer name'
FROM producto
JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

-- 24. Returns the name of the product, its price and the name of its manufacturer, of the cheapest product.
SELECT p.nombre AS product_name, p.precio AS product_price, f.nombre AS manufacturer_name
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio = (
  SELECT MIN(precio)
  FROM producto
);

-- 25. Returns the name of the product, its price and the name of its manufacturer, of the most expensive product.
SELECT p.nombre AS product_name, p.precio AS product_price, f.nombre AS manufacturer_name
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE p.precio = (
  SELECT MAX(precio)
  FROM producto
);

-- 26. returns a list of all products from manufacturer Lenovo.
SELECT *
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Lenovo';

-- 27. Returns a list of all products from manufacturer Crucial that have a price greater than €200.
SELECT p.nombre AS product_name, p.precio AS product_price
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Crucial' AND p.precio > 200;

-- 28. Returns a list with all the products of the manufacturers Asus, Hewlett-Packard and Seagate. Without using the IN operator.
SELECT p.nombre AS product_name, p.precio AS product_price, f.nombre AS manufacturer_name
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';

-- 29. eturns a list with all the products of the manufacturers Asus, Hewlett-Packard and Seagate. Using the IN operator.
SELECT p.nombre AS product_name, f.nombre AS manufacturer_name
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre IN ('Asus',  'Hewlett-Packard',  'Seagate');

-- 30. Returns a list with the name and price of all products from manufacturers whose name ends with the vowel e.
SELECT p.nombre AS product_name, p.precio AS product_price, f.nombre AS 'manufacturers name that ends with e'
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre REGEXP 'e$';

-- 31. Returns a list with the name and price of all products whose manufacturer name contains the character w in their name.
SELECT p.nombre AS product_name, p.precio AS product_price, f.nombre AS 'manufacturers name with w'
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE f.nombre REGEXP 'w';

-- 32. Returns a list with the product name, price and manufacturer name, of all products that have a price greater than or equal to €180. Sort the result first by price (in descending order) and second by name (in ascending order).
SELECT f.codigo AS 'manufacturers code', f.nombre AS 'manufacturers name '
FROM fabricante f
JOIN f ON p.codigo_fabricante = f.codigo
WHERE  p.precio >= 180
ORDER BY p.precio DESC, p.nombre ASC;

-- 33. Returns a list with the manufacturer's code and name, only of those manufacturers that have associated products in the database.
SELECT DISTINCT f.codigo AS manufacturer_code, f.nombre AS manufacturer_name
FROM fabricante f
JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 34. Returns a list of all the manufacturers that exist in the database, along with the products that each of them has. The list must also show those manufacturers that do not have associated products.
SELECT f.codigo AS manufacturer_code, f.nombre AS manufacturer_name, p.nombre AS product_name
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 35. Returns a list showing only those manufacturers that do not have any associated products.
SELECT f.codigo AS manufacturer_code, f.nombre AS manufacturer_name
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
WHERE p.codigo IS NULL;

-- 36. Returns all products from the manufacturer Lenovo. (Without using INNER JOIN).
SELECT *
FROM producto
WHERE codigo_fabricante = (
  SELECT codigo
  FROM fabricante
  WHERE nombre = 'Lenovo'
);

-- 37. Returns all data for products that have the same price as the most expensive product from the manufacturer Lenovo. (Without using INNER JOIN).
SELECT *
FROM producto
WHERE precio = (
  SELECT MAX(precio)
  FROM producto
  WHERE codigo_fabricante = (
    SELECT codigo
    FROM fabricante
    WHERE nombre = 'Lenovo'
  )
);

-- 38. List the name of the most expensive product from the manufacturer Lenovo.
SELECT nombre
FROM producto
WHERE precio = (
  SELECT MAX(precio)
  FROM producto
  WHERE codigo_fabricante = (
    SELECT codigo
    FROM fabricante
    WHERE nombre = 'Lenovo'
  )
);

-- 39. List the cheapest product name from the manufacturer Hewlett-Packard.
SELECT p.nombre AS 'product name'
FROM producto p
JOIN fabricante f ON p.codigo_fabricante = f.codigo
WHERE precio = (
  SELECT MIN(precio)
  FROM producto
  WHERE codigo_fabricante = (
    SELECT codigo
    FROM fabricante
    WHERE nombre = 'Hewlett-Packard'
  )
);

-- 40. Returns all products in the database that have a price greater than or equal to the most expensive product from manufacturer Lenovo.
SELECT *
FROM producto
WHERE precio >= (
  SELECT MAX(precio)
  FROM producto
  WHERE codigo_fabricante = (
    SELECT codigo
    FROM fabricante
    WHERE nombre = 'Lenovo'
  )
);

-- 41. List all products from the manufacturer Asus that are priced higher than the average price of all their products.
SELECT *
FROM producto
WHERE codigo_fabricante = (
  SELECT codigo
  FROM fabricante
  WHERE nombre = 'Asus'
) AND precio > (
  SELECT AVG(precio)
  FROM producto
  WHERE codigo_fabricante = (
    SELECT codigo
    FROM fabricante
    WHERE nombre = 'Asus'
  )
);



