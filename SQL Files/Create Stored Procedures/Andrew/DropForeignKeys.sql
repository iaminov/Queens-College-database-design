USE [QueensClassScheduleFall2020]
GO
/****** Object:  StoredProcedure [Project3].[DropForeignKeys]    Script Date: 12/12/2020 12:46:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:  Andrew Li
-- Procedure:  [Project3].[DropForeignKeys]
-- Create date:  12/6/2020
-- Description:  Drop all of the foreign keys from all tables in the database by altering each table and dropping the constraints
-- @GroupMemberAuthorizationKey is the group member who completed the stored procedure
-- @BeginTime is the time that the procedure has started executing
-- @RowCount is the number of rows that has been outputted by the stored procedure
-- =============================================
ALTER PROCEDURE [Project3].[DropForeignKeys]
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

	ALTER TABLE [Academics].[BridgeBetweenDepartmentAndInstructor]
	DROP CONSTRAINT IF EXISTS [FK_BridgeDI_Department];
	ALTER TABLE [Academics].[BridgeBetweenDepartmentAndInstructor]
	DROP CONSTRAINT IF EXISTS	[FK_BridgeDI_Instructor];

	ALTER TABLE [Academics].[BridgeBetweenCourseAndModeOfInstruction]
	DROP CONSTRAINT IF EXISTS [FK_BridgeCM_Course];
	ALTER TABLE [Academics].[BridgeBetweenCourseAndModeOfInstruction]
	DROP CONSTRAINT IF EXISTS[FK_BridgeCM_ModeOfInstruction];

	ALTER TABLE [Academics].[Class]
	DROP CONSTRAINT IF EXISTS [FK_Class_Course];
	ALTER TABLE [Academics].[Class]
	DROP CONSTRAINT IF EXISTS 	[FK_Class_ModeOfInstruction];
	ALTER TABLE [Academics].[Class]
	DROP CONSTRAINT IF EXISTS 	[FK_Class_Instructor];
	ALTER TABLE [Academics].[Class]
	DROP CONSTRAINT IF EXISTS 	[FK_Class_Building];
	ALTER TABLE [Academics].[Class]
	DROP CONSTRAINT IF EXISTS 	[FK_Class_Room];

	ALTER TABLE [Academics].[Course]
	DROP CONSTRAINT IF EXISTS [FK_Course_Department];

	ALTER TABLE [Locations].[Room]
	DROP CONSTRAINT IF EXISTS [FK_Room_Building];

	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowDescription = 'Dropping All Foreign Keys',
									   @WorkFlowStepTableRowCount = @RowCount,
									   @StartingDateTime = @StartTime,
									   @UserAuthorizationKey = @GroupMemberAuthorizationKey;
END;