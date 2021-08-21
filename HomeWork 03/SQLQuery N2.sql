/*
2.	������ �� ���� ������ AdventureWorks2017 ��������� ������ (��� ������ ������ ����� ������������ ����� �� ). 
a)	������� ������ ��� � ���� ���������� �����������, ����������� �� ��������� ��� ��� ��������:
a.	StandardCost ����� 0 ��� �� ��������� � �Not for sale�  
b.	StandardCost ������ 0, �� ������ 100 � �<$100� 
c.	StandardCost ������ ��� ����� 100, �� ������ 500 - � <$500' 
d.	����� - � >= $500'
������� ��� �������� � ����� ���� PriceRange.
*/

SELECT DISTINCT Name, ListPrice,
	CASE WHEN ListPrice = 0 THEN 'Not for sale'
		WHEN ListPrice < 100 THEN '<$100'
		WHEN ListPrice <= 500 THEN '<$500'
		ELSE '>=$500'
	END PriceRange
FROM [Production].[Product]
ORDER BY ListPrice, Name

/*
b)	����� ProductID, BusinessEntityID � ��� ���������� ��������� 
�� Purchasing.ProductVendor � Purchasing.Vendor, ��� StandardPrice ������ $10.
����� � ����� ������� ������ �������������� (��� ����������� �� ���������) ����� X ��� ��� ������ ���������� �� ����� N.
*/

SELECT pv.ProductID, pv.BusinessEntityID, v.Name
FROM Purchasing.ProductVendor pv
	JOIN Purchasing.Vendor v
	ON pv.BusinessEntityID = v.BusinessEntityID
		WHERE pv.StandardPrice > 10
		AND (v.Name LIKE '%X%' OR v.Name LIKE 'N%')

/*
c)	����� ����� ���� ��������, ��������� ������� �� ����������� �� �� �����.
���������� ������������ ��������� ����� ���������� ������ Purchasing.ProductVendor � Purchasing.Vendor:
*/

SELECT v.Name
FROM Purchasing.ProductVendor pv
	JOIN Purchasing.Vendor v
	ON pv.BusinessEntityID = v.BusinessEntityID
		WHERE pv.OnOrderQty IS NULL
	EXCEPT
SELECT v.Name
FROM Purchasing.ProductVendor pv
	JOIN Purchasing.Vendor v
	ON pv.BusinessEntityID = v.BusinessEntityID
		WHERE pv.OnOrderQty IS NOT NULL

/*
3.	������ ��������� ������ ��� �������� ���� ������ (����� ����):

a)	������� ��������������, ��������� ������� �� ����������� � 2019 ���� (���������: ��� ��������� ���� �� ���� ���� ������������ ���� �� ������� ��� ������ � ������).
*/
SELECT [�����-�������������].[��������]
FROM [�����-�������������] t1
	JOIN [�������������] t2 ON t1.[id] = t2.[id �����]
	JOIN [�������] t3 ON t2.[id] = t3.[id �������������]
	JOIN [�������� ����] t4 ON t3.[id ����] = t4.[id]
		WHERE t4.[����] != FORMAT(t4.[����], 'yyyy')

/*
b)	�������� ����������� � 2 ���� ���� ���������� ���� �.
*/
SELECT [�������].[����] * 2
FROM [�������] t1
	JOIN [�������������] t2 ON t1.[id �������������] = t2.[id]
	JOIN [���� ��������������] t3 ON t2.[id ����] = t3.���
		WHERE t3.[���] = A

/*
c)	������� �������������� � ���-�� �������������� ��� ������ �� ���, ��� �������� �� ��������� � ���� �.
*/
SELECT [�����-�������������].[��������], Count([�������������].[��������])
FROM [�������] t1
	JOIN [�������������] t2 ON t1.[id �������������] = t2.[id]
	JOIN [���� ��������������] t3 ON t2.[id ����] = t3.���
	JOIN [�����-�������������] t4 ON t2.[id ����] = t4.[id]
		WHERE t3.[���] != A
GROUP BY [�����-�������������].[��������]

/*
d)	������� �������� ������ � �������� ��������������, ������� �
*/

SELECT [�������� ������].[��������], [�������������].[��������]
FROM [�������] t1
	JOIN [�������������] t2 ON t1.[id �������������] = t2.[id]
	JOIN [�������� ������] t3 ON t1.[id ��������� ������] = t3.[id]
	JOIN [�������� ����] t4 ON t1.[id ����] = t4.[id]
		WHERE [�������� ����].[����] = '�������'