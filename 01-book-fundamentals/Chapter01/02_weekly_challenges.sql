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
-- Supplementary Practice: Default Employee Status (DEFAULT Constraint)
-- Scenario: When a new employee is onboarded, their active status 
--           should automatically default to active (1 / TRUE).
-- =================================================================

-- Step 1: Add a new column 'IsActive' of type BIT to HR.Employees
-- Write your ALTER TABLE ADD column statement here:
ALTER TABLE HR.Employees ADD IsActive BIT 


-- Step 2: Add a DEFAULT constraint named 'DF_Employees_IsActive' 
--         setting the default value to 1 for column 'IsActive'
-- Write your ALTER TABLE ADD CONSTRAINT statement here:
ALTER TABLE HR.Employees ADD CONSTRAINT DF_Employees_IsActive 
    DEFAULT(1) FOR IsActive


-- Step 3: Test Case:
-- Insert a new employee record omitting the 'IsActive' column.
-- Verify that 'IsActive' automatically populated with 1.
-- Write your test INSERT and SELECT statements here:

--To update existing records with the new default value
UPDATE HR.Employees
SET IsActive = 1
WHERE IsActive IS NULL;

INSERT INTO HR.Employees(FirstName, LastName, BirthDate, Salary, deptID,IsActive)
VALUES ('Rama','Almalki','1999-07-09',12000,5,0)

INSERT INTO HR.Employees (FirstName, LastName, BirthDate, Salary, deptID)
VALUES ('Tariq', 'Alharbi', '2000-03-15', 9500, 5);



GO

-- =================================================================
-- Challenge 3: Email Format Validation (CHECK Constraint)
-- Objective: Add an Email column and enforce basic email formatting.
-- =================================================================

-- 3.1 Add the Email column to HR.Employees (VARCHAR(100), NULL)
-- Write your ALTER TABLE ADD COLUMN statement here:
ALTER TABLE HR.Employees ADD Email VARCHAR(100) NULL


-- 3.2 Add a CHECK constraint ensuring Email contains '@' and '.'
-- Write your ALTER TABLE ADD CONSTRAINT statement here:
ALTER TABLE HR.Employees ADD CONSTRAINT CK_EMAIL_EMPLOYEES
    CHECK(Email LIKE '%@%' AND Email LIKE'%.%');


-- 3.3 Test Cases:
-- Case A: Valid Email (Should succeed)
-- Case B: Invalid Email without '@' (Should fail with Msg 547)
-- Case C: NULL Email (Should succeed due to 3VL UNKNOWN logic)

INSERT INTO HR.Employees(FirstName, LastName, BirthDate, Salary, deptID,IsActive,Email)
    VALUES('Saad','Almalki','1989-12-12',12000,1,0,'SaadAlmalki@gmail.com')
--Error will happen here
INSERT INTO HR.Employees(FirstName, LastName, BirthDate, Salary, deptID,IsActive,Email)
    VALUES('Sara','Alharbi','2001-01-22',9000,1,1,'SaraAlharbigmail.com')
--Error 2 will happen here
INSERT INTO HR.Employees(FirstName, LastName, BirthDate, Salary, deptID,IsActive,Email)
    VALUES('Asma','Alharbi','2000-01-07',19000,1,1,'AsmaAlharbi@gmailcom')
--Case C 
    
-- Reason: Under SQL 3-Valued Logic (3VL), evaluating NULL returns UNKNOWN.
-- A CHECK constraint rejects data ONLY if the expression evaluates to FALSE; 
-- therefore, both TRUE and UNKNOWN are accepted.
INSERT INTO HR.Employees(FirstName, LastName, BirthDate, Salary, deptID,IsActive,Email)
    VALUES('Lana','Alharbi','2002-11-02',10000,1,1,NULL)


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
