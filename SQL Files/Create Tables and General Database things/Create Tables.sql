-- ****************** SqlDBM: Microsoft SQL Server ******************
-- ******************************************************************

DROP TABLE IF EXISTS [Academics].[Class];
GO

DROP TABLE IF EXISTS [Academics].[BridgeBetweenCourseAndModeOfInstruction];
GO

DROP TABLE IF EXISTS [Locations].[Room];
GO

DROP TABLE IF EXISTS [Academics].[Course];
GO

DROP TABLE IF EXISTS [Academics].[BridgeBetweenDepartmentAndInstructor];
GO

DROP TABLE IF EXISTS [Academics].[ModeOfInstruction];
GO

DROP TABLE IF EXISTS [Faculty].[Instructor];
GO

DROP TABLE IF EXISTS [Academics].[Department];
GO

DROP TABLE IF EXISTS [Locations].[Building];
GO

-- ************************************** [Academics].[ModeOfInstruction]

CREATE TABLE [Academics].[ModeOfInstruction]
(
 [ModeOfInstructionKey]         [udt].[surrogatekeyint] IDENTITY (1, 1) NOT NULL ,
 [ModeOfInstructionDescription] [udt].[description] NOT NULL ,
 [UserAuthorizationKey]         [udt].[surrogatekeyint] NOT NULL ,
 [DateAdded]                    [udt].[dateadded] NOT NULL CONSTRAINT [DF_ModeOfInstruction_DateAdded] DEFAULT sysdatetime() ,
 [DateOfLastUpdate]             [udt].[dateoflastupdate] NOT NULL ,


 CONSTRAINT [PK_modeofinstruction] PRIMARY KEY CLUSTERED ([ModeOfInstructionKey] ASC)
);
GO

-- ************************************** [Faculty].[Instructor]

CREATE TABLE [Faculty].[Instructor]
(
 [InstructorKey]        [udt].[surrogatekeyint] IDENTITY (1, 1) NOT NULL ,
 [InstructorFirstName]  [udt].[firstname] NULL ,
 [InstructorLastName]   [udt].[lastname] NULL ,
 [InstructorFullName]   AS concat(InstructorLastName, ', ', InstructorFirstName) PERSISTED NOT NULL ,
 [UserAuthorizationKey] [udt].[surrogatekeyint] NOT NULL ,
 [DateAdded]            [udt].[dateadded] NOT NULL ,
 [DateOfLastUpdate]     [udt].[dateoflastupdate] NOT NULL ,


 CONSTRAINT [PK_instructor] PRIMARY KEY CLUSTERED ([InstructorKey] ASC)
);
GO

-- ************************************** [Academics].[Department]

CREATE TABLE [Academics].[Department]
(
 [DepartmentKey]        [udt].[surrogatekeyint] IDENTITY (1, 1) NOT NULL ,
 [DepartmentCode]       [udt].[departmentcode] NOT NULL ,
 [DepartmentName]       [udt].[departmentname] NOT NULL ,
 [UserAuthorizationKey] [udt].[surrogatekeyint] NOT NULL ,
 [DateAdded]            [udt].[dateadded] NOT NULL ,
 [DateOfLastUpdate]     [udt].[dateoflastupdate] NOT NULL ,


 CONSTRAINT [PK_department] PRIMARY KEY CLUSTERED ([DepartmentKey] ASC)
);
GO

-- ************************************** [Locations].[Building]

CREATE TABLE [Locations].[Building]
(
 [BuildingKey]          [udt].[surrogatekeyint] IDENTITY (1, 1) NOT NULL ,
 [BuildingCode]         [udt].[buildingcode] NOT NULL ,
 [BuildingName]         [udt].[buildingname] NOT NULL ,
 [UserAuthorizationKey] [udt].[surrogatekeyint] NOT NULL ,
 [DateAdded]            [udt].[dateadded] NOT NULL ,
 [DateOfLastUpdate]     [udt].[dateoflastupdate] NOT NULL ,


 CONSTRAINT [PK_buildinglocation] PRIMARY KEY CLUSTERED ([BuildingKey] ASC)
);
GO

-- ************************************** [Locations].[Room]

CREATE TABLE [Locations].[Room]
(
 [RoomKey]              [udt].[surrogatekeyint] IDENTITY (1, 1) NOT NULL ,
 [BuildingKey]          [udt].[surrogatekeyint] NOT NULL ,
 [RoomNumber]           [udt].[roomnumber] NOT NULL ,
 [UserAuthorizationKey] [udt].[surrogatekeyint] NOT NULL ,
 [DateAdded]            [udt].[dateadded] NOT NULL ,
 [DateOfLastUpdate]     [udt].[dateoflastupdate] NOT NULL ,


 CONSTRAINT [PK_roomlocation] PRIMARY KEY CLUSTERED ([RoomKey] ASC),
 CONSTRAINT [FK_71] FOREIGN KEY ([BuildingKey])  REFERENCES [Locations].[Building]([BuildingKey])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_71] ON [Locations].[Room] 
 (
  [BuildingKey] ASC
 )

GO

-- ************************************** [Academics].[Course]

CREATE TABLE [Academics].[Course]
(
 [CourseKey]            [udt].[surrogatekeyint] IDENTITY (1, 1) NOT NULL ,
 [DepartmentKey]        [udt].[surrogatekeyint] NOT NULL ,
 [CourseCode]           [udt].[coursecode] NOT NULL ,
 [CourseDescription]    [udt].[description] NOT NULL ,
 [CourseFullInfo]       [udt].[coursefullinfo] NOT NULL ,
 [CourseHours]          [udt].[coursehoursint] NOT NULL ,
 [CourseCredits]        [udt].[coursecreditsint] NOT NULL ,
 [UserAuthorizationKey] [udt].[surrogatekeyint] NOT NULL ,
 [DateAdded]            [udt].[dateadded] NOT NULL ,
 [DateOfLastUpdate]     [udt].[dateoflastupdate] NOT NULL ,


 CONSTRAINT [PK_course] PRIMARY KEY CLUSTERED ([CourseKey] ASC),
 CONSTRAINT [FK_34] FOREIGN KEY ([DepartmentKey])  REFERENCES [Academics].[Department]([DepartmentKey])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_34] ON [Academics].[Course] 
 (
  [DepartmentKey] ASC
 )

GO

-- ************************************** [Academics].[BridgeBetweenDepartmentAndInstructor]

CREATE TABLE [Academics].[BridgeBetweenDepartmentAndInstructor]
(
 [DepartmentKey] [udt].[surrogatekeyint] NOT NULL ,
 [InstructorKey] [udt].[surrogatekeyint] NOT NULL ,


 CONSTRAINT [FK_105] FOREIGN KEY ([DepartmentKey])  REFERENCES [Academics].[Department]([DepartmentKey]),
 CONSTRAINT [FK_108] FOREIGN KEY ([InstructorKey])  REFERENCES [Faculty].[Instructor]([InstructorKey])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_105] ON [Academics].[BridgeBetweenDepartmentAndInstructor] 
 (
  [DepartmentKey] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_108] ON [Academics].[BridgeBetweenDepartmentAndInstructor] 
 (
  [InstructorKey] ASC
 )

GO

-- ************************************** [Academics].[Class]


CREATE TABLE [Academics].[Class]
(
 [Semester]             [udt].[semester] NOT NULL ,
 [ClassKey]             [udt].[surrogatekeyint] IDENTITY (1, 1) NOT NULL ,
 [ClassSection]         [udt].[classsection] NOT NULL ,
 [ClassCode]            [udt].[classcodeint] NULL ,
 [CourseKey]            [udt].[surrogatekeyint] NOT NULL ,
 [InstructorKey]        [udt].[surrogatekeyint] NULL ,
 [BuildingKey]          [udt].[surrogatekeyint] NULL ,
 [RoomKey]              [udt].[surrogatekeyint] NULL ,
 [ModeOfInstructionKey] [udt].[surrogatekeyint] NOT NULL ,
 [ClassDay]             [udt].[classday] NOT NULL ,
 [ClassTime]            [udt].[classday] NOT NULL ,
 [InstructorFullName]   [udt].[FullName] DEFAULT('Instructor To Be Determined') NULL,
 [FullLocation]         [udt].[fulllocation] DEFAULT('Location To Be Determined') NOT NULL,
 [Enrolled]             [udt].[enrolledint] NOT NULL ,
 [Limit]                [udt].[enrolledlimitint] NOT NULL ,
 [Overtally]            AS (CASE WHEN Enrolled > Limit THEN Enrolled - Limit ELSE 0 END) Persisted NOT NULL,
 [UserAuthorizationKey] [udt].[surrogatekeyint] NOT NULL ,
 [DateAdded]            [udt].[dateadded] NOT NULL ,
 [DateOfLastUpdate]     [udt].[dateoflastupdate] NOT NULL ,


 CONSTRAINT [PK_class] PRIMARY KEY CLUSTERED ([ClassKey] ASC),
 CONSTRAINT [FK_37] FOREIGN KEY ([CourseKey])  REFERENCES [Academics].[Course]([CourseKey]),
 CONSTRAINT [FK_47] FOREIGN KEY ([ModeOfInstructionKey])  REFERENCES [Academics].[ModeOfInstruction]([ModeOfInstructionKey]),
 CONSTRAINT [FK_54] FOREIGN KEY ([InstructorKey])  REFERENCES [Faculty].[Instructor]([InstructorKey]),
 CONSTRAINT [FK_57] FOREIGN KEY ([BuildingKey])  REFERENCES [Locations].[Building]([BuildingKey]),
 CONSTRAINT [FK_60] FOREIGN KEY ([RoomKey])  REFERENCES [Locations].[Room]([RoomKey]),
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_37] ON [Academics].[Class] 
 (
  [CourseKey] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_48] ON [Academics].[Class] 
 (
  [ModeOfInstructionKey] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_54] ON [Academics].[Class] 
 (
  [InstructorKey] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_58] ON [Academics].[Class] 
 (
  [BuildingKey] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_61] ON [Academics].[Class] 
 (
  [RoomKey] ASC
 )

GO

-- ************************************** [Academics].[BridgeBetweenCourseAndModeOfInstruction]

CREATE TABLE [Academics].[BridgeBetweenCourseAndModeOfInstruction]
(
 [CourseKey]            [udt].[surrogatekeyint] NOT NULL ,
 [ModeOfInstructionKey] [udt].[surrogatekeyint] NOT NULL ,


 CONSTRAINT [FK_112] FOREIGN KEY ([CourseKey])  REFERENCES [Academics].[Course]([CourseKey]),
 CONSTRAINT [FK_115] FOREIGN KEY ([ModeOfInstructionKey])  REFERENCES [Academics].[ModeOfInstruction]([ModeOfInstructionKey])
);
GO


CREATE NONCLUSTERED INDEX [fkIdx_112] ON [Academics].[BridgeBetweenCourseAndModeOfInstruction] 
 (
  [CourseKey] ASC
 )

GO

CREATE NONCLUSTERED INDEX [fkIdx_115] ON [Academics].[BridgeBetweenCourseAndModeOfInstruction] 
 (
  [ModeOfInstructionKey] ASC
 )

GO