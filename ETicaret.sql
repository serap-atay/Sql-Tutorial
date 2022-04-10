--DDL
USE master
Go
CREATE DATABASE ETicaret
Go
USE ETicaret
Go

CREATE TABLE Categories(
		CategoryID INT IDENTITY PRIMARY KEY,
		CategoryName NVARCHAR(25) NOT NULL,
		C_Description NVARCHAR(128) --NULL
		)
Go
CREATE TABLE Products(
			ProductId INT IDENTITY PRIMARY KEY,
			ProductName NVARCHAR(50) NOT NULL,
			Price DECIMAL(6,2) NOT NULL,
			P_CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID) NOT NULL
			)
Go

ALTER TABLE Products
ADD CHECK (Price>0);

Go
CREATE TABLE Suppliers(
			SupplierId INT IDENTITY PRIMARY KEY,
			CompanyName NVARCHAR(50) NOT NULL,
			Phone CHAR(11),
			CreatedDate DATETIME NOT NULL DEFAULT(GETDATE())
			)
Go

ALTER TABLE Products
ADD P_SupplierId INT FOREIGN KEY REFERENCES Suppliers(SupplierId) 

Go

ALTER TABLE Suppliers
ADD CONSTRAINT UQ_SupplierId UNIQUE (SupplierId)

Go

CREATE TABLE Orders(
			OrderId INT IDENTITY PRIMARY KEY NOT NULL,
			OrderDate DATETIME NOT NULL DEFAULT(GETDATE())
			)
Go

CREATE TABLE OrderDetail(
			OrderId INT  NOT NULL,
			ProductId INT NOT NULL,
			Price DECIMAL(6,2) not null CHECK (Price>0),
			Quantity int not null default (1),
			CONSTRAINT PK_ProductId PRIMARY KEY(ProductId,OrderId),
			CONSTRAINT FK_OrderId FOREIGN KEY (OrderId) REFERENCES Orders(OrderId),
			CONSTRAINT FK_ProductId FOREIGN KEY (ProductId) REFERENCES Products(ProductId)
			)

