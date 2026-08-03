	with ordersummary as (
		select
			t0.PurchaseOrderID,
			sum(t0.OrderQty) as Total_Ordenado,
			sum(t0.ReceivedQty) as Total_Recibido,
			sum(t0.RejectedQty) as Total_Devuelto,
			sum(t0.ReceivedQty-t0.RejectedQty) as Total_Stock
		from Purchasing.PurchaseOrderDetail as t0
		group by t0.PurchaseOrderID
	)
select
t1.PurchaseOrderID,
t1.OrderDate as 'fecha compra',
t1.ShipDate 'fecha de entrega',
t3.DueDate 'fecha entrada',
t3.ProductID,
t4.Name as producto,
t3.OrderQty,
t3.ReceivedQty,
t3.RejectedQty,

t2.Name as 'Proveedor',
CASE
	WHEN (T3.ReceivedQty - T3.RejectedQty) <=0 AND t3.OrderQty >0 then 'sin Stock'
	WHEN (T3.ReceivedQty - T3.RejectedQty) < t3.OrderQty  then 'Insuficiente por Rechazo'
	WHEN (T3.ReceivedQty - T3.RejectedQty) = t3.OrderQty  then 'Cumplimiento Correcto'
	end as 'Exceso de Stock',

CASE t1.Status
	WHEN 1 THEN 'Pendiente'
	WHEN 2 THEN 'Aprobado'
	WHEN 3 THEN 'Rechazado'
	WHEN 4 THEN 'Completada'
	END as 'Item Estatus',

CASE
	WHEN (Total_Stock < Total_Ordenado) THEN 'Orden Incompleta'
	WHEN (Total_Stock = Total_Ordenado) THEN 'Orden Completa'
	ELSE 'Orden con sobrante'
end 'estatus de la orden'

from Purchasing.PurchaseOrderHeader as t1
Left join Purchasing.Vendor as t2 on t1.VendorID = t2.BusinessEntityID
inner join Purchasing.PurchaseOrderDetail as t3 on t1.PurchaseOrderID = t3.PurchaseOrderID
left join Production.Product as t4 on t3.ProductID = t4.ProductID
join ordersummary as t5 on t1.PurchaseOrderID = t5.PurchaseOrderID

