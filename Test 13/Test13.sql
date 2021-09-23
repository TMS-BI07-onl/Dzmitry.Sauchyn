1.	�������� ������ �� ���������� � ������� manufacturer ������ ������������� HP �� �������.

INSERT INTO manufacturer
VALUES ('HP', 4);


2.	�������� ������, ��������� �������� ������� ������������ ������ � ������� user ���������� � 3 ����.

UPDATE user SET age = age / 3 WHERE name = N'������';

3.	����� �������� �������� � ������������ �����.

SELECT [Name]
FROM Product
WHERE Price = (SELECT MAX(Price) FROM Product);

4.	�������� ������ �� ������� ���� ������������� � ����������, ������������� �� 3 � ���������������� �� 4,
���� � ��������� > 35.

SELECT *
FROM [User] u
	INNER JOIN Phone p ON u.Id = p.ID
WHERE p.[Name] LIKE '+3%4'
	OR
	u.Age > 35;


5.	����� ��� 5 �������������, ��� ����� ������ ����� ���������.

SELECT TOP 5 u.Name
FROM
(
SELECT user_id, COUNT(user_id) OVER (PARTITION BY user_id) AS Amount
FROM Order o
	JOIN User u ON u.ID = o.ID
ORDER BY Amount DESC
)











