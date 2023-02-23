-- SQL PROJECT-1 | Part-2 | Intermediate Concepts & Queries
-- ==================================================================

#Understanding both tables before applying JOIN
SELECT * FROM sales;
SELECT * FROM people; 
SELECT * FROM products;
SELECT * FROM geo;

#Using INNER JOIN to fetch data from two tables
SELECT sales.SPID, people.Salesperson, sales.SaleDate, sales.Amount
FROM sales
INNER JOIN people
ON sales.SPID = people.SPID;

#Using LEFT JOIN to fetch data from two tables
SELECT sales.SaleDate, sales.Amount, products.Product
FROM sales 
LEFT JOIN products
ON sales.PID = products.PID;

#Using multiple JOINS to fetch data from multiple tables
SELECT s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team
FROM sales s 
JOIN people p ON s.SPID = p.SPID
JOIN products pr ON s.PID = pr.PID;

#Using WHERE clause with JOINS to fetch data from multiple tables with certain conditions
SELECT s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team
FROM sales s 
JOIN people p ON s.SPID = p.SPID
JOIN products pr ON s.PID = pr.PID
WHERE s.Amount < 500 AND p.Team = 'Delish';

#Using WHERE clause with JOINS to fetch data from multiple tables with multiple conditions
SELECT s.SaleDate, s.Amount, p.Salesperson, pr.Product, p.Team, g.geo
FROM sales s 
JOIN people p ON s.SPID = p.SPID
JOIN products pr ON s.PID = pr.PID
JOIN geo g ON g.GeoID = s.GeoID
WHERE s.Amount < 500 AND p.Team = 'Delish' AND g.geo IN ('India','CANADA');

#Using GROUP BY clause with aggregation funtions & also using ROUND() function
SELECT GeoID, SUM(Boxes) AS Number_of_boxes,
SUM(Amount) AS Total_Amount, 
ROUND(AVG(Amount),2) AS Average_Amount
FROM sales
GROUP BY GeoID
ORDER BY GeoID;

#Using JOINS and GROUP BY clause to get clearer insights
SELECT g.Geo, g.GeoID, SUM(Boxes) AS Number_of_boxes,
SUM(Amount) AS Total_Amount, 
ROUND(AVG(Amount),2) AS Average_Amount
FROM sales s
JOIN geo g ON s.GeoID = g.GeoID
GROUP BY g.Geo
ORDER BY g.GeoID;

#Using multiple JOINS, GROUP BY & WHERE clause to get clearer insights
SELECT pr.Category, p.Team, 
SUM(Boxes) AS Number_of_boxes,
SUM(Amount) AS Total_Amount
FROM sales s 
JOIN people p ON p.SPID = s.SPID
JOIN products pr ON pr.PID = s.PID
WHERE p.Team <> '' 
GROUP BY pr.Category, p.Team
ORDER BY pr.Category, p.Team;

#Using LIMIT clause to fetch Top 10 Products by Total_Amount
SELECT pr.Product,
SUM(Amount) AS Total_Amount
FROM sales s 
JOIN products pr ON pr.PID = s.PID
GROUP BY pr.Product
ORDER BY pr.Product DESC 
LIMIT 10;

#Using HAVING clause to fetch Amount>1000 in each GeoID
SELECT GeoID, COUNT(Amount) AS Total_Number
FROM sales
GROUP BY GeoID
HAVING SUM(Amount) > 1000
ORDER BY GeoID ASC;
