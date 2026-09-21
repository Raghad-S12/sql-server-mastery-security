/*
====================================================================
Chapter 01: Practical Reinforcement Challenges
Database: Chapter01_Lab
Topics Covered: UNIQUE, DEFAULT, CHECK Constraints, Referential Integrity
====================================================================
*/

USE Chapter01_Lab;
GO

-- =================================================================
-- Challenge 1: Unique Department Names (UNIQUE Constraint)
-- Objective: Ensure no two departments have the same name.
-- =================================================================

-- 1.1 Add the UNIQUE constraint on DeptName
-- Write your ALTER TABLE statement here:
ALTER TABLE HR.Departments ADD CONSTRAINT UQ_Departments_DeptName UNIQUE(DeptName)

INSERT INTO HR.Departments(deptID, DeptName) 
    VALUES(5,'HR')
SELECT * FROM HR.Departments
/* Here error will ocuur because we add unique constraint on deptName */
-- 1.2 Test Case: Try inserting a duplicate department name
-- Expected Error: Msg 2627 (Violation of UNIQUE KEY constraint)
-- Write your test INSERT statement here:

INSERT INTO HR.Departments(deptID, DeptName) 
    VALUES(7,'HR')

GO

-- =================================================================
-- Challenge 2: Automatic Hire Date (DEFAULT Constraint)
-- Objective: Automatically set HireDate to the current system date 
--            if omitted during INSERT.
-- =================================================================

-- 2.1 Add the DEFAULT constraint to HireDate
-- Write your ALTER TABLE statement here (Hint: use SYSDATETIME() or GETDATE()):
ALTER TABLE HR.Employees ADD CONSTRAINT DF_Employees_HireDate 
 DEFAULT CAST(GETDATE()AS DATE) FOR HireDate


-- 2.2 Test Case: Insert an employee without specifying the HireDate column
-- Verify that the current date was populated automatically.
-- Write your test INSERT and SELECT statements here:
INSERT INTO HR.Employees (FirstName, LastName, BirthDate, Salary, deptID)
VALUES 
    ('Raghad','alotaybi','1990-07-01',12000,5)
SELECT * FROM HR.Employees



GO

-- =================================================================
-- Challenge 3: Email Format Validation (CHECK Constraint)
-- Objective: Add an Email column and enforce basic email formatting.
-- =================================================================

-- 3.1 Add the Email column to HR.Employees (VARCHAR(100), NULL)
-- Write your ALTER TABLE ADD COLUMN statement here:



-- 3.2 Add a CHECK constraint ensuring Email contains '@' and '.'
-- Write your ALTER TABLE ADD CONSTRAINT statement here:



-- 3.3 Test Cases:
-- Case A: Valid Email (Should succeed)
-- Case B: Invalid Email without '@' (Should fail with Msg 547)
-- Case C: NULL Email (Should succeed due to 3VL UNKNOWN logic)



GO

-- =================================================================
-- Challenge 4: Parent-Child Relationship & Deletion Behavior
-- Objective: Observe referential integrity when attempting to delete 
--            a referenced primary key record.
-- =================================================================

-- 4.1 Attempt to delete Department 1 which already has assigned employees:
-- DELETE FROM HR.Departments WHERE deptID = 1;

-- 4.2 Reflection Questions:
-- Q1: What error message and number were returned by the engine?
-- Q2: What steps must be executed to delete Department 1 safely 
--     without corrupting or violating referential integrity?
-- Write your answers as comments below:



GO
