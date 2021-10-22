DROP FUNCTION IF EXISTS [G10_2].[udf_GetClass]
GO
-- =============================================
-- Author:		Nabila Azim
-- Create date: December 6, 2020
-- Description:	Inline Table valued function whcih returns the data 
--from the Class table
-- =============================================
CREATE FUNCTION [G10_2].[udf_GetClass]()
RETURNS TABLE
AS RETURN 
	SELECT min(c.CourseKey) AS CourseKey
	,min([Sec]) AS Sec
	,min(moi.[ModeOfInstructionKey]) AS ModeOfInstructionKey
	,min([Day]) AS [Day]
	,min([Time]) AS [Time]
	,min(i.InstructorKey) AS InstructorKey
	,min(InstructorFullName) AS InstructorFullname
	,CONCAT(min(BuildingCode), ' ', min(RoomNumber)) AS FullLocation
	,min([Enrolled]) AS Enrolled
	,min([Limit]) AS Limit
	,min(b.BuildingKey) AS BuildingKey
	,min(r.RoomKey) AS RoomKey
	,'Fall2020' AS Semester
	,min([Code]) AS Code
	FROM groupnUploadfile.CoursesFall2020 AS o
		LEFT OUTER JOIN Academics.Course AS c
			ON c.CourseFullInfo = o.[Course (hr, crd)]
		LEFT OUTER JOIN Academics.ModeOfInstruction as moi
			ON moi.ModeOfInstructionDescription = o.[Mode of Instruction]
		LEFT OUTER JOIN Faculty.Instructor as i
			ON i.InstructorFullName = o.Instructor
		LEFT OUTER JOIN Locations.Building AS b
			ON b.BuildingCode = SUBSTRING(o.[Location], 1, CHARINDEX(' ', o.[Location]))
		LEFT OUTER JOIN Locations.Room AS r
			ON r.RoomNumber = SUBSTRING(o.[Location], CHARINDEX(' ', o.[Location]), LEN(o.[Location]))
	GROUP BY Code
