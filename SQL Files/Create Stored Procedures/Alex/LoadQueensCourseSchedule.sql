USE [QueensClassScheduleFall2020]
GO
/****** Object:  StoredProcedure [Project3].[LoadQueensCourseSchedule]    Script Date: 12/11/2020 7:38:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Isakhar Aminov
-- Create date: 12/11/20
-- Description:	 Runs all other stored procedures to truncate then load all the tables in 
-- the QueensClassScheduleFall2020 database. 
-- =============================================

ALTER PROCEDURE [Project3].[LoadQueensCourseSchedule]
AS
BEGIN
    SET NOCOUNT ON;

	

    EXEC  [Project3].[DropForeignKeys] @GroupMemberAuthorizationKey = 2;
	EXEC	[Project3].[ShowTableStatusRowCount] 
		@GroupMemberAuthorizationKey = 2,  
		@TableStatus = N'''Pre-truncate of tables'''

    EXEC [Project3].[TruncateData] @GroupMemberAuthorizationkey = 2;
	EXEC [Project3].[Load_Department] @UserAuthorizationKey = 6;
	EXEC [Project3].[Load_Building] @GroupMemberAuthorizationKey = 2;
	EXEC [Project3].[Load_Room] @GroupMemberAuthorizationKey = 2;
	EXEC [Project3].[Load_Instructor] @UserAuthorizationKey = 5;
	EXEC [Project3].[Load_ModeOfInstruction] @UserAuthorizationKey = 6;
	EXEC [Project3].[Load_Course] @UserAuthorizationKey = 3;
	EXEC [Project3].[Load_Class] @UserAuthorizationKey = 3;
	EXEC [Project3].[Load_BridgeDepartmentInstructor] @UserAuthorizationKey = 6;
	EXEC [Project3].[Load_BridgeCourseMode] @UserAuthorizationKey = 6;
	
	EXEC	[Project3].[ShowTableStatusRowCount]
		@GroupMemberAuthorizationKey = 2,  
		@TableStatus = N'''Row Count after loading the Queens College Class Schedule Database'''

   EXEC [Project3].[AddForeignKeys] @GroupMemberAuthorizationKey = 2; 
    
END;
