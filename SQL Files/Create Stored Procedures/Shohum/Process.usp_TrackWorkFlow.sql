-- =============================================
-- Author: Shohum Boker
-- Procedure: [Process].[usp_TrackWorkFlow]
-- Create date: 12/5/2020
-- Description:To track workflow for group memebers along the project 
-- =============================================

DROP PROCEDURE IF EXISTS [Process].[usp_TrackWorkFlow];
GO

CREATE PROCEDURE [Process].[usp_TrackWorkFlow](
	@WorkFlowDescription [udt].[WorkFlowStepsDescription],
	@WorkFlowStepTableRowCount [udt].[RowCountInt],
	@StartingDateTime [udt].[StartingDateTime],
	@UserAuthorizationKey [udt].[SurrogateKeyInt]
)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @EndingDateTime [udt].[EndingDateTime];
	SET @EndingDateTime = SYSDATETIME();
	INSERT INTO Process.WorkflowSteps(
		WorkFlowStepDescription, 
		WorkFlowStepTableRowCount,
		StartingDateTime,
		EndingDateTime,
		UserAuthorizationKey
	)
	SELECT @WorkFlowDescription, @WorkFlowStepTableRowCount, @StartingDateTime, @EndingDateTime, @UserAuthorizationKey
END
GO