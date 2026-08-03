select 
t1.BusinessEntityID,
concat(t2.FirstName,' ', t2.LastName) as empleado,
t1.JobTitle as cargo,
t4.Name as departamento,
t4.GroupName as Gerencia,
t1.HireDate as 'fecha contrato',
t3.EndDate as 'fin contrato',
t1.BirthDate as 'fecha nacimiento',
t1.MaritalStatus,
t1.Gender
from
HumanResources.Employee as t1
 left join Person.Person as t2 on t1.BusinessEntityID = t2.BusinessEntityID
 left join HumanResources.EmployeeDepartmentHistory as t3 on t1.BusinessEntityID = t3.BusinessEntityID
 left join HumanResources.Department as t4 on t3.DepartmentID = t4.DepartmentID