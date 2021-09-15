1) Ќайдите людей и их номера телефонов, код города которых начинаетс€ на  4 и заканчиваетс€ на 5.
(таблицы Person.PersonPhone, Person.Person)

SELECT CONCAT (p.FirstName, ' ', p.MiddleName, ' ', p.LastName) AS Name, ph.PhoneNumber AS Phone
FROM Person.Person p
	JOIN Person.PersonPhone ph ON p.BusinessEntityID = ph.BusinessEntityID
WHERE PhoneNumber LIKE N'4_5%'


2) ќтнести каждого человека из [HumanResources].[Employee] в свою возрастную категорию:
Adolescence: 17-20
Adults: 21-59
Elderly: 60-75
Senile: 76-90

SELECT DISTINCT p.BusinessEntityID, CONCAT (p.FirstName, ' ', p.MiddleName, ' ', p.LastName) AS Name, YEAR(getdate()) - YEAR(BirthDate) AS OLD,
	CASE WHEN YEAR(getdate()) - YEAR(BirthDate) BETWEEN 17 AND 20 THEN 'Adolescence'
		WHEN YEAR(getdate()) - YEAR(BirthDate) BETWEEN 21 AND 59 THEN 'Adults'
		WHEN YEAR(getdate()) - YEAR(BirthDate) BETWEEN 60 AND 75 THEN 'Elderly'
		WHEN YEAR(getdate()) - YEAR(BirthDate) BETWEEN 76 AND 90 THEN 'Senile'
		ELSE 'no information'
	END BirthDate
FROM [HumanResources].[Employee] e
	JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID


3) ¬ывести самый дорогой продукт дл€ каждого цвета из [Production].[Product]

SELECT *
	FROM
	(
	SELECT DISTINCT p.[Name], p.[Color], p.[StandardCost],
	DENSE_RANK() OVER (PARTITION BY Color ORDER BY [StandardCost] DESC) AS dr
		FROM [Production].[Product] p
	) t
WHERE t.dr = 1