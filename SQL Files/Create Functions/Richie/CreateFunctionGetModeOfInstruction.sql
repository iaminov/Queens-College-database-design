DROP FUNCTION IF EXISTS [G10_2].udf_GetModeOfInstruction;
GO

-- =============================================
-- Author:		Richie Budijono
-- Create date: Saturday, December 12, 2020
-- Description:	Table-valued function that returns the 
-- data from the ModeOfInstruction table
-- =============================================


CREATE FUNCTION [G10_2].udf_GetModeOfInstruction ()
RETURNS TABLE
AS
RETURN
    SELECT DISTINCT [Mode of Instruction]
    FROM groupnUploadfile.CoursesFall2020
	WHERE LEN([Mode of Instruction]) > 1