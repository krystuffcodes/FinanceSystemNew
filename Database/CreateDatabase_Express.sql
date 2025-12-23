-- Create the fn_crm database for SQL Server Express
USE master;
GO

-- Drop database if it exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'fn_crm')
BEGIN
    ALTER DATABASE fn_crm SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE fn_crm;
END
GO

-- Create new database (let SQL Server choose the default path)
CREATE DATABASE fn_crm;
GO

USE fn_crm;
GO

-- Create tables for the finance system
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

-- Create Users table for authentication
CREATE TABLE Users (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    Username NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Email NVARCHAR(200),
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    Role NVARCHAR(50) DEFAULT 'User',
    IsActive BIT DEFAULT 1,
    CreatedAt DATETIME DEFAULT GETDATE(),
    LastLoginAt DATETIME,
    LastUpdated DATETIME DEFAULT GETDATE()
);

-- Insert admin user (password: admin)
INSERT INTO Users (Username, PasswordHash, Email, FirstName, LastName, Role, IsActive)
VALUES ('admin', 'admin', 'admin@fortressfinance.com', 'System', 'Administrator', 'Admin', 1);

-- Create indexes for better performance
CREATE INDEX IX_Customers_CustomerId ON Customers(CustomerId);
CREATE INDEX IX_LoanApplications_ApplicationId ON LoanApplications(ApplicationId);
CREATE INDEX IX_LoanApplications_CustomerId ON LoanApplications(CustomerId);
CREATE INDEX IX_Payments_CustomerName ON Payments(CustomerName);
CREATE INDEX IX_Payments_PaymentDate ON Payments(PaymentDate);
CREATE INDEX IX_RevenueDatas_CustomerId ON RevenueDatas(CustomerId);
CREATE INDEX IX_OverdueAccounts_CustomerId ON OverdueAccounts(CustomerId);
CREATE INDEX IX_Users_Username ON Users(Username);

-- Verify tables were created
SELECT 'Tables created:' as Status;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';

-- Verify admin user was created
SELECT 'Admin user created:' as Status;
SELECT Username, Email, Role, IsActive, CreatedAt FROM Users WHERE Username = 'admin';

PRINT 'Database fn_crm created successfully with all tables and admin user!';
PRINT 'Login with: Username = admin, Password = admin';