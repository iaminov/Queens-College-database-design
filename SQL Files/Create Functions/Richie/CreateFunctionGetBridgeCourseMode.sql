DROP FUNCTION IF EXISTS G10_2.udf_GetBridgeCourseMode;
GO
-- =============================================
-- Author:		Richie Budijono
-- Create date: Sunday, December 6, 2020
-- Description:	Table-valued function for stored procedure to load data.
-- =============================================

CREATE FUNCTION G10_2.udf_GetBridgeCourseMode()
RETURNS TABLE
AS
RETURN
	SELECT DISTINCT CourseKey, ModeOfInstructionKey
	FROM Academics.Class
	WHERE CourseKey IS NOT NULL AND ModeOfInstructionKey IS NOT NULL