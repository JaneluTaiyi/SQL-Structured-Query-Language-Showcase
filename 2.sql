-- Skill demonstrated: 1 data screening
-- Question 1.1: How to have a viewing on all tables used in 'northwind.db' database?
-- Question 1.2: How to show all records of a certain table with its all attributes?
-- Question 1.3: How to show some records of a certain table?

-- Skill demonstrated: 2 data filtering
-- Question 2.1: How to filter out certain data out by 1/0,Yes/No,Notnull/Null characteristic?
-- Question 2.2: How to get only the desired limited lines of records?

-- Skill demonstrated: 3 data relationships
-- Question 3.1: When to use JOIN?
-- Question 3.2: When to use GROUP BY?
-- Question 3.3: When to use HAVING instead of WHERE?

-- Skill demonstrated: 4 Subqueires and UNION command
-- Question 4.1: How to use IN to organize subqueires?
-- Question 4.2: How to use UNION or UNION ALL?

-- Benefit of using SQL-code in data analyze:
-- 1 easy to view, summerize, compare data
-- 2 organized when generating report, optimising calculation performance, a potentially growing database
---------------------------------------------------------------------------------------------------------


-- Skill demonstrated: 1 data screening
-- Question 1.1: How to have a viewing on all tables used in 'northwind.db' database?
-- Question 1.2: How to show all records of a certain table with its all attributes?
-- Question 1.3: How to show some records of a certain table?

-- Question 1.1: How to have a viewing on all tables used in 'northwind.db' database?
-- To view on all tables used in 'northwind.db' database
SELECT name FROM sqlite_master 
WHERE type='table'
ORDER BY name;

-- Question 1.2: How to show all records of a certain table with its all attributes?
-- To show all records of table 'Categories' with all its attributes
SELECT * FROM Categories;

-- Question 1.3: How to show some records of a certain table?
-- To show some records of table 'Categories'
SELECT CategoryName FROM Categories;

-- To show all records of table 'Products' with all its attributes
SELECT * FROM Products;

-- To show some records of table 'Products' which hold units-on-order not 0.
SELECT ProductID, ProductName, UnitsOnOrder FROM Products
	WHERE UnitsOnOrder != 0
	ORDER by UnitsOnOrder ASC;
	
-- To show some records of table 'Products' by calling sepecifit product names.
SELECT ProductID, ProductName, UnitsOnOrder FROM Products
	WHERE ProductName in ('Chai','Tofu','Côte de Blaye','Boston Crab Meat');

-- To show some records of table 'Products' which have unit-price fall into certain range.	
SELECT ProductID, ProductName, UnitPrice FROM Products
	WHERE UnitPrice BETWEEN 10.1 AND 15.0;
	
-- Skill demonstrated: 2 data filtering
-- Question 2.1: How to filter out certain data out by 1/0,Yes/No,Notnull/Null characteristic?
-- Question 2.2: How to get only the desired limited lines of records?

-- Question 2.1: How to filter out certain data out by 1/0,Yes/No,Notnull/Null characteristic?
-- To show the 0-ordered product of table 'Products'
SELECT UnitsOnOrder, ProductID, ProductName, UnitPrice FROM Products
	WHERE UnitsOnOrder == 0;
	
-- To show all attributes of table 'Employees'
SELECT * FROM Employees;

-- To show the Null of 'ReportsTo' attribute of table 'Employees'
SELECT LastName, FirstName, TitleOfCourtesy, ReportsTo, PhotoPath FROM Employees
	WHERE ReportsTo ISNULL;
	
-- To show all attributes of table 'Employees' by sequencing some records
SELECT EmployeeID, LastName, FirstName, BirthDate, ReportsTo FROM Employees e
	ORDER by e.ReportsTo NULLS LAST, BirthDate;
	
-- To show the non-Null of 'ReportsTo' attribute of table 'Employees'
SELECT LastName, FirstName, TitleOfCourtesy, ReportsTo, PhotoPath FROM Employees
	WHERE ReportsTo NOTNULL;
	
-- Question 2.2: How to get only the desired limited lines of records?
-- To show only the first 3 lines of table 'Employees'
SELECT * FROM Employees
	LIMIT 3;
	
-- To show only the 2-4 lines of table 'Employees'
SELECT * FROM Employees
	LIMIT 3
	OFFSET 1;

-- Skill demonstrated: 3 data relationships
-- Question 3.1: When to use JOIN?
-- Question 3.2: When to use GROUP BY?
-- Question 3.3: When to use HAVING instead of WHERE?


-- Question 3.1: When to use JOIN?
-- To show all alltributes in table 'Shippers'
SELECT * FROM Shippers;

-- To show all alltributes in table 'Orders'
SELECT * FROM Orders;

-- To show all orders shipped by the company with the certain shipper ID
SELECT s.* , o.ShipVia, o.ShipName, o.OrderID
	FROM Shippers s, Orders o
	WHERE s.ShipperID = o.ShipVia
	ORDER by s.ShipperID ASC;

-- To show all orders shipped by the 3rd company
SELECT s.* , o.ShipVia, o.ShipName, o.OrderID
	FROM Shippers s, Orders o
	WHERE s.ShipperID = o.ShipVia
	AND s.ShipperID = 3
	ORDER by o.ShipName ASC;
	
-- To show table 'Orders'
SELECT o.CustomerID, o.ShipVia, o.ShipCity
	FROM Orders o
	LIMIT 10;

-- To join table 'Orders' together with table 'Shippers'
SELECT s.* , o.CustomerID, o.ShipVia, o.ShipName
	FROM Orders o
JOIN
	Shippers s 
	on o.ShipVia = s.ShipperID
  	ORDER by o.CustomerID ASC
	LIMIT 10;

-- To show tables that are to be joined
SELECT * FROM Products;
SELECT * FROM Categories;
SELECT * FROM Suppliers;

-- To join the 3 tables into 1
SELECT p.ProductName, p.CategoryID, p.SupplierID, c.CategoryName, s.CompanyName
	FROM Products p
	JOIN Categories c
		on p.CategoryID = c.CategoryID
	JOIN Suppliers s
		on p.SupplierID = s.SupplierID
	LIMIT 10;

-- Question 3.2: When to use GROUP BY?
-- To count the rows in a table
SELECT count (*) CategoriesCount
	FROM Categories c;

-- To show table
SELECT * FROM Suppliers;

-- To count the same types in a table
SELECT s.Country,
	count (*) OwnsNumbersOfCompanies
	FROM Suppliers s
	GROUP by s.Country;
	
-- Question 3.3: When to use HAVING instead of WHERE?
-- To show products that been supplied by countries which indeed have numbers of orders
SELECT p.ProductName,
		p.CategoryID pcid, c.CategoryID ccid, s.Country, p.SupplierID psid, s.SupplierID ssid,
		p.UnitsOnOrder
	FROM Products p
	JOIN Categories c
		on p.CategoryID = c.CategoryID
	JOIN Suppliers s
		on p.SupplierID = s.SupplierID
	GROUP by s.Country
	HAVING
		p.UnitsOnOrder > 1;
		

-- Skill demonstrated: 4 Subqueires and UNION command
-- Question 4.1: How to use IN to organize subqueires?
-- Question 4.2: How to use UNION or UNION ALL?

-- Question 4.1: How to use IN to organize subqueires?
-- To show table
SELECT s.Country, s.city, s.Fax
	FROM Suppliers s;

-- To show rows of the table only where the 'Fax' is not NULL
SELECT s.Country, s.city, s.Fax
	FROM Suppliers s
	WHERE Fax in
		(
		SELECT s.Fax FROM Suppliers s
		WHERE s.Fax NOTNULL
		)
	ORDER by s.Country;

-- To show rows of the table only where the 'Fax' is distinct (which is non NULL)
SELECT s.Country, s.Fax
	FROM Suppliers s
	WHERE Fax in
		(
		SELECT DISTINCT s.Fax FROM Suppliers s
		)
	ORDER by s.Country;
				
-- Question 4.2: How to use UNION or UNION ALL?
-- To show tables
SELECT * FROM Employees;
SELECT * FROM Kunde;

-- To show results from the first table
SELECT k.vorname FirstName, k.nachname LastName FROM Kunde k;

-- To show results from the second table
SELECT e.FirstName, e.LastName FROM Employees e;

-- Merge the results of different tables
SELECT e.FirstName, e.LastName, 'Employee' as Type
	FROM Employees e
UNION
SELECT k.vorname FirstName, k.nachname LastName, 'Kunde (customer)' as Type
	FROM Kunde k;
