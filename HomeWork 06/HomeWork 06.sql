USE AdventureWorks2017;			---�������� ���������
GO
CREATE PROCEDURE updateID
	@idnumber NVARCHAR(20),		--����������
	@entityid NVARCHAR(20)
AS
BEGIN
    UPDATE HumanResources.Employee
	SET NationalIDNumber = @idnumber
	WHERE BusinessEntityID = @entityid
END;


EXEC updateID 879341111, 15; 	--��������� ��������� ��� ������


SELECT *						--��� ��������
FROM HumanResources.Employee
WHERE BusinessEntityID = 15;
