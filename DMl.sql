--DML
--INSERT
--UPDATE
--DELETE
--SELECT

USE ETicaret
Go

INSERT INTO Categories(CategoryName,C_Description)
VALUES('FOOD','Hot and cold food')

INSERT INTO Categories(CategoryName,C_Description)
VALUES('SEA FOOD','Hot and cold sea food')

INSERT INTO Categories(CategoryName,C_Description)
VALUES('ELECTRONÝC', 'Electronic devices')

USE master
Go

INSERT INTO ETicaret.dbo.Categories(CategoryName,C_Description)
SELECT CategoryName,[Description] from Northwind.dbo.Categories

USE Northwind
Go

DELETE FROM Products
Go

Use ETicaret
Go

SELECT * FROM Categories
DELETE FROM Categories
WHERE CategoryId=1

SELECT * FROM Categories
UPDATE Categories
SET CategoryName='Food', C_Description='Hot and cold food'
WHERE CategoryId=2

UPDATE Customers
SET Region='NOTORDER'
WHERE CustomerId IN(
	SELECT CustomerId FROM Customers
	WHERE CustomerId NOT IN (
	SELECT DISTINCT O.CustomerID
		FROM ORDERS O 
	) 
)
SELECT * FROM Customers

DECLARE @kid INT
SELECT @kid=CategoryId FROM Categories
WHERE CategoryName='Food'


INSERT INTO Products(ProductName,Price,P_CategoryId,P_SupplierId)
VALUES('Water',20,@kid,NULL)

SELECT * FROM Products