--Secilen kayýtlarýn tabloya eklenmesi
INSERT INTO Newtable(EmployeeId,ADET)
SELECT E.EmployeeID,COUNT(O.OrderID) AS ADET FROM Employees E
JOIN Orders O
ON O.EmployeeID=E.EmployeeID
GROUP BY E.EmployeeID

SELECT * FROM Newtable

--UNION
SELECT City FROM Employees 
UNION
SELECT City FROM Customers

--UNION ALL

SELECT City FROM Employees 
UNION ALL
SELECT City FROM Customers

--SUBQUERY

SELECT E.FirstName,E.LastName,
(SELECT COUNT(0) FROM Orders O WHERE O.EmployeeID=E.EmployeeID) AS OrderCount
 FROM Employees E

SELECT P.ProductID,P.ProductName
FROM Products P
WHERE P.ProductID IN(SELECT OD.ProductID FROM [Order Details] OD WHERE OD.Quantity > 50)

--EXISTS

SELECT C.ContactName,C.Country FROM Customers C
WHERE EXISTS(SELECT O.CustomerID FROM Orders O WHERE C.CustomerID=O.CustomerID AND C.Country='UK' )

SELECT C.CompanyName FROM Customers C
WHERE EXISTS
(SELECT COUNT(0) ADET FROM Orders O WHERE O.CustomerID=C.CustomerID
 GROUP BY O.OrderDate
 HAVING COUNT(0) >1
)

--ANY 
SELECT ProductID, ProductName,UnitPrice,UnitsInStock FROM Products
WHERE ProductID IN (2,4,5,7,9)

SELECT ProductID,ProductName,UnitPrice FROM Products
WHERE ProductID = ANY(SELECT ProductID FROM [Order Details] OD WHERE OD.Quantity>10)

--ALL

SELECT ProductID,ProductName,UnitPrice FROM Products
WHERE ProductID > ALL(SELECT ProductID FROM [Order Details] OD WHERE OD.UnitPrice>100)