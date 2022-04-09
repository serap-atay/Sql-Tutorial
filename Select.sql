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

 
 -- FEDERAL SHIPPING iLE TAŞINMIŞVE NANCY'NİN ALMIŞ OLDUĞU SİPARİŞLERİ GÖSTERİNİZ.

 SELECT O.OrderID, E.FirstName,E.LastName,S.CompanyName FROM Orders O
 INNER JOIN Employees E
 ON O.EmployeeID= E.EmployeeID
 INNER JOIN Shippers S
 ON S.ShipperID=O.ShipVia
 WHERE S.CompanyName='Federal Shipping' AND E.FirstName='Nancy'

 -- MÜŞTERİ ADI,ONAYLAYAN ÇALIŞANIN ADI,ALDIĞI ÜRÜNLERİN ADINI LİSTELEYİN

 SELECT C.ContactName,E.FirstName+' '+E.LastName AS EMPLOYEE, P.ProductName FROM 
 Products P
 INNER JOIN [Order Details] OD
 ON P.ProductID=OD.ProductID
 INNER JOIN Orders O
 ON OD.OrderID=O.OrderID
 INNER JOIN Employees E
  ON E.EmployeeID=O.EmployeeID
 INNER JOIN Customers C
 ON C.CustomerID=O.CustomerID

 -- AGGREGATE FUNC GROUP BY

-- 01.01.1998 tarihinden sonra Siparis veren müşterilerin isimlerini ve siparis tarihlerini listeleyiniz

SELECT C.ContactName,O.OrderDate
FROM Orders O
JOIN Customers C ON C.CustomerID = O.CustomerID
WHERE O.OrderDate>'01.01.1998'

-- 10248 nolu Sipariş hangi kargo sirketi ile gonderilmiştir.

SELECT S.CompanyName
FROM Orders O 
JOIN Shippers S ON S.ShipperID = O.ShipVia
WHERE O.OrderID = 10248

-- TOFU isimli ürün alınan siparişlerin sipariş numaralarını listeleyiniz.

SELECT OD.OrderID,P.ProductName FROM Products P
INNER JOIN [Order Details] OD
ON P.ProductID=OD.ProductID
WHERE P.ProductName='TOFU'

-- DUMON VEYA ALFKI MÜŞTERİLERİNİN ALDIĞI 1 ID Lİ ÇALIŞANIMIN ONAYLADIĞI 1 VEYA 3 NOLU KARGO FİRMASIYLA TAŞINMIŞ SİPARİŞLERİ GETİRİN

SELECT *
FROM Orders O 
--WHERE (CustomerID='DUMON' OR CustomerID ='ALFKI') AND EmployeeID =1 AND (ShipVia = 1 OR ShipVia=3)
WHERE CustomerID IN('DUMON','ALFKI') AND EmployeeID = 1 AND ShipVia IN(1,3)

-- SUBQUERY
