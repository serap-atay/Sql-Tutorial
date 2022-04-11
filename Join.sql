SELECT E.City,C.CompanyName, (E.FirstName+' '+ E.LastName) AS [Name Surname] FROM Customers C
JOIN Orders O
ON O.CustomerID=C.CustomerID
JOIN Employees E
ON E.EmployeeID=O.EmployeeID
WHERE E.City='LONDON'


SELECT E.City,C.CompanyName, (E.FirstName+' '+ E.LastName) AS [Name Surname] FROM Customers C
JOIN Orders O
ON O.CustomerID=C.CustomerID
JOIN Employees E
ON E.EmployeeID=O.EmployeeID
ORDER BY O.OrderDate

SELECT P.ProductName,O.OrderDate,(OD.UnitPrice*OD.UnitPrice) AS TOPLAM  FROM Products P
JOIN [Order Details] OD
ON OD.ProductID=P.ProductID
JOIN Orders O
ON O.OrderID=OD.OrderID
ORDER BY OD.UnitPrice

SELECT O.OrderID,SUM(OD.UnitPrice*OD.UnitPrice) AS TOPLAM  FROM Products P
JOIN [Order Details] OD
ON OD.ProductID=P.ProductID
JOIN Orders O
ON O.OrderID=OD.OrderID
GROUP BY O.OrderID 


SELECT	C.CompanyName, C.PostalCode,O.OrderID FROM Customers C
LEFT JOIN Orders O
ON O.CustomerID=C.CustomerID
WHERE C.PostalCode IS NULL

SELECT C.CompanyName,O.OrderID,O.ShippedDate FROM Customers C
RIGHT JOIN Orders O
ON O.CustomerID=C.CustomerID

SELECT P.ProductName , OD.OrderID FROM Products P
LEFT JOIN [Order Details] OD
ON OD.ProductID=P.ProductID

SELECT O.OrderID,(E.FirstName+' '+ E.LastName) AS [Full Name],E.ReportsTo FROM ORDERS O
RIGHT JOIN Employees E
ON E.EmployeeID=O.EmployeeID
WHERE E.ReportsTo IS NULL

--Hangi üründen kaç tane satýlmýþ

SELECT P.ProductName,COUNT(0) ADET FROM Products P
INNER JOIN [Order Details] OD
ON OD.ProductID=P.ProductID
GROUP BY P.ProductName
ORDER BY P.ProductName DESC

--En çok satýlan 3 ürün hangisidir

SELECT TOP 3 P.ProductName,COUNT(0) ADET FROM Products P
INNER JOIN [Order Details] OD
ON OD.ProductID=P.ProductID
GROUP BY P.ProductName
ORDER BY ADET DESC

--En çok kazandýran 3 ürün hangisidir

SELECT TOP 3 P.ProductName,ROUND(SUM((1-OD.Discount)*OD.UnitPrice*od.Quantity),2) AS TOTAL FROM Products P
INNER JOIN [Order Details] OD
ON OD.ProductID=P.ProductID
GROUP BY P.ProductName
ORDER BY TOTAL DESC

--Hangi kargo þirketlerine ne kadar ödeme yapýlmýþ
SELECT S.CompanyName,SUM(O.Freight) AS TOTAL FROM Orders O
INNER JOIN Shippers S
ON O.ShipVia=S.ShipperID
GROUP BY S.CompanyName 
ORDER BY TOTAL DESC

--En uygun kargo ücreti 

SELECT TOP 1 S.CompanyName,MIN(O.Freight) AS [MIN Price] FROM Orders O
JOIN Shippers S
ON S.ShipperID=O.ShipVia
GROUP BY S.CompanyName 
ORDER BY  [MIN Price]


