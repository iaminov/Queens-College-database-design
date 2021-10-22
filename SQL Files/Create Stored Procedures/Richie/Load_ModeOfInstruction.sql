SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Richie Budijono
-- Create date: Sunday, December 6, 2020
-- Description:	Stored procedure that loads data into the ModeOfInstruction table from 
-- groupnUploadfile.CoursesFall2020
-- @UserAuthorizationKey is the 
-- UserAuthorizationKey of the Group Member who completed 
-- this stored procedure.
-- =============================================

DROP PROCEDURE IF EXISTS [Project3].[Load_ModeOfInstruction];
GO

CREATE PROCEDURE [Project3].[Load_ModeOfInstruction](
	@UserAuthorizationKey AS [udt].[SurrogateKeyInt]
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @StartTime [udt].[StartingDateTime];
	DECLARE @RowCount [udt].[RowCountInt];
	SET @StartTime = SYSDATETIME();

	INSERT INTO Academics.ModeOfInstruction(
		ModeOfInstructionDescription,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
	)
	SELECT [Mode of Instruction], @UserAuthorizationKey, @StartTime, @StartTime
	FROM G10_2.udf_GetModeOfInstruction()


	SELECT @RowCount = COUNT(*)
	FROM Academics.ModeOfInstruction

	EXEC Process.usp_TrackWorkFlow @WorkFlowDescription = 'The Table ModeOfInstruction has been added',
									@WorkFlowStepTableRowCount = @RowCount,
									@StartingDateTime = @StartTime,
									@UserAuthorizationKey = @UserAuthorizationKey
	
    PRINT 'The Table ModeOfInstruction has been added';
END
GO