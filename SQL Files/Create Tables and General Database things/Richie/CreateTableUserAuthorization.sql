-- =============================================
-- Author: Richie Budijono
-- Table: DbSecurity.UserAuthorization
-- Create date: Saturday, December 5, 2020
-- Description: Create table with defined column names
-- =============================================

-- Please create the schema by running the batch by itself.
-- You can run it by highlighting the schema only and execute.

DROP TABLE IF EXISTS [DbSecurity].[UserAuthorization]
GO
DROP SCHEMA IF EXISTS [DbSecurity];
GO

CREATE SCHEMA [DbSecurity];
GO

CREATE TABLE [DbSecurity].[UserAuthorization](
	UserAuthorizationKey udt.SurrogateKeyInt NOT NULL IDENTITY(1,1) PRIMARY KEY, --primary key
	ClassTime udt.ClassTime NULL DEFAULT('10:45'),
	IndividualProject udt.IndividualProject NULL DEFAULT('PROJECT 3 ERD'),
	GroupMemberLastName udt.LastName NOT NULL,
	GroupMemberFirstName udt.FirstName NOT NULL,
	GroupName udt.GroupName NULL DEFAULT('G10_2'),
	DateAdded udt.DateAdded NULL DEFAULT(SYSDATETIME())
)

-- Insert Group Members name to DbSecurity.UserAuthorization Table
INSERT INTO [DbSecurity].[UserAuthorization] (
	GroupMemberFirstName,
	GroupMemberLastName
)
VALUES
	('Isakhar', 'Aminov'),	--1
	('Andrew', 'Li'),		--2
	('Nabila', 'Azim'),	--3
	('Shohum', 'Boker'),	--4
	('Heesun', 'Arthur'),	--5
	('Richie', 'Budijono')	--6
GO

-- Show all group members
SELECT *
FROM DbSecurity.UserAuthorization