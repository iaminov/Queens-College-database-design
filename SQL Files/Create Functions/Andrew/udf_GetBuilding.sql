USE QueensClassScheduleFall2020;

DROP FUNCTION IF EXISTS [G10_2].[udf_GetBuilding]
GO
-- ============================================= 
-- Author: Andrew Li
-- Create date: 12/6/2020
-- Description: Inline-Table Valued Function to separate BuildingCode from Location as well as returning BuildingName
-- =============================================
CREATE FUNCTION [G10_2].[udf_GetBuilding]()
RETURNS TABLE
AS
RETURN
(
	SELECT A.BuildingCode AS [Building_Code],
		   CASE
				WHEN A.BuildingCode LIKE 'AR' THEN 'Amphitheatre'
				WHEN A.BuildingCode LIKE 'CD' THEN 'Career Development'
				WHEN A.BuildingCode LIKE 'CH' THEN 'Colwin Hall'
				WHEN A.BuildingCode LIKE 'DY' THEN 'Delany Hall'
				WHEN A.BuildingCode LIKE 'FG' THEN 'FitzGerald Gym'
				WHEN A.BuildingCode LIKE 'GB' THEN 'G Building'
				WHEN A.BuildingCode LIKE 'GC' THEN 'Gertz Center'
				WHEN A.BuildingCode LIKE 'GT' THEN 'Goldstein Theatre'
				WHEN A.BuildingCode LIKE 'HH' THEN 'Honors Hall'
				WHEN A.BuildingCode LIKE 'IB' THEN 'I Building'
				WHEN A.BuildingCode LIKE 'JH' THEN 'Jefferson Hall'
				WHEN A.BuildingCode LIKE 'KG' THEN 'King Hall'
				WHEN A.BuildingCode LIKE 'KP' THEN 'Klapper Hall'
				WHEN A.BuildingCode LIKE 'KY' THEN 'Kiely Hall'
				WHEN A.BuildingCode LIKE 'MU' THEN 'Music Building'
				WHEN A.BuildingCode LIKE 'PH' THEN 'Powdermaker Hall'
				WHEN A.BuildingCode LIKE 'QH' THEN 'Queens Hall'
				WHEN A.BuildingCode LIKE 'RA' THEN 'Rathaus Hall'
				WHEN A.BuildingCode LIKE 'RE' THEN 'Remsen Hall'
				WHEN A.BuildingCode LIKE 'RO' THEN 'Rosenthal Library'
				WHEN A.BuildingCode LIKE 'RZ' THEN 'Razran Hall'
				WHEN A.BuildingCode LIKE 'SB' THEN 'Science Building'
				WHEN A.BuildingCode LIKE 'SU' THEN 'Student Union'
				ELSE 'To Be Determined'
		   END AS [Building_Name]
	FROM (SELECT DISTINCT SUBSTRING([Location], 1, CHARINDEX(' ', [Location])) AS BuildingCode
		  FROM groupnUploadfile.CoursesFall2020) AS A
	WHERE LEN(A.BuildingCode) > 1
);
GO