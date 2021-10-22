USE QueensClassScheduleFall2020;

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

DROP PROCEDURE IF EXISTS [Project3].[TruncateData];
GO
-- =============================================
-- Author:  Andrew Li
-- Procedure: [Project3].[TruncateData]
-- Create date:  12/6/2020
-- Description:	 Delete all the data within each table of the database using truncate
-- @GroupMemberAuthorizationKey is the group member who completed the stored procedure
-- @BeginTime is the time that the procedure has started executing
-- @RowCount is the number of rows that has been outputted by the stored procedure
-- =============================================
CREATE PROCEDURE [Project3].[TruncateData]
	@GroupMemberAuthorizationKey AS [Udt].[SurrogateKeyInt]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	DECLARE @StartTime AS [Udt].[StartingDateTime],
			@RowCount AS [Udt].[RowCountInt];

	SET @StartTime = SYSDATETIME()
	SET @RowCount = COUNT(*);

	TRUNCATE TABLE Process.WorkflowSteps; 	
	TRUNCATE TABLE [Academics].[BridgeBetweenCourseAndModeOfInstruction];
	TRUNCATE TABLE [Academics].[BridgeBetweenDepartmentAndInstructor];
	TRUNCATE TABLE [Academics].[Class];
	TRUNCATE TABLE [Academics].[Course];
	TRUNCATE TABLE [Academics].[Department];
	TRUNCATE TABLE [Academics].[ModeOfInstruction];
	TRUNCATE TABLE [Faculty].[Instructor];
	TRUNCATE TABLE [Locations].[Building];
	TRUNCATE TABLE [Locations].[Room];

    EXEC [Process].[usp_TrackWorkFlow] @WorkFlowDescription = 'Truncating All Tables',
                                       @WorkFlowStepTableRowCount = @RowCount,
                                       @StartingDateTime = @StartTime,
                                       @UserAuthorizationKey = @GroupMemberAuthorizationKey;
END;