USE QueensClassScheduleFall2020;

DROP FUNCTION IF EXISTS [G10_2].[udf_GetRoom]
GO
-- ============================================= 
-- Author: Andrew Li
-- Create date: 12/8/2020
-- Description: Inline-Table Valued Function to return the room locations of all courses
-- =============================================
CREATE FUNCTION [G10_2].[udf_GetRoom]()
RETURNS TABLE
AS
RETURN
(
	WITH R AS (
	SELECT [Location],
	SUBSTRING([Location], CHARINDEX(' ', [Location]), LEN([Location])) AS RoomNumber
	FROM groupnUploadfile.CoursesFall2020
	WHERE LEN([Location]) > 1
	)

	SELECT DISTINCT B.BuildingKey, R.RoomNumber
	FROM R
		FULL JOIN Locations.Building AS B
			ON B.[BuildingCode] = SUBSTRING([R].[Location], 1, CHARINDEX(' ', [R].[Location]))
);
GO