SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP PROCEDURE IF EXISTS [Project3].[Load_Department];
GO
-- =============================================
-- Author:		Heesun Arthur
-- Create date: Sunday, December 6, 2020
-- Description:	Stored procedure that loads data into the Department's table from 
-- groupnUploadfile.CoursesFall2020
-- @UserAuthorizationKey is the 
-- UserAuthorizationKey of the Group Member who completed 
-- this stored procedure.
-- =============================================

CREATE PROCEDURE [Project3].[Load_Department](
	@UserAuthorizationKey AS [udt].[SurrogateKeyInt]
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @StartTime [udt].[StartingDateTime];
	DECLARE @RowCount [udt].[RowCountInt];
	SET @StartTime = SYSDATETIME();

	INSERT INTO Academics.Department(
		DepartmentCode,
		DepartmentName,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
	)
	SELECT Deptcode, DepartmentName, @UserAuthorizationKey, @StartTime, @StartTime
	FROM G10_2.udf_GetDepartment()


	SELECT @RowCount = COUNT(*)
	FROM Academics.Department

	EXEC Process.usp_TrackWorkFlow @WorkFlowDescription = 'The Table Department has been added',
									@WorkFlowStepTableRowCount = @RowCount,
									@StartingDateTime = @StartTime,
									@UserAuthorizationKey = @UserAuthorizationKey
	
    PRINT 'The Table Department has been added';
END
GO