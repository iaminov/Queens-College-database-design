-- =============================================
-- Author: Richie Budijono
-- Table: Process.WorkflowSteps
-- Create date: Saturday, December 5, 2020
-- Description: Create table with defined column names
-- =============================================

--Please create the schema by running the batch containing itself.
-- You can run it by highlighting the schema only and execute.

DROP TABLE IF EXISTS Process.WorkflowSteps
GO
DROP SCHEMA IF EXISTS Process;
GO

CREATE SCHEMA Process;
GO

CREATE TABLE [Process].[WorkflowSteps](
	WorkFlowStepKey [udt].[SurrogateKeyInt] NOT NULL IDENTITY(1,1) PRIMARY KEY, --primary key
	WorkFlowStepDescription [udt].[WorkFlowStepsDescription] NOT NULL,
	WorkFlowStepTableRowCount [udt].[RowCountInt] NOT NULL DEFAULT(0),
	StartingDateTime [udt].[StartingDateTime] NULL DEFAULT(SYSDATETIME()),
	EndingDateTime [udt].[EndingDateTime] NULL DEFAULT(SYSDATETIME()),
	[ClassTime] [udt].[ClassTime] NULL DEFAULT('10:45'),
	UserAuthorizationKey [udt].[SurrogateKeyInt] NOT NULL,
)