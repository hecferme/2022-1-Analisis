--create database DWAdventureWorksLT
use DWAdventureWorksLT


if OBJECT_ID('DimEstratificacion', 'U') IS NOT NULL
    drop table DimEstratificacion;

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

create table DimEstratificacion (
    ID int PRIMARY KEY, Class VARCHAR (30), LowerBound MONEY, UpperBound MONEY, Description VARCHAR (100));
-- TODO !!!!!!! 
-- Incluir los comandos insert para cargar los datos en la tabla
BEGIN TRAN
INSERT [dbo].[DimEstratificacion] ([ID], [Class], [LowerBound], [UpperBound], [Description]) VALUES (1000, N'PrecioArtículo', -999999999999.0000, 0.0000, N'Inválido')
INSERT [dbo].[DimEstratificacion] ([ID], [Class], [LowerBound], [UpperBound], [Description]) VALUES (1100, N'PrecioArtículo', 0.0000, 1000.0000, N'De $0 menos de de $1000')
INSERT [dbo].[DimEstratificacion] ([ID], [Class], [LowerBound], [UpperBound], [Description]) VALUES (1200, N'PrecioArtículo', 1000.0000, 2225.0000, N'De $1001 hasta menos de $2225')
INSERT [dbo].[DimEstratificacion] ([ID], [Class], [LowerBound], [UpperBound], [Description]) VALUES (1300, N'PrecioArtículo', 2225.0000, 3197.0000, N'De $2225 hasta menos de $3197')
INSERT [dbo].[DimEstratificacion] ([ID], [Class], [LowerBound], [UpperBound], [Description]) VALUES (1400, N'PrecioArtículo', 3197.0000, 999999999999.0000, N'De $3197 en adelante')
INSERT [dbo].[DimEstratificacion] ([ID], [Class], [LowerBound], [UpperBound], [Description]) VALUES (3000, N'Salario', NULL, NULL, NULL)
INSERT [dbo].[DimEstratificacion] ([ID], [Class], [LowerBound], [UpperBound], [Description]) VALUES (5000, N'Flete', NULL, NULL, NULL)
INSERT [dbo].[DimEstratificacion] ([ID], [Class], [LowerBound], [UpperBound], [Description]) VALUES (10000, N'Tax', NULL, NULL, NULL)
COMMIT;

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
    [DiscontinuedDate] [datetime],
	[EstratificacionListPrice] [VARCHAR](100)
)

BEGIN TRAN
UPDATE DimProduct set [EstratificacionListPrice] = 
(select e.[Description] AS ListPriceEstratificado from DimProduct as p
    left outer join DimEstratificacion e
        on e.Class = 'PrecioArtículo' and e.LowerBound <= p.ListPrice and p.ListPrice < e.UpperBound
		where p.ProductID = DimProduct.ProductID)
COMMIT;
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


