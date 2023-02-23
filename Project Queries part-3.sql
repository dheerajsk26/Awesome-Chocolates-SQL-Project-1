-- SQL PROJECT-1 | Part-3 | Advanced Concepts & Queries
-- ==================================================================

#Usage of a simple subquery
SELECT * FROM sales
WHERE Amount > (SELECT AVG(Amount) FROM sales)
ORDER BY SPID;

#Usage of simple CTE instead of a subquery
WITH avg_amount AS (
SELECT AVG(Amount) as avg_amo FROM sales)
SELECT * FROM sales
INNER JOIN avg_amount 
ON Amount > avg_amo
ORDER BY SPID;

#Finding Top 5 products by total_amount in each GeoID using window function, GROUP BY clause and JOIN
SELECT * FROM (
SELECT s.GeoID, s.PID, pr.Product, SUM(s.amount) AS total_amount,
RANK() OVER(PARTITION BY s.geoID ORDER BY SUM(s.amount) DESC) AS rank_for_total_amount
FROM sales s
INNER JOIN Products pr ON s.PID = pr.PID
GROUP BY s.GeoID, s.PID ) AS d
WHERE rank_for_total_amount <=5; 

#Exploring RANK window functions
SELECT GeoID, Amount,
ROW_NUMBER() OVER (PARTITION BY GeoID ORDER BY Amount),
RANK() OVER (PARTITION BY GeoID ORDER BY Amount),
DENSE_RANK() OVER (PARTITION BY GeoID ORDER BY Amount)
FROM sales;

#Exploring analytical window functions 
SELECT GeoID, Amount,
FIRST_VALUE(Amount) OVER (ORDER BY Amount
ROWS BETWEEN UNBOUNDED PRECEDING
AND UNBOUNDED FOLLOWING) AS least_total_amount, 
LAST_VALUE(Amount) OVER (ORDER BY Amount
ROWS BETWEEN UNBOUNDED PRECEDING
AND UNBOUNDED FOLLOWING) AS highest_total_amount,
NTILE(4) OVER (PARTITION BY GeoID ORDER BY Amount)
FROM sales
ORDER BY GeoID ASC;