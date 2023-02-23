#To know all the availabe tables in the database schema
SHOW TABLES;

#To know the details of any specific table 
DESC employees;

#Select everything from the 'sales' table
SELECT * FROM sales;

#To select only a few columns from the 'sales' table
SELECT SaleDate, Amount, Customers
FROM sales;

#Adding a calculated column and using aliase
SELECT SaleDate, Amount, Boxes, Amount/boxes AS Amount_per_box  
FROM sales;

#Applying condition using a WHERE clause
SELECT * FROM sales
WHERE amount > 10000;

#Showing sales data where amount is greater than 10000 by descending order
SELECT * FROM sales
WHERE amount > 10000
ORDER BY amount DESC;

#Showing sales data where geography is 'G1' by product ID & descending order by PID & amount
SELECT * FROM sales
WHERE geoid = 'G1'
ORDER BY PID , Amount DESC;

#Working with dates by using a WHERE clause
SELECT * FROM sales
WHERE amount > 10000 AND SaleDate >= '2022-01-01';

#Using YEAR() function to select all data in a specific year
SELECT SaleDate, Amount FROM sales
WHERE amount > 10000 AND YEAR(SaleDate) = 2022
ORDER BY amount DESC;

#Applying between condition with < & > operators
SELECT * FROM sales
WHERE boxes >=0 AND boxes <=50;

#Using the BETWEEN operator
SELECT * FROM sales
WHERE boxes BETWEEN 0 AND 50;

#Using WEEKDAY() function
SELECT SaleDate, Amount, Boxes, WEEKDAY(SaleDate) AS 'Day_of_week'
FROM sales
WHERE WEEKDAY(SaleDate) = 4;

#Using OR operator
SELECT * FROM people
WHERE team = 'Delish' OR team = 'Jucies';

#Using IN operator
SELECT * FROM people
WHERE team IN ('Delish','Jucies');

#Using LIKE operator
SELECT * FROM people
WHERE salesperson LIKE 'B%';

SELECT * FROM people
WHERE salesperson LIKE '%B%';

#Using CASE to create branching logic
SELECT SaleDate, Amount,
    CASE
        WHEN amount < 1000 THEN 'Under 1K'
        WHEN amount < 5000 THEN 'Under 5K'
        WHEN amount < 10000 THEN 'Under 10K'
        ELSE '10k or more'
    END AS 'Amount_category'
FROM sales;

#Using GROUP BY
SELECT team, COUNT(*) AS members
FROM people
GROUP BY team

