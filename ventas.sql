--- Consulta de las ventas
select
t1.SalesOrderID as factura,
t1.OrderDate as 'fecha de venta',
t1.ShipDate as 'fecha de entrega',
t2.OrderQty as cantidad,
t2.UnitPrice as 'precio unitario',
t2.OrderQty * t2.UnitPrice as monto,
t2.ProductID,
t3.Name as producto,
t4.Name as Subcategoria,
t5.Name as categoria,
t1.CustomerID,
concat(t6.FirstName,' ', t6.LastName) as cliente,
t1.SalesPersonID,
concat(t7.FirstName,' ', t7.LastName) as vendedor

from Sales.SalesOrderHeader as t1
	inner join Sales.SalesOrderDetail as t2 on t1.SalesOrderID = t2.SalesOrderID
	left join Production.Product as t3 on t2.ProductID = t3.ProductID
	inner join Production.ProductSubcategory as t4 on t3.ProductSubcategoryID = t4.ProductSubcategoryID
	inner join Production.ProductCategory as t5 on  t4.ProductCategoryID = t5.ProductCategoryID
	left join Person.Person as t6 on t1.CustomerID = t6.BusinessEntityID
	left join Person.Person as t7 on t1.SalesPersonID = t7.BusinessEntityID


select
*
from Sales.SalesOrderHeader

select * from Sales.SalesOrderDetail

select * from Production.Product

select * from Production.ProductSubcategory

select * from Person.Person