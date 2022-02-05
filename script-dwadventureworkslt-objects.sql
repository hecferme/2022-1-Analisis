--create database DWAdventureWorksLT
use DWAdventureWorksLT


if OBJECT_ID('FactSalesOrderDetail', 'U') IS NOT NULL
    drop table FactSalesOrderDetail;

if OBJECT_ID('FactSalesOrderHeader', 'U') IS NOT NULL
    drop table FactSalesOrderHeader;

if OBJECT_ID('DimCustomer', 'U') IS NOT NULL
    drop table DimCustomer;

if OBJECT_ID('DimProduct', 'U') IS NOT NULL
    drop table DimProduct;

if OBJECT_ID('DimAddress', 'U') IS NOT NULL
    drop table DimAddress;

IF TYPE_ID(N'Name') IS NOT NULL
    drop type [dbo].[Name] 

CREATE TYPE [dbo].[Name]  
FROM varchar(100) NULL ;  

IF TYPE_ID(N'Flag') IS NOT NULL
    drop type [dbo].[Flag] 

CREATE TYPE [dbo].[Flag]  
FROM bit NULL ;  


CREATE TABLE [DimAddress](
	[AddressID] [int],
	[City] [nvarchar](30),
	[StateProvince] [dbo].[Name],
	[CountryRegion] [dbo].[Name]
) 
GO


CREATE TABLE [DimProduct](
    [ProductID] [int],
    [Name] [dbo].[Name],
    [ProductNumber] [nvarchar](25),
    [Color] [nvarchar](15),
    [StandardCost] [money],
    [ListPrice] [money],
    [Size] [nvarchar](5),
    [Weight] [decimal](8, 2),
    [ProductCategoryName] [dbo].[Name],
    [ParentProductCategoryName] [dbo].[Name],
    [ProductModelName] [dbo].[Name],
    [SellStartDate] [datetime],
    [SellEndDate] [datetime],
    [DiscontinuedDate] [datetime]
)

GO
CREATE TABLE [DimCustomer](
	[CustomerID] [int],
    [FullName] [dbo].[Name],
	[CompanyName] [nvarchar](128),
	[SalesPerson] [nvarchar](256)
) 
GO

CREATE TABLE [FactSalesOrderHeader](
	[SalesOrderID] [int],
	[OrderDate] [datetime],
	[DueDate] [datetime],
	[ShipDate] [datetime],
	[Status] [tinyint],
	[OnlineOrderFlag] [dbo].[Flag],
	[CustomerID] [int],
	[ShipToAddressID] [int],
	[BillToAddressID] [int],
	[ShipMethod] [nvarchar](50),
	[SubTotal] [money],
	[TaxAmt] [money],
	[Freight] [money],
	[TotalDue] [money]
) 
GO


CREATE TABLE [FactSalesOrderDetail](
	[SalesOrderID] [int] ,
	[SalesOrderDetailID] [int],
	[OrderQty] [smallint],
	[ProductID] [int],
	[UnitPrice] [money],
	[UnitPriceDiscount] [money],
	[LineTotal] [int]
) 
GO


