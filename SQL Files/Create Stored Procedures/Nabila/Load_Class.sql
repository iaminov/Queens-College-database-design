SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS [Project3].[Load_Class]
GO
-- =============================================
-- Author:		Nabila Azim 
-- Create date: 12/05/2020
-- Description:	Stored procedure that inputs data into the class table from 
-- groupnUploadfile.CoursesFall2020
-- @UserAuthorizationKey is the Key of the Group Member who completed 
-- the stored procedure.
-- =============================================

CREATE PROCEDURE [Project3].[Load_Class](
 @UserAuthorizationKey AS [Udt].[SurrogateKeyInt]
)
AS 
BEGIN 

    SET NOCOUNT ON;
	DECLARE @StartTime [udt].[StartingDateTime];
	DECLARE @RowCount [udt].[RowCountInt];
	SET @StartTime = SYSDATETIME();

	INSERT INTO [Academics].Class
	(
	    CourseKey,
	    ClassSection,
	    ModeOfInstructionKey,
	    ClassDay,
	    ClassTime,
	    InstructorKey,
		InstructorFullName,
	    FullLocation,
	    Enrolled,
	    Limit,
	    BuildingKey,
	    RoomKey,
	    Semester,
	    ClassCode,
		UserAuthorizationKey,
		DateAdded,
		DateOfLastUpdate
	)
	SELECT DISTINCT CourseKey
	,CASE
		WHEN LEN([Sec]) > 1 THEN [Sec]
		ELSE CONCAT('0', [Sec])
	 END
	,[ModeOfInstructionKey]
	,CASE
		WHEN [Day] = ' ' THEN 'Day To Be Determined'
		ELSE [Day]
	 END
	,CASE
		WHEN [Time] = '-' THEN 'Time To Be Determined'
		ELSE [Time]
	 END
	,InstructorKey
	,CASE
		WHEN InstructorFullName IS NULL THEN 'Instructor To Be Determined'
		ELSE InstructorFullName
	 END
	,CASE
		WHEN LEN(FullLocation) < 2 THEN 'Location To Be Determined'
		ELSE FullLocation
	 End
	,[Enrolled]
	,[Limit]
	,BuildingKey
	,RoomKey
	,Semester
	,[Code]
	,@UserAuthorizationKey
	,@StartTime
	,@StartTime
	FROM [G10_2].[udf_GetClass]() AS class

	SELECT @RowCount = COUNT(*)
	FROM [Academics].Class

	EXEC Process.usp_TrackWorkFlow @WorkFlowDescription = 'The Class table has been added',
									@WorkFlowStepTableRowCount = @RowCount,
									@StartingDateTime = @StartTime,
									@UserAuthorizationKey = @UserAuthorizationKey
	
	PRINT'The Class table has been added';

END
GO