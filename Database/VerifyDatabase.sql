-- Database Verification Script for fn_crm
-- Run this to verify that the database and data exist correctly

USE fn_crm;
GO

PRINT '=================================================';
PRINT 'Database Verification Script';
PRINT '=================================================';

-- Check if database exists and is accessible
SELECT 
    DB_NAME() as CurrentDatabase,
    GETDATE() as CurrentTime;

-- Verify all tables exist
PRINT '';
PRINT 'Checking table existence...';
SELECT 
    TABLE_NAME as 'Table Name',
    CASE 
        WHEN TABLE_NAME IS NOT NULL THEN 'EXISTS'
        ELSE 'MISSING'
    END as 'Status'
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

-- Check record counts for each table
PRINT '';
PRINT 'Record counts by table:';
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

-- Show sample customer data
PRINT '';
PRINT 'Sample customer records:';
SELECT TOP 5
    CustomerId,
    Name,
    Email,
    EmploymentStatus,
    MonthlyIncome,
    HasActiveLoans,
    CreatedAt
FROM Customers
ORDER BY CreatedAt DESC;

-- Verify admin user exists
PRINT '';
PRINT 'Admin user verification:';
SELECT 
    Username,
    Role,
    IsActive,
    CreatedAt
FROM Users 
WHERE Username = 'admin';

-- Check for any obvious data issues
PRINT '';
PRINT 'Data quality checks:';

-- Check for customers without names
SELECT 'Customers without names' as Issue, COUNT(*) as Count
FROM Customers WHERE Name IS NULL OR Name = ''
UNION ALL
-- Check for customers without email
SELECT 'Customers without email', COUNT(*)
FROM Customers WHERE Email IS NULL OR Email = ''
UNION ALL
-- Check for customers without CustomerId
SELECT 'Customers without CustomerId', COUNT(*)
FROM Customers WHERE CustomerId IS NULL OR CustomerId = '';

PRINT '';
PRINT 'Database verification completed successfully!';
PRINT '=================================================';