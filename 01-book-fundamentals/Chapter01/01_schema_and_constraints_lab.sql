------------------------------------------------------------
-- Chapter 01: Architecture, Schemas & Constraints Lab
-- Database: Chapter01_Lab
------------------------------------------------------------

USE master;
GO

-- 1. Database Initialization
DROP DATABASE IF EXISTS Chapter01_Lab;
GO

CREATE DATABASE Chapter01_Lab;
GO

USE Chapter01_Lab;
GO

-- 2. Security Boundary: Schema with Explicit Authorization
CREATE SCHEMA HR AUTHORIZATION dbo;
GO

-- 3. Departments Table (Table-Level PK)
CREATE TABLE HR.Departments
(
    DeptID   INT          NOT NULL,
    DeptName VARCHAR(50)  NOT NULL,

    CONSTRAINT PK_Departments_DeptID 
        PRIMARY KEY (DeptID)
);
GO

-- 4. Employees Table (PK, FK, CHECK Constraints & 3VL Setup)
CREATE TABLE HR.Employees
(
    EmployeeID   INT           IDENTITY(1, 1) NOT NULL,
    FirstName    NVARCHAR(50)  NOT NULL,
    LastName     NVARCHAR(50)  NOT NULL,
    BirthDate    DATE          NOT NULL,
    HireDate     DATE          NOT NULL,
    Salary       DECIMAL(10,2) NOT NULL,
    DeptID       INT           NULL, -- Allows NULL for 3VL testing

    -- Primary Key
    CONSTRAINT PK_Employees_EmployeeID 
        PRIMARY KEY (EmployeeID),

    -- Foreign Key
    CONSTRAINT FK_Employees_Departments_DeptID 
        FOREIGN KEY (DeptID) REFERENCES HR.Departments(DeptID),

    -- Business Rule: Minimum 18 years old at hiring
    CONSTRAINT CK_Employees_HireDate_LegalAge 
        CHECK (HireDate >= DATEADD(YEAR, 18, BirthDate)),

    -- Business Rule: Positive Salary
    CONSTRAINT CK_Employees_Salary_Positive 
        CHECK (Salary > 0)
);
GO
