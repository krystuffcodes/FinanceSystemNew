-- Create missing business tables in fn_crm database
-- Users table already exists, so we'll skip it
USE fn_crm;
GO

-- Check if tables exist and create them if they don't exist

-- Create Customers table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Customers' AND xtype='U')
BEGIN
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
    PRINT 'Customers table created successfully';
END
ELSE
BEGIN
    PRINT 'Customers table already exists';
END

-- Create LoanApplications table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='LoanApplications' AND xtype='U')
BEGIN
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
    PRINT 'LoanApplications table created successfully';
END
ELSE
BEGIN
    PRINT 'LoanApplications table already exists';
END

-- Create Payments table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='Payments' AND xtype='U')
BEGIN
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
    PRINT 'Payments table created successfully';
END
ELSE
BEGIN
    PRINT 'Payments table already exists';
END

-- Create RevenueDatas table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='RevenueDatas' AND xtype='U')
BEGIN
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
    PRINT 'RevenueDatas table created successfully';
END
ELSE
BEGIN
    PRINT 'RevenueDatas table already exists';
END

-- Create OverdueAccounts table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='OverdueAccounts' AND xtype='U')
BEGIN
    CREATE TABLE OverdueAccounts (
        Id UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
        CustomerId NVARCHAR(50),
        CustomerName NVARCHAR(200),
        OutstandingAmount DECIMAL(18,2),
        DaysOverdue INT,
        LastPaymentDate DATETIME DEFAULT GETDATE(),
        NextDueDate DATETIME DEFAULT GETDATE()
    );
    PRINT 'OverdueAccounts table created successfully';
END
ELSE
BEGIN
    PRINT 'OverdueAccounts table already exists';
END

-- Create indexes for better performance
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Customers_CustomerId')
    CREATE INDEX IX_Customers_CustomerId ON Customers(CustomerId);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_LoanApplications_ApplicationId')
    CREATE INDEX IX_LoanApplications_ApplicationId ON LoanApplications(ApplicationId);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_LoanApplications_CustomerId')
    CREATE INDEX IX_LoanApplications_CustomerId ON LoanApplications(CustomerId);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Payments_CustomerName')
    CREATE INDEX IX_Payments_CustomerName ON Payments(CustomerName);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Payments_PaymentDate')
    CREATE INDEX IX_Payments_PaymentDate ON Payments(PaymentDate);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_RevenueDatas_CustomerId')
    CREATE INDEX IX_RevenueDatas_CustomerId ON RevenueDatas(CustomerId);

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_OverdueAccounts_CustomerId')
    CREATE INDEX IX_OverdueAccounts_CustomerId ON OverdueAccounts(CustomerId);

-- Display summary of all tables
SELECT 
    TABLE_NAME as 'Table Name',
    CASE 
        WHEN TABLE_NAME = 'Users' THEN 'Already existed'
        ELSE 'Created/Verified'
    END as 'Status'
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

-- Verify Users table exists and show its structure
IF EXISTS (SELECT * FROM sysobjects WHERE name='Users' AND xtype='U')
BEGIN
    PRINT 'Users table exists - checking admin user...';
    SELECT Username, Role, IsActive, CreatedAt FROM Users WHERE Username = 'admin';
END
ELSE
BEGIN
    PRINT 'ERROR: Users table does not exist!';
END

PRINT 'Database setup completed successfully!';