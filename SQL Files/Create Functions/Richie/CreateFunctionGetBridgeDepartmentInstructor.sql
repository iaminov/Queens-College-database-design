DROP FUNCTION IF EXISTS udf_GetBridgeDepartmentInstructor;
GO
-- =============================================
-- Author:		Richie Budijono
-- Create date: Saturday, December 12, 2020
-- Description:	Table-valued function for stored procedure to load data that bridges Departments
--and instructors.
-- =============================================

CREATE FUNCTION G10_2.udf_GetBridgeDepartmentInstructor ()
RETURNS TABLE
AS
RETURN
	SELECT DISTINCT DepartmentKey, InstructorKey, CourseFullInfo
	FROM Academics.Class AS cl
		INNER JOIN Academics.Course AS c
			on c.CourseKey = cl.CourseKey
	WHERE DepartmentKey IS NOT NULL AND InstructorKey IS NOT NULL