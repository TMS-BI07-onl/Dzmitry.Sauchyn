CREATE TABLE PeopleChildren (
    [ID] int IDENTITY(1,1),
	[FirstName] nvarchar(50) NOT NULL,
	[ParentName] nvarchar(50) NOT NULL,
	[LastName] nvarchar(50) NOT NULL,
	[ID_Father] int NOT NULL,
	[ID_Mother] int NOT NULL,
	PRIMARY KEY (ID)
);

CREATE TABLE PeopleFather (
    [ID_Father] int IDENTITY(1,1),
	[FirstName] nvarchar(50) NOT NULL,
	[ParentName] nvarchar(50) NOT NULL,
	[LastName] nvarchar(50) NOT NULL,
	PRIMARY KEY (ID_Father)
);


INSERT INTO PeopleChildren (FirstName, ParentName, LastName, ID_Father,ID_Mother)
VALUES
(N'Михаил', N'Александрович', N'Никитин', 1, 1),
(N'Иван', N'Дмитриевич', N'Иванов', 2, 2),
(N'Дмитрий', N'Алексеевич', N'Макаров', 3, 3),
(N'Дмитрий', N'Андреевич', N'Климов', 4, 4)


INSERT INTO PeopleFather (FirstName, ParentName, LastName)
VALUES
(N'Александр', N'Иванович', N'Никитин'),
(N'Дмитрий', N'Иванович', N'Иванов'),
(N'Алексей', N'Петрович', N'Макаров'),
(N'Андрей', N'Петрович', N'Климов')


SELECT TOP 10 *
FROM PeopleChildren;


SELECT TOP 10 *
FROM PeopleFather;


SELECT CONCAT(pc.LastName, ' ', pc.FirstName, ' ', pc.ParentName) AS 'ФИО ребенка', CONCAT(pf.LastName, ' ', pf.FirstName, ' ', pf.ParentName) AS 'ФИО отца' 
FROM PeopleChildren pc
	JOIN PeopleFather pf ON pc.ID_Father = pf.ID_Father
WHERE pc.FirstName LIKE N'Дмитрий'
