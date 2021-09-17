SELECT *
FROM [dbo].[data_for_merge]
ORDER BY [Function_count] DESC

MERGE INTO [dbo].[data_for_merge] AS TGT
USING [dbo].[data_for_merge] AS SRC
ON TGT.[IrinaPashkovich] = SRC.[Darya]
WHEN MATCHED AND SRC.[Darya] IS NOT NULL
THEN UPDATE SET TGT.[Function_count] = IFNULL(TGT.[Function_count],0)+1 --Почему не становится 0?
;

MERGE INTO [dbo].[data_for_merge] AS TGT
USING [dbo].[data_for_merge] AS SRC
ON TGT.[IrinaPashkovich] = SRC.[Darya]
WHEN MATCHED AND SRC.[Darya] IS NOT NULL
THEN UPDATE SET TGT.[Function_count] = TGT.[Function_count]+1
;

MERGE INTO [dbo].[data_for_merge] AS TGT
USING [dbo].[data_for_merge] AS SRC
ON TGT.[IrinaPashkovich] = SRC.[Ekaterina]
WHEN MATCHED AND SRC.[Ekaterina] IS NOT NULL
THEN UPDATE SET TGT.[Function_count] = TGT.[Function_count]+1
;

MERGE INTO [dbo].[data_for_merge] AS TGT
USING [dbo].[data_for_merge] AS SRC
ON TGT.[IrinaPashkovich] = SRC.[IrinaSelyutina]
WHEN MATCHED AND SRC.[IrinaSelyutina] IS NOT NULL
THEN UPDATE SET TGT.[Function_count] = TGT.[Function_count]+1
;

MERGE INTO [dbo].[data_for_merge] AS TGT
USING [dbo].[data_for_merge] AS SRC
ON TGT.[IrinaPashkovich] = SRC.[Viktor]
WHEN MATCHED AND SRC.[Viktor] IS NOT NULL
THEN UPDATE SET TGT.[Function_count] = TGT.[Function_count]+1
;

MERGE INTO [dbo].[data_for_merge] AS TGT
USING [dbo].[data_for_merge] AS SRC
ON TGT.[IrinaPashkovich] = SRC.[Dmitriy]
WHEN MATCHED AND SRC.[Dmitriy] IS NOT NULL
THEN UPDATE SET TGT.[Function_count] = TGT.[Function_count]+1
;

MERGE INTO [dbo].[data_for_merge] AS TGT
USING [dbo].[data_for_merge] AS SRC
ON TGT.[IrinaPashkovich] = SRC.[Svetlana]
WHEN MATCHED AND SRC.[Svetlana] IS NOT NULL
THEN UPDATE SET TGT.[Function_count] = TGT.[Function_count]+1
;

MERGE INTO [dbo].[data_for_merge] AS TGT
USING [dbo].[data_for_merge] AS SRC
ON TGT.[IrinaPashkovich] = SRC.[VikaVoronchuk]
WHEN MATCHED AND SRC.[VikaVoronchuk] IS NOT NULL
THEN UPDATE SET TGT.[Function_count] = TGT.[Function_count]+1
;

MERGE INTO [dbo].[data_for_merge] AS TGT
USING [dbo].[data_for_merge] AS SRC
ON TGT.[IrinaPashkovich] = SRC.[VikaOstopchuk]
WHEN MATCHED AND SRC.[VikaOstopchuk] IS NOT NULL
THEN UPDATE SET TGT.[Function_count] = TGT.[Function_count]+1
;