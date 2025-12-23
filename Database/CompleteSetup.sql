-- COMPLETE SOLUTION: Clean Database Setup for fn_crm
-- Execute this script in SSMS connected to LAPTOP-9U7RNK0I\SQLEXPRESS

USE master;
GO

-- Drop database if it exists
IF EXISTS (SELECT name FROM sys.databases WHERE name = N'fn_crm')
BEGIN
    -- Close all connections to the database
    ALTER DATABASE fn_crm SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE fn_crm;
    PRINT 'Existing fn_crm database dropped.';
END
GO

-- Create new database
CREATE DATABASE fn_crm;
GO

PRINT 'fn_crm database created successfully.';

USE fn_crm;
GO

-- 1. Create Users table (for authentication)
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
PRINT 'Users table created.';

-- 2. Create Customers table (main customer data)
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
PRINT 'Customers table created.';

-- 3. Create LoanApplications table
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
PRINT 'LoanApplications table created.';

-- 4. Create Payments table
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
PRINT 'Payments table created.';

-- 5. Create RevenueDatas table
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
PRINT 'RevenueDatas table created.';

-- 6. Create OverdueAccounts table
CREATE TABLE OverdueAccounts (
    Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    CustomerId NVARCHAR(50),
    CustomerName NVARCHAR(200),
    OutstandingAmount DECIMAL(18,2),
    DaysOverdue INT,
    LastPaymentDate DATETIME DEFAULT GETDATE(),
    NextDueDate DATETIME DEFAULT GETDATE()
);
PRINT 'OverdueAccounts table created.';

-- Insert admin user
INSERT INTO Users (Username, Password, Email, FirstName, LastName, Role, IsActive)
VALUES ('admin', 'admin', 'admin@fortressfinance.com', 'System', 'Administrator', 'Admin', 1);
PRINT 'Admin user created.';

-- Create performance indexes
CREATE INDEX IX_Users_Username ON Users(Username);
CREATE INDEX IX_Customers_CustomerId ON Customers(CustomerId);
CREATE INDEX IX_Customers_Name ON Customers(Name);
CREATE INDEX IX_Customers_Email ON Customers(Email);
CREATE INDEX IX_LoanApplications_ApplicationId ON LoanApplications(ApplicationId);
CREATE INDEX IX_LoanApplications_CustomerId ON LoanApplications(CustomerId);
CREATE INDEX IX_Payments_CustomerName ON Payments(CustomerName);
CREATE INDEX IX_Payments_PaymentDate ON Payments(PaymentDate);
CREATE INDEX IX_RevenueDatas_CustomerId ON RevenueDatas(CustomerId);
CREATE INDEX IX_OverdueAccounts_CustomerId ON OverdueAccounts(CustomerId);
PRINT 'Indexes created for better performance.';

-- Insert sample customer data to test the system
INSERT INTO Customers (CustomerId, Name, Email, Phone, Address, EmploymentStatus, MonthlyIncome, DateOfBirth, HasActiveLoans, Notes, IdType, IdNumber, IssuingAuthority, AnnualSalary, Position, AssignedTeller) VALUES
('CUST-2024-001', 'John Smith', 'john.smith@email.com', '+1-555-0101', '123 Main St, New York, NY 10001', 'Employed', 5500.00, '1985-03-15', 0, 'Reliable customer', 'Driver''s License', 'DL123456789', 'NY DMV', 66000.00, 'Software Engineer', 'Admin User'),
('CUST-2024-002', 'Sarah Johnson', 'sarah.johnson@email.com', '+1-555-0102', '456 Oak Ave, Los Angeles, CA 90210', 'Employed', 4800.00, '1990-07-22', 1, 'Has active personal loan', 'State ID Card', 'ID987654321', 'CA DMV', 57600.00, 'Marketing Manager', 'Admin User'),
('CUST-2024-003', 'Michael Brown', 'michael.brown@email.com', '+1-555-0103', '789 Pine Rd, Chicago, IL 60601', 'Self-Employed', 6200.00, '1982-11-08', 0, 'Business owner', 'Passport', 'P123456789', 'State Department', 74400.00, 'Restaurant Owner', 'Admin User');

PRINT 'Sample customer data inserted.';

-- Verify everything was created successfully
PRINT '';
PRINT '===============================================';
PRINT 'DATABASE SETUP COMPLETED SUCCESSFULLY!';
PRINT '===============================================';
PRINT 'Server: LAPTOP-9U7RNK0I\SQLEXPRESS';
PRINT 'Database: fn_crm';
PRINT 'Login: Username=admin, Password=admin';
PRINT '';

-- Show table summary
SELECT 
    TABLE_NAME as 'Table Name',
    'Ready' as 'Status'
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

-- Show record counts
SELECT 'Users' as TableName, COUNT(*) as RecordCount FROM Users
UNION ALL
SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL
SELECT 'LoanApplications', COUNT(*) FROM LoanApplications
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payments
UNION ALL
SELECT 'RevenueDatas', COUNT(*) FROM RevenueDatas
UNION ALL
SELECT 'OverdueAccounts', COUNT(*) FROM OverdueAccounts;

-- Verify admin user
SELECT 'ADMIN LOGIN VERIFICATION:' as Info;
SELECT Username, Password, Role, IsActive, CreatedAt FROM Users WHERE Username = 'admin';

PRINT '';
PRINT 'You can now run your MAUI application and login with admin/admin';
PRINT 'The database error should be resolved!';