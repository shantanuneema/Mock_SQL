-- Mock interviews for first week
-- Solution to https://leetcode.com/problems/top-travellers/
WITH CTE AS (
    SELECT user_id, SUM(distance) AS travelled_distance
    FROM Rides GROUP BY user_id
)
SELECT u.name, IFNULL(c.travelled_distance, 0) AS travelled_distance
FROM CTE c RIGHT JOIN Users u 
ON u.id = c.user_id
ORDER BY travelled_distance DESC, name ASC;

-- Solution to https://leetcode.com/problems/apples-oranges/
SELECT
    sale_date,
    SUM(IF(fruit = 'apples', sold_num, -sold_num)) AS diff
FROM Sales
GROUP BY sale_date;

-- Mock interviews for second week
-- Solution to https://leetcode.com/problems/customers-who-bought-all-products/
SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM Product);

-- Solution to https://leetcode.com/problems/product-sales-analysis-iii/
WITH CTE AS (
    SELECT product_id, year, quantity, price, RANK() OVER(PARTITION BY product_id ORDER BY year) as 'rnk'
    FROM Sales
)
SELECT product_id, year AS first_year, quantity, price 
FROM CTE WHERE rnk = 1;

-- Mock interviews for third week
-- Solution to https://leetcode.com/problems/market-analysis-ii/
WITH CTE AS (
    SELECT o.seller_id, o.item_id, i.item_brand FROM
    (
        SELECT seller_id,item_id,ROW_NUMBER() OVER(PARTITION BY seller_id ORDER BY order_date) AS rnk 
        FROM Orders
    ) o JOIN Items i ON o.item_id = i.item_id WHERE o.rnk = 2
)
SELECT u.user_id AS seller_id, IF(c.item_brand = u.favorite_brand, 'yes', 'no') AS 2nd_item_fav_brand
FROM CTE c 
RIGHT JOIN Users u 
ON c.seller_id = u.user_id;

-- Solution to https://leetcode.com/problems/tournament-winners/

