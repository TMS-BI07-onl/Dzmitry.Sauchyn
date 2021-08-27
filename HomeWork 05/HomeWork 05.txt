CREATE TABLE Patients
(
    ID				int IDENTITY(1,1),
    FirstName		NVARCHAR(40),
    LastName		NVARCHAR(40)	NOT NULL,
	SNN				uniqueidentifier NOT NULL	DEFAULT newid(),
	Email			AS (
					(TRIM(UPPER(SUBSTRING(FirstName, 1, 1)))
					+ (TRIM(LOWER(SUBSTRING(LastName, 1, 3))))) + '@mail.com'),
	Temp			DECIMAL(4,1) CHECK (Temp > 32 AND Temp < 45),
    CreatedDate		DATETIME,
	PRIMARY KEY (ID)
);


/*
CREATE TABLE Persons (
    Personid int NOT NULL AUTO_INCREMENT, -- почему подчеркивает?
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (Personid)
);
*/

/*
Добавляю значения в таблицу
*/
INSERT Patients  
(FirstName, LastName, Temp, CreatedDate)  
VALUES  
	 (N'Andrey', N'Turlov', 36.6, GETDATE())
	,(N'Irina', N'Kolosova', 38.2, GETDATE())
	,(N'Marina', N'Kolmogorova', 36.4, GETDATE())
	,(N'Viktorya', N'Nikitina', 36.5, GETDATE())
	,(N'Igor', N'Urbanovich', 36.6, GETDATE())
	,(N'Vadim', N'Molchan', 36.7, GETDATE())
	,(N'Uriy', N'Ignatov', 37.4, GETDATE())
	,(N'Olga', N'Miluta', 38.2, GETDATE())
	,(N'Masha', N'Rikova', 38.4, GETDATE())
	,(N'Dasha', N'Vasilenko', 35.7, GETDATE())
	,(N'Alexey', N'Kolosov', 36.6, GETDATE())
	,(N'Mikhail', N'Larin', 36.2, GETDATE())
	,(N'Vadim', N'Izmailov', 39.2, GETDATE())
	,(N'Valery', N'Nokin', 36.6, GETDATE())
	,(N'Ludmila', N'Vlasova', 36.0, GETDATE())
	,(N'Nikolay', N'Makarevich', 37.2, GETDATE())
	,(N'Nataliya', N'Ilina', 37.1, GETDATE())
	,(N'Marta', N'Uvarova', 36.8, GETDATE())
	,(N'Petr', N'Mokitov', 42.2, GETDATE())
	,(N'Vladimir', N'Ischin', 39.8, GETDATE())
	,(N'Khristina', N'Rudaya', 37.2, GETDATE())
	,(N'Margo', N'Vitalina', 36.6, GETDATE())
	,(N'Julia', N'Melnikova', 37.2, GETDATE())
	,(N'Masha', N'Boyarina', 36.6, GETDATE())
	;

 SELECT *
 FROM Patients

/*
9.	Добавить поле TempType со следующими значениями ‘< 0°C’,  ‘> 0°C’ на основе значений из поля Temp ( используйте ALTER TABLE 
ADD column AS ). Посмотрите на данные, которые получились.
*/
ALTER TABLE Patients
ADD TempType4 AS 
(
	CASE WHEN Temp = 36.6 THEN N'36,6 - Абсолютно здоров'
		WHEN Temp > 36.6 THEN '>36.6'
		WHEN Temp < 36.6 THEN '<36.6'
	END 
	)
;

/*
10.	Создать представление Patients_v, показывающее температуру в градусах Фаренгейта (°F = °Cx9/5 + 32)
*/
--Очень хотел сделать, чтобы значения выводились с двумя знаками после запятой, но через DECIMAL так и не получилось :-(
SELECT TEMP * 9 / 5 + 32 AS "Temp, °F"
FROM dbo.Patients

SELECT *
FROM [dbo].[Patients_v]

/*
11.	Создать функцию, которая возвращает температуру в градусах Фаренгейта, при подаче на вход градусы в Цельсиях.
*/

CREATE FUNCTION dbo.temp( --создать функцию
    @temp DEC(10,2)
	)
RETURNS DEC(10,2)
AS 
BEGIN
    RETURN @temp * 9 / 5 + 32;
END;

SELECT dbo.temp(36.6) net_sale; --проверить функцию

DROP FUNCTION dbo.temp; --удалить функцию


/*
12. g)	Найдите первый будний день месяца (FROM не используем). Нужен стандартный код на все времена.
*/

DECLARE @date date = FORMAT(GETDATE(), 'yyyy-MM-dd');

SELECT GETDATE(),
	CASE DATEPART (WEEKDAY, @date)
	WHEN 6 THEN DATEADD(DAY, 3, @date)
	WHEN 7 THEN DATEADD(DAY, 2, @date)
	ELSE @date
END AS [First weekday];

DECLARE @date date = FORMAT(GETDATE(), 'yyyy-MM-dd');
SELECT DATEPART (WEEKDAY, @date) --какой номер дня сейчас
