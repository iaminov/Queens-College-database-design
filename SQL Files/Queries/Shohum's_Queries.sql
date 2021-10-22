USE QueensClassScheduleFall2020

-- 1-Show all instructors who are teaching in classes in multiple departments
select InstructorFirstName + ' ' + InstructorLastName as InstructorName
from Academics.Course  as O
     join Academics.Class as C
     on C.CourseKey = O.CourseKey
     JOIN Faculty.Instructor as I
     on I.InstructorKey = C.InstructorKey
group by InstructorFirstName + ' ' + InstructorLastName
having count(Departmentkey) > 1
GO
select Instructorkey
from Academics.BridgeBetweenDepartmentAndInstructor
group by (Instructorkey) 
having count(distinct Departmentkey) > 1
GO

-- 2-How many instructors are in each department?
SELECT DepartmentKey, COUNT(InstructorKey) AS Instructors
FROM Academics.BridgeBetweenDepartmentAndInstructor
GROUP BY DepartmentKey
GO

-- 3-How many classes that are being taught that semester grouped by course and aggregating the total enrollment, 
--   total class limit and the percentage of enrollment.
SELECT CourseKey, SUM(Enrolled) AS TotalEnrolled, SUM(Limit) AS TotalLimit, SUM(Enrolled) * 100 / NULLIF(SUM(Limit), 0) AS PercentEnrolled
FROM Academics.Class
GROUP BY CourseKey
GO

-- 4-How many rooms are being used in each building
select B.BuildingKey, count(R.RoomKey) as NumOfRooms
from Locations.Building as B
     join Locations.Room as R
     on B.BuildingKey = R.BuildingKey
group by B.BuildingKey

-- 5-How many classes are being taught in each mode of instruction
select ModeOfInstructionKey, count(CourseKey) AS NumOfClasses
from Academics.BridgeBetweenCourseAndModeOfInstruction
group by ModeOfInstructionKey

-- 6-How many students are on a waitlist for each class
select ClassKey, count(Overtally) AS WaitList
from Academics.class
group by ClassKey

-- 7-Returns the date of last update for each course
SELECT CourseKey, DateOfLastUpdate
from Academics.course

-- 8-How many instructors are teaching more than 5 classes and show their count 
SELECT InstructorKey, COUNT(ClassKey) AS NumOfClasses
FROM Academics.Class
GROUP BY InstructorKey
HAVING COUNT(ClassKey) > 5
ORDER BY NumOfClasses