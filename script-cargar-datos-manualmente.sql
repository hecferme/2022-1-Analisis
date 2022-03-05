use AdventureWorksLT2019
-- cargar datos en dimAddress
SELECT b.AddressID, b.City, b.StateProvince, b.CountryRegion from SalesLT.Address as b

-- cargar datos en DimProduct
SELECT p.[ProductID],p.[Name],p.[ProductNumber],p.[Color],p.[StandardCost]
      ,p.[ListPrice],p.[Size],p.[Weight], pc1.Name ProductCategory, pc2.Name ParentProductCategory, 
	  pm.Name ProductModel, p.[SellStartDate],p.[SellEndDate]
      ,p.[DiscontinuedDate]
  FROM [SalesLT].[Product] p
  INNER JOIN [SalesLT].ProductCategory pc1 on pc1.ProductCategoryID = p.ProductCategoryID
  LEFT OUTER join [SalesLT].ProductCategory pc2 on pc2.ProductCategoryID = pc1.ParentProductCategoryID
  inner join [SalesLT].ProductModel pm on pm.ProductModelID = p.ProductModelID

  -- cargar datos en DimCustomer
  select b.CustomerID, b.FirstName + ' ' + b.LastName, b.CompanyName, b.SalesPerson from SalesLT.Customer b

  -- cargar datos en FactSalesOrderHeader
  SELECT [SalesOrderID],[OrderDate],[DueDate],[ShipDate],[Status],[OnlineOrderFlag]
        ,[CustomerID],[ShipToAddressID],[BillToAddressID],[ShipMethod],[SubTotal]
        ,[TaxAmt],[Freight],[TotalDue]
  FROM [SalesLT].[SalesOrderHeader]

  -- cargar datos en FactSalesOrderDetail
  SELECT TOP (1000) [SalesOrderID]
      ,[SalesOrderDetailID]
      ,[OrderQty]
      ,[ProductID]
      ,[UnitPrice]
      ,[UnitPriceDiscount]
      ,[LineTotal]
  FROM [SalesLT].[SalesOrderDetail]

  use DWAdventureWorksLT
  --borrar registros faltantes
  select count (*) from [FactSalesOrderHeader]
    select distinct d.SalesOrderID from FactSalesOrderDetail d
  except
  select p.SalesOrderID from [FactSalesOrderHeader] p

  select distinct d.CustomerID from [FactSalesOrderHeader] d
  except
  select p.CustomerID from [DimCustomer] p
  select min (p.CustomerID), max (p.CustomerID) from [FactSalesOrderHeader] p
select min (p.CustomerID), max (p.CustomerID) from [DimCustomer] p
begin tran
--update [FactSalesOrderHeader] set CustomerID = CustomerID + 11000
--where CustomerID < 11000
	declare @detalles as table (SalesOrderID int primary key)
	insert into @detalles select h.SalesOrderID from FactSalesOrderHeader h where
	h.CustomerID in (  select distinct d.CustomerID from [FactSalesOrderHeader] d
	  except
	  select p.CustomerID from [DimCustomer] p
	)


	delete FactSalesOrderHeader where CustomerID in  (  select distinct d.CustomerID from [FactSalesOrderHeader] d
	  except
	  select p.CustomerID from [DimCustomer] p
	)
	delete FactSalesOrderDetail where SalesOrderID in (select t.SalesOrderId from @detalles t)
commit

select max (orderdate) from FactSalesOrderHeader