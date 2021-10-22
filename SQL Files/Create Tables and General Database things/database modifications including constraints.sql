--Alex's code to get the database in a proper state:

DELETE FROM [QueensClassScheduleFall2020].[groupnUploadfile].[CoursesFall2020] WHERE (sec = '') AND (CODE = '') AND ([Course (hr, crd)] = '');
DELETE FROM groupnUploadfile.CoursesFall2020 WHERE SEC='Copyright Â© 2012';
ALTER DATABASE QueensClassScheduleSpring2017
SET SINGLE_USER WITH ROLLBACK IMMEDIATE
ALTER DATABASE QueensClassScheduleSpring2017 MODIFY NAME = QueensClassScheduleFall2020
ALTER DATABASE QueensClassScheduleFall2020
SET MULTI_USER WITH ROLLBACK IMMEDIATE


---Richie:
ALTER TABLE Academics.ModeOfInstruction
ADD CONSTRAINT C_MOIKey UNIQUE (ModeOfInstructionDescription);


------Nabila Azim
------ClassTable Modifications
ALTER TABLE Academics.Class ADD CONSTRAINT [Unique_ClassCode] UNIQUE(ClassCode)


-----Coursetable modifications

ALTER TABLE Academics.Course ADD CONSTRAINT [Unique_Colum] UNIQUE(DepartmentKey)


------Heesun Arthur
------Department Modifications

ALTER TABLE Academics.Department ADD CONSTRAINT DeptCodeLength CHECK(len(DepartmentCode) >=2 AND len(DepartmentCode) <= 20)
ALTER TABLE Academics.Department ADD CONSTRAINT DeptCodeUnique UNIQUE(DepartmentCode)
ALTER TABLE Academics.Department ADD CONSTRAINT C_DepartmentName UNIQUE(DepartmentName)



-----Instructors Table modifications

ALTER TABLE Faculty.Instructor ADD CONSTRAINT InstructorNames CHECK (PATINDEX('%[0-9]%', InstructorFullName) <= 0 )
ALTER TABLE Faculty.Instructor ADD CONSTRAINT InstructorNamesUnique UNIQUE(InstructorFullName)



--Andrew Li 
USE QueensClassScheduleFall2020;

ALTER TABLE Locations.Building
ADD CONSTRAINT AK_BuildingCode UNIQUE (BuildingCode);

ALTER TABLE Locations.Building
ADD CONSTRAINT CHK_BuildingCode CHECK (BuildingCode LIKE '[A-Z][A-Z]');


ALTER TABLE Locations.Room
ADD CONSTRAINT AK_BuildingKey UNIQUE (BuildingKey);

ALTER TABLE Academics.Course ADD CONSTRAINT CourseCreditsLimits CHECK (CourseCredits>=0 AND CourseCredits<=20)
ALTER TABLE Academics.Course ADD CONSTRAINT CourseHoursLimits CHECK (CourseHours>=0 AND CourseHours<=200)


