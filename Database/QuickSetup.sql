-- Quick database creation script for fn_crm
-- Copy and paste this entire script into SSMS and execute

USE master;
GO

-- Create the database
CREATE DATABASE fn_crm;
GO

-- Switch to the new database
USE fn_crm;
GO

-- Create the Users table first (for login)
CREATE TABLE Users (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Username NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    Email NVARCHAR(200),
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    Role NVARCHAR(50) DEFAULT 'User',
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    LastLoginAt DATETIME,
    LastUpdated DATETIME DEFAULT GETDATE()
);

-- Insert admin user
INSERT INTO Users (Username, Password, Email, FirstName, LastName, Role, IsActive)
VALUES ('admin', 'admin', 'admin@fortressfinance.com', 'System', 'Administrator', 'Admin', 1);

-- Create business tables
CREATE TABLE Customers (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CustomerId NVARCHAR(50) NOT NULL,
    Name NVARCHAR(200) NOT NULL,
    Email NVARCHAR(200),
    Phone NVARCHAR(50),
    Address NVARCHAR(500),
    EmploymentStatus NVARCHAR(100),
    MonthlyIncome DECIMAL(18,2),
    DateOfBirth DATETIME,
    HasActiveLoans BIT,
    Notes NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    LastUpdated DATETIME DEFAULT GETDATE(),
    IdType NVARCHAR(100),
    IdNumber NVARCHAR(100),
    IssuingAuthority NVARCHAR(200),
    ExpirationDate DATETIME,
    AnnualSalary DECIMAL(18,2),
    Position NVARCHAR(200),
    CertificateUrl NVARCHAR(500),
    AssignedTeller NVARCHAR(200)
);

CREATE TABLE LoanApplications (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    ApplicationId NVARCHAR(50) NOT NULL,
    CustomerId NVARCHAR(50),
    ApplicantName NVARCHAR(200) NOT NULL,
    Amount DECIMAL(18,2),
    Purpose NVARCHAR(500),
    ApplicationDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(50) DEFAULT 'Pending',
    InterestRate DECIMAL(5,2) DEFAULT 5.5,
    EmploymentType NVARCHAR(100),
    Income DECIMAL(18,2),
    LoanTerm NVARCHAR(50),
    Notes NVARCHAR(MAX),
    CreatedAt DATETIME DEFAULT GETDATE(),
    LastUpdated DATETIME DEFAULT GETDATE()
);

CREATE TABLE Payments (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CustomerName NVARCHAR(200) NOT NULL,
    PaymentDate DATETIME DEFAULT GETDATE(),
    Amount DECIMAL(18,2),
    PaymentMethod NVARCHAR(100),
    Status NVARCHAR(50),
    ReferenceId NVARCHAR(100),
    Description NVARCHAR(500),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE RevenueDatas (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CustomerId NVARCHAR(50),
    CustomerName NVARCHAR(200),
    LoanAmount DECIMAL(18,2),
    InterestRate DECIMAL(5,2),
    PaidAmount DECIMAL(18,2),
    InterestEarned DECIMAL(18,2),
    Status NVARCHAR(50),
    LoanDate DATETIME DEFAULT GETDATE(),
    LastPaymentDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE OverdueAccounts (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CustomerId NVARCHAR(50),
    CustomerName NVARCHAR(200),
    OutstandingAmount DECIMAL(18,2),
    DaysOverdue INT,
    LastPaymentDate DATETIME DEFAULT GETDATE(),
    NextDueDate DATETIME DEFAULT GETDATE()
);

-- Verify everything was created
SELECT 'Database fn_crm created successfully!' as [Result];
SELECT 'Tables created: ' + CAST(COUNT(*) AS NVARCHAR(10)) as [Table Count] 
FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';

SELECT 'Admin user: ' + Username as [Login Credentials] FROM Users WHERE Username = 'admin';