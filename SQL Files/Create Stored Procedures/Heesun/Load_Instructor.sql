SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS [Project3].[Load_Instructor];
GO
-- =============================================
-- Author:		Heesun Arthur
-- Create date: Sunday, December 6, 2020
-- Description:	Stored procedure that loads data into the Instructor's table from 
-- groupnUploadfile.CoursesFall2020
-- @UserAuthorizationKey is the 
-- UserAuthorizationKey of the Group Member who completed 
-- this stored procedure.
-- =============================================

CREATE PROCEDURE [Project3].[Load_Instructor](
	@UserAuthorizationKey AS [udt].[SurrogateKeyInt]
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @StartTime [udt].[StartingDateTime];
	DECLARE @RowCount [udt].[RowCountInt];
	SET @StartTime = SYSDATETIME();

	INSERT INTO Faculty.Instructor(
		InstructorFirstName,
		InstructorLastName,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
	)
	SELECT FirstName, LastName, @UserAuthorizationKey, @StartTime, @StartTime
	FROM G10_2.udf_GetInstructor()


	SELECT @RowCount = COUNT(*)
	FROM Faculty.Instructor

	EXEC Process.usp_TrackWorkFlow @WorkFlowDescription = 'The Table Instructor has been added',
									@WorkFlowStepTableRowCount = @RowCount,
									@StartingDateTime = @StartTime,
									@UserAuthorizationKey = @UserAuthorizationKey
	
    PRINT 'The Table Instructor has been added';
END
GO

EXEC Project3.Load_Instructor @UserAuthorizationKey = 3