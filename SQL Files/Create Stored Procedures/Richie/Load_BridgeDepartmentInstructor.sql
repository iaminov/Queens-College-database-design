SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Richie Budijono
-- Create date: Saturday, December 12, 2020
-- Description:	Stored procedure to load the BridgeDepartmentInstructor table.
-- @UserAuthorizationKey is the UserAuthorizationKey of the Group Member 
-- who completed  this stored procedure.
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[Load_BridgeDepartmentInstructor];
GO

CREATE PROCEDURE [Project3].[Load_BridgeDepartmentInstructor](
	@UserAuthorizationKey AS [udt].[SurrogateKeyInt]
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @StartTime [udt].[StartingDateTime];
	DECLARE @RowCount [udt].[RowCountInt];
	SET @StartTime = SYSDATETIME();

	INSERT INTO Academics.BridgeBetweenDepartmentAndInstructor(
		DepartmentKey,
		InstructorKey,
		CourseFullInfo,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
	)
	SELECT DepartmentKey, InstructorKey, CourseFullInfo, @UserAuthorizationKey, @StartTime, @StartTime
	FROM G10_2.udf_GetBridgeDepartmentInstructor ()

	SELECT @RowCount = COUNT(*)
	FROM Academics.BridgeBetweenDepartmentAndInstructor

	EXEC Process.usp_TrackWorkFlow @WorkFlowDescription = 'The Table BridgeDepartmentAndInstructor has been added',
									@WorkFlowStepTableRowCount = @RowCount,
									@StartingDateTime = @StartTime,
									@UserAuthorizationKey = @UserAuthorizationKey
	
    PRINT 'The Table BridgeDepartmentAndInstructor has been added';
END
GO