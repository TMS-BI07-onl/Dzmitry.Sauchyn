1. Найти ProductSubcategoryID из Production.Product, где мин вес такого ProductSubcategoryID больше 150. 

SELECT ProductSubcategoryID, MIN(Weight)
FROM Production.Product
GROUP BY ProductSubcategoryID
HAVING MIN(Weight) > 150
AND ProductSubcategoryID IS NOT NULL;


2. Найти самый дорогой продукт (поле StandardCost) из Production.Product. (4 способа)

2.1.
SELECT TOP 1 WITH TIES Name, MAX(StandardCost) AS MAX_Price
FROM Production.Product
GROUP BY Name
ORDER BY MAX_Price DESC

2.2.
SELECT Name, StandardCost
FROM Production.Product
WHERE StandardCost = (
	SELECT MAX(StandardCost)
	FROM Production.Product
)

2.3.
SELECT Name
FROM
(
SELECT Name, StandardCost, DENSE_RANK() OVER(ORDER BY StandardCost DESC) AS MAX_Rank
FROM Production.Product
) t
WHERE MAX_Rank = 1

2.4.
SELECT Name
FROM
(
SELECT Name, StandardCost, MAX(StandardCost) OVER(ORDER BY StandardCost DESC) AS MAX_Price
FROM Production.Product
) t
WHERE StandardCost = MAX_Price

3. Найти заплывы, для которых не указан бассейн.

SELECT CompID
FROM [dbo].[Competitions]
WHERE PoolID IS NULL;

4. Найти для каждого судьи кол-во проведенных судейств за последние 15 лет.  (схема GROUP1)

SELECT FirstName, LastName, COUNT(c.CompetitionID) AS CNT
FROM Judge j JOIN Bridge_Judge_Competition jc ON j.JudgeID=jc.JudgeID
			 JOIN Competition c ON jc.CompetitionID=c.CompetitionID
WHERE YEAR(c.Date) BETWEEN  Year(GETDATE())-15 AND Year(GETDATE())
GROUP BY FirstName, LastName

5. 
Users (
    id bigint NOT NULL,
    email varchar(255) NOT NULL
);

Notifications (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    category varchar(100),
    is_read boolean DEFAULT false
);

Найти список категорий для пользователя alex@gmail.com, в которых более 50 непрочитанных нотификаций

SELECT DISTINCT category, COUNT(n.id)
FROM Notifications n
	JOIN Users u ON u.id=n.[user_id]
WHERE email='alex@gmail.com'
	AND is_read = 0
GROUP BY category
HAVING COUNT(n.id) > 50