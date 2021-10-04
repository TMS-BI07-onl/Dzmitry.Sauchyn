1. Найти ProductSubcategoryID из Production.Product, где мин вес такого ProductSubcategoryID больше 150. 

SELECT ProductSubcategoryID, MIN(Weight)
FROM Production.Product
GROUP BY ProductSubcategoryID
HAVING MIN(Weight) > 150
AND ProductSubcategoryID IS NOT NULL;


2. Найти самый дорогой продукт (поле StandardCost) из Production.Product. (4 способа)

SELECT TOP 1 WITH TIES Name, MAX(StandardCost) AS MAX_Price
FROM Production.Product
GROUP BY Name
ORDER BY MAX_Price DESC

3. Найти заплывы, для которых не указан бассейн.

SELECT CompID
FROM [dbo].[Competitions]
WHERE PoolID IS NULL;

4. Найти для каждого судьи кол-во проведенных судейств за последние 15 лет.  (схема GROUP1)

SELECT TOP 10 *
FROM [dbo].[Competitions] c
	--JOIN [dbo].[Trainer] t ON c.SwimmerId = t.

	WHERE CompDate >= YEAR(CompDate) - 15

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

SELECT category, count()
FROM Users u
	JOIN Notifications n ON u.id = n.user_id
GROUP BY u.id
HAVING BY count() > 50

SELECT category
FROM Users
WHERE email LIKE N'alex@gmail.com'