USE QueensClassScheduleFall2020;

-- Check your foreign keys first
SELECT name AS [foreign_key],
       SCHEMA_NAME(schema_id) AS [schema],
       OBJECT_NAME(parent_object_id) AS [table],
       OBJECT_NAME(referenced_object_id) AS [referenced_table]
FROM sys.foreign_keys;

-- Uncomment after checking
/*
EXEC sp_rename 'Locations.FK_71', 'FK_Room_Building';
GO
EXEC sp_rename 'Academics.FK_34', 'FK_Course_Department';
GO
EXEC sp_rename 'Academics.FK_105', 'FK_BridgeDI_Department';
GO
EXEC sp_rename 'Academics.FK_108', 'FK_BridgeDI_Instructor';
GO
EXEC sp_rename 'Academics.FK_37', 'FK_Class_Course';
GO
EXEC sp_rename 'Academics.FK_47', 'FK_Class_ModeOfInstruction';
GO
EXEC sp_rename 'Academics.FK_54', 'FK_Class_Instructor';
GO
EXEC sp_rename 'Academics.FK_57', 'FK_Class_Building';
GO
EXEC sp_rename 'Academics.FK_60', 'FK_Class_Room';
GO
EXEC sp_rename 'Academics.FK_112', 'FK_BridgeCM_Course';
GO
EXEC sp_rename 'Academics.FK_115', 'FK_BridgeCM_ModeOfInstruction';
GO
*/