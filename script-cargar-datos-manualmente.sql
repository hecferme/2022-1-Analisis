-- cargar datos en dimAddress
SELECT b.AddressID, b.City, b.StateProvince, b.CountryRegion from SalesLT.Address as b

-- cargar datos en DimProduct
SELECT [ProductID],[Name],[ProductNumber],[Color],[StandardCost]
      ,[ListPrice],[Size],[Weight], '', '', '', [SellStartDate],[SellEndDate]
      ,[DiscontinuedDate]
  FROM [SalesLT].[Product]

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