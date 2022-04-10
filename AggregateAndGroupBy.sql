--GROUP BY AGGREGATE FUNC HAVING

SELECT C.CategoryName, COUNT(0) ADET FROM  Categories C
INNER JOIN Products P
ON P.CategoryID=C.CategoryID
GROUP BY C.CategoryName
ORDER BY ADET DESC

SELECT C.CategoryName,SUM(P.UnitPrice*P.UnitsInStock) AS MAALÝYET FROM Categories C
INNER JOIN Products P
ON P.CategoryID=C.CategoryID
WHERE UnitsInStock>0
GROUP BY C.CategoryName
HAVING SUM(P.UnitPrice*P.UnitsInStock)>1000
ORDER BY MAALÝYET DESC

SELECT COUNT(0)
FROM [Order Details] OD
HAVING COUNT(0)>100

SELECT C.CategoryName,S.CompanyName,SUM(P.UnitPrice*P.UnitsInStock) AS MAALIYET
FROM Products P
INNER JOIN Categories C
ON P.CategoryID=C.CategoryID
INNER JOIN Suppliers S
ON S.SupplierID=P.SupplierID
GROUP BY C.CategoryName,S.CompanyName
HAVING SUM(P.UnitPrice*P.UnitsInStock)>3000
ORDER BY MAALIYET DESC

-- Sipariþleri sipariþ numarasý ve sipariþ toplam tutarý olarak listeleyiniz
 
SELECT OrderID,ROUND(SUM((1-Discount)*UnitPrice*Quantity),2) Tutar
FROM [Order Details]
GROUP BY OrderID


-- Hangi üründen ne kadarlýk sipariþ edilmiþ
SELECT P.ProductName,ROUND(SUM((1-OD.Discount)*OD.UnitPrice*OD.Quantity),2) AS TUTAR
 FROM [Order Details] OD
 INNER JOIN Products P
 ON P.ProductID=OD.ProductID
 GROUP BY P.ProductName
 ORDER BY TUTAR DESC

 -- Hangi tedarikçiden ne kadarlýk tedarik edilmiþ

 SELECT P.ProductName ,ROUND(SUM((1-OD.Discount)*OD.UnitPrice*OD.Quantity),2) AS TUTAR
 FROM [Order Details] OD
 INNER JOIN Products P
 ON P.ProductID=OD.ProductID
 INNER JOIN Suppliers S
 ON P.SupplierID=S.SupplierID
 GROUP BY P.ProductName,S.CompanyName
 ORDER BY S.CompanyName

 -- Hangi müþteriden ne kadarlýk sipariþ alýn

 SELECT C.CompanyName,ContactName,ROUND(SUM((1-OD.Discount)*OD.UnitPrice*OD.Quantity),2) TUTAR
  FROM [Order Details] OD
 INNER JOIN Orders O
 ON OD.OrderID=O.OrderID
 INNER JOIN Customers C
 ON C.CustomerID=O.CustomerID
 GROUP BY C.CompanyName,C.ContactName
 ORDER BY TUTAR DESC

 -- Hangi çalýþanýn ne kadarlýk ürün sipariþ etmiþ
 SELECT E.FirstName+' '+E.LastName AS CALISAN, ROUND(SUM((1-OD.Discount)*OD.UnitPrice*OD.Quantity),2) TUTAR
 FROM [Order Details] OD
 INNER JOIN Orders O
 ON OD.OrderID=O.OrderID
 INNER JOIN Employees E
 ON E.EmployeeID=O.EmployeeID
 GROUP BY E.FirstName,E.LastName
 ORDER BY TUTAR DESC

