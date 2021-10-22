USE QueensClassScheduleFall2020

GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

DROP PROCEDURE IF EXISTS [Project3].[Load_Course];
GO

-- =============================================
-- Author:		Nabila Azim
-- Create date: 12/05/2020
-- Description:	Stored procedure that inputs data into the course table from 
-- groupnUploadfile.CoursesFall2020
-- @UserAuthorizationKey is the Key of the Group Member who completed 
-- the stored procedure.
-- =============================================

CREATE PROCEDURE [Project3].[Load_Course](
	@UserAuthorizationKey AS [Udt].[SurrogateKeyInt]
)
AS 
BEGIN 
-- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @StartTime [udt].[StartingDateTime];
	DECLARE @RowCount [udt].[RowCountInt];
	SET @StartTime = SYSDATETIME();

	INSERT INTO Academics.Course
	(
	    DepartmentKey,
	    CourseCode,
	    CourseDescription,
	    CourseFullInfo,
	    CourseHours,
	    CourseCredits,
	    UserAuthorizationKey,
	    DateAdded,
	    DateOfLastUpdate
	)
	SELECT DISTINCT DepartmentKey, CourseCode, [Description], sc.Course, CourseHours, CourseCredits, @UserAuthorizationKey, @StartTime, @StartTime
	FROM G10_2.udf_SeparateCourse() AS sc
		LEFT OUTER JOIN Academics.Department AS d
			on d.DepartmentCode = sc.DeptCode
		LEFT OUTER JOIN groupnUploadfile.CoursesFall2020 as o
			ON sc.Course = o.[Course (hr, crd)]

	SELECT @RowCount = COUNT(*)
	FROM Academics.Course

	EXEC Process.usp_TrackWorkFlow @WorkFlowDescription = 'The Course table has been added',
									@WorkFlowStepTableRowCount = @RowCount,
									@StartingDateTime = @StartTime,
									@UserAuthorizationKey = @UserAuthorizationKey
	
	PRINT'The Course table has been added';
END 
GO