DROP FUNCTION IF EXISTS [G10_2].[udf_GetInstructor];
GO
-- =============================================
-- Author:		Heesun Arthur
-- Create date: Monday, December 7, 2020
-- Description:	Get the information(LastName, FirstName) of Instructor and return it
-- =============================================
CREATE FUNCTION [G10_2].[udf_GetInstructor]()
RETURNS TABLE
AS
RETURN
	WITH InstructorNames AS (
	    SELECT DISTINCT
			[Instructor]
			,SUBSTRING([Instructor], 1, CHARINDEX(',', [Instructor]) - 1) AS LastName
			,REVERSE(SUBSTRING(REVERSE([Instructor]), 1, CHARINDEX(' ', REVERSE([Instructor]))-1)) AS FirstName
		FROM groupnUploadfile.CoursesFall2020
		WHERE LEN([Instructor]) > 1
	)
	SELECT SUBSTRING(LastName, 1 , CHARINDEX(',',[Instructor])) AS LastName, FirstName
	FROM InstructorNames