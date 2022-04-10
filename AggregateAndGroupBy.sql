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

 -- Hangi üründen ne kadarlýk sipariþ edilmiþ(YILLARA GÖRE GRUPLAYINIZ)
 SELECT P.ProductName,YEAR(O.OrderDate) AS YILLAR ,ROUND(SUM((1-OD.Discount)*OD.UnitPrice*OD.Quantity),2) AS TUTAR
 FROM [Order Details] OD
 INNER JOIN Orders O
 ON O.OrderID=OD.OrderID
 INNER JOIN Products P
 ON P.ProductID=OD.ProductID
 GROUP BY P.ProductName,YEAR(O.OrderDate)
 ORDER BY P.ProductName ASC ,YEAR(O.OrderDate) DESC

 -- Hangi üründen ne kadarlýk sipariþ edilmiþ(AYA GÖRE GRUPLAYINIZ)
 SELECT P.ProductName,MONTH(O.OrderDate) AYLAR, ROUND(SUM((1-OD.Discount)*OD.UnitPrice*od.Quantity),2)
 FROM [Order Details] OD
 INNER JOIN Orders O
 ON OD.OrderID=O.OrderID
 INNER JOIN Products P
 ON P.ProductID=OD.ProductID
 GROUP BY P.ProductName,(O.OrderDate)

-- Ortalama fiyatýn üstünden sattýðým ürünlerin fiyatýný getirin
SELECT P.ProductName,P.UnitPrice
FROM Products P
WHERE P.UnitPrice > (
				SELECT AVG(P.UnitPrice) AS ORTALAMA
				FROM Products
				)
ORDER BY UnitPrice DESC

-- Hangi müþterilerin ORTALAMA sipariþin üstünde sipariþ vermiþ ve ne kadarlýk sipariþ vermiþler

SELECT C.CompanyName,SUM((1-OD.Discount)*OD.UnitPrice*OD.Quantity) TUTAR
FROM Orders O 
JOIN [Order Details] OD ON OD.OrderID = O.OrderID
JOIN Customers C ON C.CustomerID = O.CustomerID
WHERE (1-OD.Discount)*OD.UnitPrice*OD.Quantity>
(
	SELECT AVG((1-OD.Discount)*OD.UnitPrice*OD.Quantity) TUTAR
	FROM [Order Details] OD
)
GROUP BY C.CompanyName
ORDER BY TUTAR DESC

--Adet olarak 
SELECT TOP 5 C.CompanyName,COUNT(0) ADET
FROM Orders O 
JOIN Customers C ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName
HAVING COUNT(0) <
(
	SELECT AVG(SANAL.ADET) ORT
	FROM 
	(
		SELECT O2.CustomerID,COUNT(0) ADET
		FROM Orders O2
		GROUP BY O2.CustomerID
	) AS SANAL
)
ORDER BY ADET ASC

-- Henüz ulaþmamýþ sipariþlerin toplam maaliyeti nedir?

SELECT ROUND(SUM((1-OD.Discount)*OD.UnitPrice*OD.Quantity),2)
FROM [Order Details] OD
INNER JOIN Orders O
ON O.OrderID=OD.OrderID
WHERE O.ShippedDate IS NULL

--Henüz ulaþmamýþ ürünler kaç gün beklemekte

SELECT AVG(DATEDIFF(DAY,O.RequiredDate,GETDATE())) "Ortalama Bekleme"
FROM Orders O
WHERE O.ShippedDate IS NULL

--Ortalama teslim zamanýmýz (gün)

SELECT AVG(DATEDIFF(DAY,O.OrderDate,O.ShippedDate)) "Ortalama Bekleme"
FROM Orders O
WHERE O.ShippedDate IS NOT NULL

--Sipariþ verilen ülkelerin sayýsý (Ayný ülke iki kez gösterilmeyecek)

SELECT DISTINCT ShipCountry  
FROM Orders

--Henüz sipariþ vermemiþ müþteriler

SELECT C.CompanyName,C.ContactName
FROM Customers C
WHERE C.CustomerID NOT IN(
	SELECT DISTINCT O.CustomerID
	FROM ORDERS O 
)