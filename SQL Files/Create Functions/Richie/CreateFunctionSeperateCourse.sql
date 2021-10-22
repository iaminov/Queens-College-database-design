USE [QueensClassScheduleFall2020]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Richie Budijono
-- Create date: Sunday, December 6, 2020
-- Description:	Separate Course into into 4 columns
--				CourseName, CourseCode, Hours, Credits
-- =============================================
ALTER FUNCTION [G10_2].[udf_SeparateCourse]()
RETURNS TABLE 
AS
RETURN
	WITH C AS(
		SELECT DISTINCT
			[Course (hr, crd)] AS Course
			,[value]
			,ROW_NUMBER() OVER(PARTITION BY [Course (hr, crd)] ORDER BY (SELECT NULL)) as rn
		FROM groupnUploadfile.CoursesFall2020
			CROSS APPLY STRING_SPLIT([Course (hr, crd)], ' ') AS BK
			)
	SELECT Course,
			[1] AS DeptCode,
			[2] AS CourseCode,
			SUBSTRING([3], 2, LEN([3])-2) AS [CourseHours],
			SUBSTRING([4], 1, LEN([4])-1) AS [CourseCredits]
			--SUBSTRING([3], 2,
			--	CASE
			--		WHEN LEN([3]) > 0 THEN LEN([3]) - 2
			--		ELSE LEN([3])
			--	END) AS [Hours],
			--SUBSTRING([4], 1,
			--	CASE
			--		WHEN LEN([4]) = 2 THEN LEN([3]) - 2
			--		ELSE LEN([4])
			--	END) AS [Credits]
	FROM C
	PIVOT(
		MAX(VALUE)
		FOR RN IN([1],[2],[3],[4])  
	) as PVT
	WHERE LEN(Course) > 1
