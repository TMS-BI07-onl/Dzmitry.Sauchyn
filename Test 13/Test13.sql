1.	Ќаписать запрос на добавление в таблицу manufacturer нового производител€ HP из јмерики.

INSERT INTO manufacturer
VALUES ('HP', 4);


2.	Ќаписать запрос, благодар€ которому возраст пользовател€ јндрей в таблице user уменьшитс€ в 3 раза.

UPDATE user SET age = age / 3 WHERE name = N'јндрей';

3.	Ќайти название продукта с максимальной ценой.

SELECT [Name]
FROM Product
WHERE Price = (SELECT MAX(Price) FROM Product);

4.	Ќаписать запрос на выборку всех пользователей с телефонами, начинающимис€ на 3 и заканчивающимис€ на 4,
либо с возрастом > 35.

SELECT *
FROM [User] u
	INNER JOIN Phone p ON u.Id = p.ID
WHERE p.[Name] LIKE '+3%4'
	OR
	u.Age > 35;


5.	Ќайти топ 5 пользователей, кто купил больше всего продуктов.

SELECT TOP 5 u.Name
FROM
(
SELECT user_id, COUNT(user_id) OVER (PARTITION BY user_id) AS Amount
FROM Order o
	JOIN User u ON u.ID = o.ID
ORDER BY Amount DESC
)











