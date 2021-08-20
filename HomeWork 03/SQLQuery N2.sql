/*
2.	Решите на базе данных AdventureWorks2017 следующие задачи (для поиска ключей можно использовать схему БД ). 
a)	Вывести список цен в виде текстового комментария, основанного на диапазоне цен для продукта:
a.	StandardCost равен 0 или не определен – ‘Not for sale’  
b.	StandardCost больше 0, но меньше 100 – ‘<$100’ 
c.	StandardCost больше или равно 100, но меньше 500 - ‘ <$500' 
d.	Иначе - ‘ >= $500'
Вывести имя продукта и новое поле PriceRange.
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
b)	Найти ProductID, BusinessEntityID и имя поставщика продукции 
из Purchasing.ProductVendor и Purchasing.Vendor, где StandardPrice больше $10.
Также в имени вендора должна присутствовать (вне зависимости от положения) буква X или имя должно начинаться на букву N.
*/

SELECT pv.ProductID, pv.BusinessEntityID, v.Name
FROM Purchasing.ProductVendor pv
	JOIN Purchasing.Vendor v
	ON pv.BusinessEntityID = v.BusinessEntityID
		WHERE pv.StandardPrice > 10
		AND (v.Name LIKE '%X%' OR v.Name LIKE 'N%')

/*
c)	Найти имена всех вендоров, продукция которых не продавалась за всё время.
Необходимо использовать следующую схему соединения таблиц Purchasing.ProductVendor и Purchasing.Vendor:
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
3.	Решить следующие задачи для тестовой базы данных (схема ниже):

a)	Найдите производителей, препараты которых не продавались в 2019 году (подсказка: для выделения года из даты надо использовать одну из функций для работы с датами).
*/
SELECT [Фирмы-производители].[Название]
FROM [Фирмы-производители] t1
	JOIN [Фармпрепараты] t2 ON t1.[id] = t2.[id фирмы]
	JOIN [Продажи] t3 ON t2.[id] = t3.[id фармпрепарата]
	JOIN [Кассовые чеки] t4 ON t3.[id чека] = t4.[id]
		WHERE t4.[Дата] != FORMAT(t4.[Дата], 'yyyy')

/*
b)	Выведите увеличенную в 2 раза цену препаратов типа А.
*/
SELECT [Продажи].[Цена] * 2
FROM [Продажи] t1
	JOIN [Фармпрепараты] t2 ON t1.[id фармпрепарата] = t2.[id]
	JOIN [Типы фармпрепаратов] t3 ON t2.[id типа] = t3.Тип
		WHERE t3.[Тип] = A

/*
c)	Найдите производителей и кол-во фармпрепаратов для кажого из них, где препарат не относится к типу А.
*/
SELECT [Фирмы-производители].[Название], Count([Фармпрепараты].[Название])
FROM [Продажи] t1
	JOIN [Фармпрепараты] t2 ON t1.[id фармпрепарата] = t2.[id]
	JOIN [Типы фармпрепаратов] t3 ON t2.[id типа] = t3.Тип
	JOIN [Фирмы-производители] t4 ON t2.[id типа] = t4.[id]
		WHERE t3.[Тип] != A
GROUP BY [Фирмы-производители].[Название]

/*
d)	Вывести название аптеки и названия фармпрепаратов, которые в
*/

SELECT [Аптечные пункты].[Название], [Фармпрепараты].[Название]
FROM [Продажи] t1
	JOIN [Фармпрепараты] t2 ON t1.[id фармпрепарата] = t2.[id]
	JOIN [Аптечные пункты] t3 ON t1.[id аптечного пункта] = t3.[id]
	JOIN [Кассовые чеки] t4 ON t1.[id чека] = t4.[id]
		WHERE [Кассовые чеки].[Дата] = 'Суббота'