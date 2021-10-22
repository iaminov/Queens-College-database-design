USE QueensClassScheduleFall2020;

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

DROP PROCEDURE IF EXISTS [Project3].[AddForeignKeys];
GO
-- =============================================
-- Author:  Andrew Li
-- Procedure:  [Project3].[AddForeignKeys]
-- Create date:  12/6/2020
-- Description:  Add foreign keys to all tables in the database by altering each table and adding constaints
-- @GroupMemberAuthorizationKey is the group member who completed the stored procedure
-- @BeginTime is the time that the procedure has started executing
-- @RowCount is the number of rows that has been outputted by the stored procedure
-- =============================================
CREATE PROCEDURE [Project3].[AddForeignKeys]
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

	ALTER TABLE [Academics].[BridgeBetweenCourseAndModeOfInstruction] WITH CHECK
	ADD CONSTRAINT [FK_BridgeCM_Course]
		FOREIGN KEY (CourseKey)
		REFERENCES [Academics].[Course] (CourseKey);

	ALTER TABLE [Academics].[BridgeBetweenCourseAndModeOfInstruction] WITH CHECK
	ADD CONSTRAINT [FK_BridgeCM_ModeOfInstruction]
		FOREIGN KEY (ModeOfInstructionKey)
		REFERENCES [Academics].[ModeOfInstruction] (ModeOfInstructionKey);

	ALTER TABLE [Academics].[BridgeBetweenDepartmentAndInstructor] WITH CHECK
	ADD CONSTRAINT [FK_BridgeDI_Department]
		FOREIGN KEY (DepartmentKey)
		REFERENCES [Academics].[Department] (DepartmentKey);

	ALTER TABLE [Academics].[BridgeBetweenDepartmentAndInstructor] WITH CHECK
	ADD CONSTRAINT [FK_BridgeDI_Instructor]
		FOREIGN KEY (InstructorKey)
		REFERENCES [Faculty].[Instructor] (InstructorKey);

	ALTER TABLE [Academics].[Class] WITH CHECK
	ADD CONSTRAINT [FK_Class_Course]
		FOREIGN KEY (CourseKey)
		REFERENCES [Academics].[Course] (CourseKey);

	ALTER TABLE [Academics].[Class] WITH CHECK
	ADD CONSTRAINT [FK_Class_ModeOfInstruction]
		FOREIGN KEY (ModeOfInstructionKey)
		REFERENCES [Academics].[ModeOfInstruction] (ModeOfInstructionKey);

	ALTER TABLE [Academics].[Class] WITH CHECK
	ADD CONSTRAINT [FK_Class_Instructor]
		FOREIGN KEY (InstructorKey)
		REFERENCES [Faculty].[Instructor] (InstructorKey);

	ALTER TABLE [Academics].[Class] WITH CHECK
	ADD CONSTRAINT [FK_Class_Building]
		FOREIGN KEY (BuildingKey)
		REFERENCES [Locations].[Building] (BuildingKey);

	ALTER TABLE [Academics].[Class] WITH CHECK
	ADD CONSTRAINT [FK_Class_Room]
		FOREIGN KEY (RoomKey)
		REFERENCES [Locations].[Room] (RoomKey);

	ALTER TABLE [Academics].[Course] WITH CHECK
	ADD CONSTRAINT [FK_Course_Department]
		FOREIGN KEY (DepartmentKey)
		REFERENCES [Academics].[Department] (DepartmentKey);

	ALTER TABLE [Locations].[Room] WITH CHECK
	ADD CONSTRAINT [FK_Room_Building]
		FOREIGN KEY (BuildingKey)
		REFERENCES [Locations].[Building] (BuildingKey);

	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowDescription = 'Adding All Foreign Keys',
									   @WorkFlowStepTableRowCount = @RowCount,
									   @StartingDateTime = @StartTime,
									   @UserAuthorizationKey = @GroupMemberAuthorizationKey;
END;