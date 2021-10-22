SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Richie Budijono
-- Create date: Saturday, December 12, 2020
-- Description:	Stored procedure to load the BridgeBetweenCourseAndModeOfInstruction table.
-- @UserAuthorizationKey is the UserAuthorizationKey of the Group Member 
-- who completed  this stored procedure.
-- =============================================


DROP PROCEDURE IF EXISTS [Project3].[Load_BridgeCourseMode];
GO

CREATE PROCEDURE [Project3].[Load_BridgeCourseMode](
	@UserAuthorizationKey AS [udt].[SurrogateKeyInt]
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @StartTime [udt].[StartingDateTime];
	DECLARE @RowCount [udt].[RowCountInt];
	SET @StartTime = SYSDATETIME();

	INSERT INTO Academics.BridgeBetweenCourseAndModeOfInstruction(
		CourseKey,
		ModeOfInstructionKey,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
	)
	SELECT CourseKey, ModeOfInstructionKey, @UserAuthorizationKey, @StartTime, @StartTime
	FROM G10_2.udf_GetBridgeCourseMode()

	SELECT @RowCount = COUNT(*)
	FROM Academics.BridgeBetweenDepartmentAndInstructor

	EXEC Process.usp_TrackWorkFlow @WorkFlowDescription = 'The Table BridgeCourseAndModeOfInstruction has been added',
									@WorkFlowStepTableRowCount = @RowCount,
									@StartingDateTime = @StartTime,
									@UserAuthorizationKey = @UserAuthorizationKey
	
    PRINT 'The Table BridgeCourseAndModeOfInstruction has been added';
END
GO