USE [QueensClassScheduleFall2020]
GO
/****** Object:  StoredProcedure [Project3].[Load_Room]    Script Date: 12/12/2020 2:53:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- ============================================= 
-- Author: Andrew Li
-- Procedure: [Project3].[Load_Room]
-- Create date: 12/8/2020
-- Description: Stored procedure that loads the room locations of all classes in Queens College
-- @GroupMemberUserAuthorizationKey is the UserAuthorizationKey of the group member who completed this stored procedure
-- =============================================
ALTER PROCEDURE [Project3].[Load_Room]
	@GroupMemberAuthorizationKey AS [Udt].[SurrogateKeyInt]
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @StartTime AS [Udt].[StartingDateTime],
			@RowCount AS [Udt].[RowCountInt];

	SET @StartTime = SYSDATETIME();

	INSERT INTO [Locations].[Room]
	(
		[BuildingKey],
	    [RoomNumber],
	    [UserAuthorizationKey],
	    [DateAdded],
	    [DateOfLastUpdate]
	)

	SELECT [BuildingKey], [RoomNumber], @GroupMemberAuthorizationKey, @StartTime, @StartTime
	FROM [G10_2].[udf_GetRoom]()

	SELECT @RowCount = COUNT(*)
	FROM [Locations].[Room]

	EXEC [Process].[usp_TrackWorkFlow] @WorkFlowDescription = 'Locations.Room table has been filled',
									   @WorkFlowStepTableRowCount = @RowCount,
									   @StartingDateTime = @StartTime,
									   @UserAuthorizationKey = @GroupMemberAuthorizationKey;

	PRINT 'The Table Room has been filled';
END;
