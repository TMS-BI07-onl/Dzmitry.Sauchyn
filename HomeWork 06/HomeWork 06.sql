USE AdventureWorks2017;			---создание процедуры
GO
CREATE PROCEDURE updateID
	@idnumber NVARCHAR(20),		--переменные
	@entityid NVARCHAR(20)
AS
BEGIN
    UPDATE HumanResources.Employee
	SET NationalIDNumber = @idnumber
	WHERE BusinessEntityID = @entityid
END;


EXEC updateID 879341111, 15; 	--выполнить процедуру для замены


SELECT *						--для проверки
FROM HumanResources.Employee
WHERE BusinessEntityID = 15;
