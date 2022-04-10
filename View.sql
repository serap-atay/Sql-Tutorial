SELECT *
FROM [Category Sales for 1997]

-- Ürün bazlý Sipariþ Raporu

CREATE VIEW VW_ProductOrder
AS
SELECT P.ProductName,CAST(ROUND(SUM((1-OD.Discount)*OD.UnitPrice*OD.Quantity),2) AS DECIMAL(15,3)) TOTAL
FROM [Order Details] OD
JOIN Products P ON P.ProductID = OD.ProductID
GROUP BY P.ProductName

SELECT * FROM VW_ProductOrder
ORDER BY TOTAL DESC

--ALTER View

ALTER VIEW VW_ProductOrder
AS
SELECT P.ProductName,P.UnitsInStock, CAST(ROUND(SUM((1-OD.Discount)*OD.UnitPrice*OD.Quantity),2) AS DECIMAL(15,3)) TOTAL
FROM [Order Details] OD
JOIN Products P ON P.ProductID = OD.ProductID
GROUP BY P.ProductName,P.UnitsInStock

SELECT * FROM VW_ProductOrder
ORDER BY TOTAL 
