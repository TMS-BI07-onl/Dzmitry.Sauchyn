SELECT TOP 50 with ties TrainerID, FirstName, LastName, SUM(Points) AS PointsTotal
	FROM
		(
SELECT t.TrainerID, t.FirstName, t.LastName
	  ,c.[SwimmerId] ,[CompID], [StyleID], [ResTime], [DisqID], [CompDate],[PoolID]
	  ,DENSE_RANK() OVER (PARTITION BY StyleID, CompDate, PoolID ORDER BY ResTime) AS Place
	  ,CASE WHEN DENSE_RANK() OVER (PARTITION BY StyleID, CompDate, PoolID ORDER BY ResTime) = 1 THEN 3
		WHEN DENSE_RANK() OVER (PARTITION BY StyleID, CompDate, PoolID ORDER BY ResTime) = 2 THEN 2
		WHEN DENSE_RANK() OVER (PARTITION BY StyleID, CompDate, PoolID ORDER BY ResTime) = 3 THEN 1
		ELSE 0
	END Points
FROM [SWIMMING_Comp].[dbo].[Competitions] c
		LEFT JOIN [dbo].[Swimmer] s ON c.SwimmerID = s.SwimmerID
		LEFT JOIN [dbo].[Trainer] t ON s.TrainerID = t.TrainerID
WHERE ResTime IS NOT NULL
) AS a
GROUP BY TrainerID, FirstName, LastName
ORDER BY PointsTotal DESC