SELECT 'Wissen'
SELECT LOWER('WISSEN')
SELECT UPPER('wissen')
SELECT MONTH(GETDATE())
SELECT GETUTCDATE()
SELECT DATENAME(MM,GETDATE())
SELECT DATENAME(YY,GETDATE())

SELECT CustomerID,DATENAME(MM,OrderDate)+' '+DATENAME(YY,OrderDate) as 'Siparis Tarihi' from Orders

SELECT CustomerID, DATEDIFF(YY,OrderDate,GetDate()) as 'SiparisTarihi' from Orders

SELECT CustomerID,DATENAME(YEAR,DATEADD(YEAR,10,OrderDate)) as 'Siparis Tarihi' from Orders

--SELECT FROM JOINS WHERE ORDER BY GROUP BY HAVING

SELECT TOP 100 ProductID,ProductName,UnitPrice, QuantityPerUnit,UnitsInStock
FROM Products

SELECT * from Products

SELECT * from Products 
WHERE UnitPrice>=25 AND UnitPrice<=75

SELECT ProductName,UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 55 AND 97
ORDER BY UnitPrice ASC

SELECT ProductName,UnitPrice from Products
WHERE UnitPrice BETWEEN 25 AND 97
ORDER BY UnitPrice ASC

SELECT ProductName,UnitPrice from Products
--WHERE UnitPrice BETWEEN 25 AND 97
ORDER BY UnitPrice ASC

SELECT TOP 10 ProductName,UnitPrice,UnitPrice*1.18 AS [Kdvli Fiyatı]
 from Products
 WHERE UnitPrice BETWEEN 25 AND 97
 ORDER BY UnitPrice DESC

 SELECT TOP 10 ProductName,UnitPrice,UnitsInStock,UnitPrice*UnitsInStock AS [Maaliyet]
 FROM Products
 ORDER BY Maaliyet DESC

 --INNER JOIN

 SELECT P.ProductName,C.CategoryName
 FROM Products P
 INNER JOIN Categories C
 ON P.CategoryID = C.CategoryID


 SELECT C.CategoryName,P.ProductName,P.UnitPrice
 FROM Categories C
 INNER JOIN Products P
 ON C.CategoryID= P.CategoryID
 ORDER BY UnitPrice DESC

 SELECT P.ProductName,C.CategoryName,S.CompanyName
  FROM Categories C
 INNER JOIN Products P
 ON P.CategoryID=C.CategoryID
 INNER JOIN Suppliers S
 ON S.SupplierID=P.SupplierID

