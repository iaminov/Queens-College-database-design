USE [QueensClassScheduleFall2020]
GO
/****** Object:  StoredProcedure [Project3].[ShowTableStatusRowCount]    Script Date: 12/11/2020 7:52:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  Andrew Li
-- Procedure: [Project3].[TableStatusRowCount]
-- Create date:  12/11/2020
-- Description:  Return the count of the number of rows for each table by finding the status of each table and using the count function
-- @TableStatus is to tell whether the rows of the tables are being counted before or after the truncation of tables
-- @GroupMemberAuthorizationKey is the group member who completed the stored procedure
-- =============================================
ALTER PROCEDURE [Project3].[ShowTableStatusRowCount]
    @TableStatus AS [Udt].[TableStatus],
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

    SELECT TableStatus = @TableStatus,
           TableName = 'Academics.BridgeBetweenCourseAndModeOfInstruction',
           COUNT(*) AS 'Number of Rows'
    FROM [Academics].[BridgeBetweenCourseAndModeOfInstruction];

    SELECT TableStatus = @TableStatus,
           TableName = 'Academics.BridgeBetweenDepartmentAndInstructor',
           COUNT(*) AS 'Number of Rows'
    FROM [Academics].[BridgeBetweenDepartmentAndInstructor];

    SELECT TableStatus = @TableStatus,
           TableName = 'Academics.Class',
           COUNT(*) AS 'Number of Rows'
    FROM [Academics].[Class];

    SELECT TableStatus = @TableStatus,
           TableName = 'Academics.Course',
           COUNT(*) AS 'Number of Rows'
    FROM [Academics].[Course];

    SELECT TableStatus = @TableStatus,
           TableName = 'Academics.Department',
           COUNT(*) AS 'Number of Rows'
    FROM [Academics].[Department];

    SELECT TableStatus = @TableStatus,
           TableName = 'Academics.ModeOfInstruction',
           COUNT(*) AS 'Number of Rows'
    FROM [Academics].[ModeOfInstruction];

    SELECT TableStatus = @TableStatus,
           TableName = 'Faculty.Instructor',
           COUNT(*) AS 'Number of Rows'
    FROM [Faculty].[Instructor];

    SELECT TableStatus = @TableStatus,
           TableName = 'Locations.Building',
           COUNT(*) AS 'Number of Rows'
    FROM [Locations].[Building];

    SELECT TableStatus = @TableStatus,
           TableName = 'Locations.Room',
           COUNT(*) AS 'Number of Rows'
    FROM [Locations].[Room];

	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowDescription = 'Counting All Rows Of Each Table',
									   @WorkFlowStepTableRowCount = @RowCount,
									   @StartingDateTime = @StartTime,
									   @UserAuthorizationKey = @GroupMemberAuthorizationKey;
END;