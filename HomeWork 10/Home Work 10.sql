SELECT y AS OrderYear, [1], [2], [12]
FROM
(
SELECT MONTH(DueDate) as m, OrderQty, YEAR(DueDate) as y
FROM Production.WorkOrder
) AS SourceTable
PIVOT
(
SUM (OrderQty)
FOR m IN ([1], [2], [12])
) AS PivotTable
ORDER BY y