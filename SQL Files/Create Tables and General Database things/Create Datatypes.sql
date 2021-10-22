CREATE SCHEMA udt;
GO

DROP TYPE [udt].[SurrogateKeyInt];
GO
DROP TYPE [udt].[DateAdded];
GO
DROP TYPE [udt].[DateOfLastUpdate];
GO
DROP TYPE [udt].[ClassTime];
GO
DROP TYPE [udt].[ClassSection];
GO
DROP TYPE [udt].[ClassDay];
GO
DROP TYPE [udt].[ClassCodeInt];
GO
DROP TYPE [udt].[FullLocation];
GO
DROP TYPE [udt].[EnrolledInt];
GO
DROP TYPE [udt].[EnrolledLimitInt];
GO
DROP TYPE [udt].[OvertallyInt];
GO
DROP TYPE [udt].[Semester];
GO
DROP TYPE [udt].[DepartmentCode];
GO
DROP TYPE [udt].[DepartmentName];
GO
DROP TYPE [udt].[BuildingCode];
GO
DROP TYPE [udt].[BuildingName];
GO
DROP TYPE [udt].[RoomNumber];
GO
DROP TYPE [udt].[Description];
GO
DROP TYPE [udt].[CourseCodeInt];
GO
DROP TYPE [udt].[CourseFullInfo];
GO
DROP TYPE [udt].[CourseHoursInt];
GO
DROP TYPE [udt].[CourseCreditsInt];
GO
DROP TYPE [udt].[IndividualProject];
GO
DROP TYPE [udt].[LastName];
GO
DROP TYPE [udt].[FirstName];
GO
DROP TYPE [udt].[GroupName];
GO
DROP TYPE [udt].[FullName];
GO
DROP TYPE [udt].[WorkFlowStepsDescription];
GO
DROP TYPE [udt].[StartingDateTime];
GO
DROP TYPE [udt].[EndingDateTime];
GO
DROP TYPE [udt].[RowCountInt];
GO

CREATE TYPE [udt].[SurrogateKeyInt] FROM [INT] NOT NULL;
GO
CREATE TYPE [udt].[DateAdded] FROM DATETIME2(7) NOT NULL;
GO
CREATE TYPE [udt].[DateOfLastUpdate] FROM DATETIME2(7) NOT NULL;
GO
CREATE TYPE [udt].[ClassTime] FROM NVARCHAR(40) NOT NULL;
GO
CREATE TYPE [udt].[ClassSection] FROM NVARCHAR(40) NOT NULL;
GO
CREATE TYPE [udt].[ClassDay] FROM NVARCHAR(40) NOT NULL;
GO
CREATE TYPE [udt].[ClassCodeInt] FROM INT NOT NULL;
GO
CREATE TYPE [udt].[FullLocation] FROM NVARCHAR(50) NOT NULL;
GO
CREATE TYPE [udt].[EnrolledInt] FROM INT NOT NULL;
GO
CREATE TYPE [udt].[EnrolledLimitInt] FROM INT NOT NULL;
GO
CREATE TYPE [udt].[OvertallyInt] FROM INT NOT NULL;
GO
CREATE TYPE [udt].[Semester] FROM NVARCHAR(30) NOT NULL;
GO
CREATE TYPE [udt].[DepartmentCode] FROM NVARCHAR(10) NOT NULL;
GO
CREATE TYPE [udt].[DepartmentName] FROM NVARCHAR(50) NOT NULL;
GO
CREATE TYPE [udt].[BuildingCode] FROM NVARCHAR(10) NOT NULL;
GO
CREATE TYPE [udt].[BuildingName] FROM NVARCHAR(30) NOT NULL;
GO
CREATE TYPE [udt].[RoomNumber] FROM NVARCHAR(30) NOT NULL;
GO
CREATE TYPE [udt].[Description] FROM NVARCHAR(50) NOT NULL;
GO
CREATE TYPE [udt].[CourseCode] FROM NVARCHAR(10) NOT NULL;
GO
CREATE TYPE [udt].[CourseFullInfo] FROM NVARCHAR(50) NOT NULL;
GO
CREATE TYPE [udt].[CourseHoursInt] FROM DECIMAL(6, 2) NOT NULL;
GO
CREATE TYPE [udt].[CourseCreditsInt] FROM DECIMAL(6, 2) NOT NULL;
GO
CREATE TYPE [udt].[IndividualProject] FROM NVARCHAR(60) NOT NULL;
GO
CREATE TYPE [udt].[LastName] FROM NVARCHAR(30) NULL;
GO
CREATE TYPE [udt].[FirstName] FROM NVARCHAR(30) NULL;
GO
CREATE TYPE [udt].[GroupName] FROM NVARCHAR(20) NOT NULL;
GO
CREATE TYPE [udt].[FullName] FROM NVARCHAR(60) NULL;
GO
CREATE TYPE [udt].[WorkFlowStepsDescription] FROM NVARCHAR(100)
GO
CREATE TYPE [udt].[StartingDateTime] FROM DATETIME2(7);
GO
CREATE TYPE [udt].[EndingDateTime] FROM DATETIME2(7);
GO
CREATE TYPE [udt].[RowCountInt] FROM INT NOT NULL;
GO
CREATE TYPE [udt].[TableStatus] FROM NVARCHAR(50) NOT NULL;
GO