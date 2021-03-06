USE QueensClassScheduleFall2020
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Shohum Boker
-- Procedure: [Process].[usp_ShowWorkflowSteps]
-- Create date: 12/6/2020
-- Description:To show track workflow table, each total members execution, and the total execution time of star shema
-- @GroupMemberUserAuthorizationKey is the 
-- UserAuthorizationKey of the Group Member who completed 
-- this stored procedure. 
-- =============================================

CREATE procedure [Process].[usp_ShowWorkflowSteps] (
@GroupMemberUserAuthorizationKey [udt].[SurrogateKeyInt]
) as
begin 
DECLARE @StartTime [udt].[StartingDateTime];;
SET @StartTime = SYSDATETIME();
select * from Process.WorkflowSteps

select UserAuthorizationKey, sum(DATEDIFF(millisecond, StartingDateTime, EndingDateTime)) as total_time_in_ms, COUNT(*) AS number_of_procedures
from Process.WorkflowSteps
group by UserAuthorizationKey 

select sum(DATEDIFF(millisecond, StartingDateTime, EndingDateTime)) as total_time_in_ms_for_entire_database
from Process.WorkflowSteps
group by classtime


end 
