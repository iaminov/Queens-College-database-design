USE QueensClassScheduleFall2020;

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

DROP PROCEDURE IF EXISTS [Project3].[Load_Building];
GO
-- ============================================= 
-- Author: Andrew Li
-- Procedure: [Project3].[Load_Building]
-- Create date: 12/2/2020
-- Description: Stored procedure that loads the building locations of all classes in Queens College
-- @GroupMemberUserAuthorizationKey is the UserAuthorizationKey of the group member who completed this stored procedure
-- =============================================
CREATE PROCEDURE [Project3].[Load_Building]
	@GroupMemberAuthorizationKey AS [Udt].[SurrogateKeyInt]
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @StartTime AS [Udt].[StartingDateTime],
			@RowCount AS [Udt].[RowCountInt];

	SET @StartTime = SYSDATETIME();

	INSERT INTO [Locations].[Building]
	(
	    [BuildingCode],
	    [BuildingName],
	    [UserAuthorizationKey],
	    [DateAdded],
	    [DateOfLastUpdate]
	)
	SELECT [Building_Code], [Building_Name], @GroupMemberAuthorizationKey, @StartTime, @StartTime
	FROM [G10_2].[udf_GetBuilding]() 

	SELECT @RowCount = COUNT(*)
	FROM [Locations].[Building]

	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowDescription = 'Locations.Building table has been filled',
									   @WorkFlowStepTableRowCount = @RowCount,
									   @StartingDateTime = @StartTime,
									   @UserAuthorizationKey = @GroupMemberAuthorizationKey;

	PRINT 'The Table Building has been filled';
END;
GO