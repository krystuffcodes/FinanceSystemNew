-- Quick Database Connection Test for Dashboard Issues
-- Run this script to verify your database is properly set up for the dashboard

USE fn_crm;
GO

PRINT '=================================================';
PRINT 'Dashboard Database Connectivity Test';
PRINT 'Current Time: ' + CONVERT(VARCHAR, GETDATE(), 120);
PRINT '=================================================';

-- Check if we can connect to the database
SELECT 
    'Connection Test' as TestType,
    'SUCCESS' as Result,
    DB_NAME() as DatabaseName,
    @@SERVERNAME as ServerName;

-- Verify all required tables exist with data
PRINT '';
PRINT 'Table Verification:';
PRINT '-------------------';

-- Check each table individually
IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Users')
BEGIN
    DECLARE @UserCount INT = (SELECT COUNT(*) FROM Users);
    PRINT 'Users table: EXISTS (' + CAST(@UserCount AS VARCHAR) + ' records)';
END
ELSE
    PRINT 'Users table: MISSING - Please run CleanCreateDatabase.sql';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customers')
BEGIN
    DECLARE @CustomerCount INT = (SELECT COUNT(*) FROM Customers);
    PRINT 'Customers table: EXISTS (' + CAST(@CustomerCount AS VARCHAR) + ' records)';
END
ELSE
    PRINT 'Customers table: MISSING - Please run CleanCreateDatabase.sql';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'LoanApplications')
BEGIN
    DECLARE @LoanCount INT = (SELECT COUNT(*) FROM LoanApplications);
    PRINT 'LoanApplications table: EXISTS (' + CAST(@LoanCount AS VARCHAR) + ' records)';
END
ELSE
    PRINT 'LoanApplications table: MISSING - Please run CleanCreateDatabase.sql';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Payments')
BEGIN
    DECLARE @PaymentCount INT = (SELECT COUNT(*) FROM Payments);
    PRINT 'Payments table: EXISTS (' + CAST(@PaymentCount AS VARCHAR) + ' records)';
END
ELSE
    PRINT 'Payments table: MISSING - Please run CleanCreateDatabase.sql';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'RevenueDatas')
BEGIN
    DECLARE @RevenueCount INT = (SELECT COUNT(*) FROM RevenueDatas);
    PRINT 'RevenueDatas table: EXISTS (' + CAST(@RevenueCount AS VARCHAR) + ' records)';
END
ELSE
    PRINT 'RevenueDatas table: MISSING - Please run CleanCreateDatabase.sql';

IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OverdueAccounts')
BEGIN
    DECLARE @OverdueCount INT = (SELECT COUNT(*) FROM OverdueAccounts);
    PRINT 'OverdueAccounts table: EXISTS (' + CAST(@OverdueCount AS VARCHAR) + ' records)';
END
ELSE
    PRINT 'OverdueAccounts table: MISSING - Please run CleanCreateDatabase.sql';

-- Check for sample data
PRINT '';
PRINT 'Sample Data Check:';
PRINT '------------------';

DECLARE @TotalRecords INT = (
    SELECT 
        (SELECT COUNT(*) FROM Users) +
        (SELECT COUNT(*) FROM Customers) +
        (SELECT COUNT(*) FROM LoanApplications) +
        (SELECT COUNT(*) FROM Payments) +
        (SELECT COUNT(*) FROM RevenueDatas) +
        (SELECT COUNT(*) FROM OverdueAccounts)
);

IF @TotalRecords = 0
    PRINT 'NO SAMPLE DATA - Please run InsertSampleData.sql';
ELSE
    PRINT 'Sample data exists: ' + CAST(@TotalRecords AS VARCHAR) + ' total records';

-- Test dashboard specific queries
PRINT '';
PRINT 'Dashboard Query Test:';
PRINT '--------------------';

BEGIN TRY
    -- Test revenue calculation (what dashboard tries to do)
    SELECT 
        'Revenue Query' as TestType,
        COUNT(*) as RecordCount,
        ISNULL(SUM(PaidAmount), 0) as TotalRevenue,
        ISNULL(SUM(InterestEarned), 0) as TotalInterest
    FROM RevenueDatas
    WHERE Status IS NOT NULL;
    
    -- Test customer count (what dashboard tries to do)
    SELECT 
        'Customer Query' as TestType,
        COUNT(*) as TotalCustomers,
        COUNT(CASE WHEN MONTH(CreatedAt) = MONTH(GETDATE()) AND YEAR(CreatedAt) = YEAR(GETDATE()) THEN 1 END) as NewThisMonth
    FROM Customers;
    
    -- Test loan applications (what dashboard tries to do)
    SELECT 
        'Loan Query' as TestType,
        COUNT(*) as TotalApplications,
        COUNT(CASE WHEN Status IN ('Approved', 'Active') THEN 1 END) as ActiveLoans,
        ISNULL(AVG(CASE WHEN Amount IS NOT NULL THEN Amount END), 0) as AverageAmount
    FROM LoanApplications;
    
    PRINT 'Dashboard queries: SUCCESS';
    
END TRY
BEGIN CATCH
    PRINT 'Dashboard queries: FAILED - ' + ERROR_MESSAGE();
END CATCH

-- Connection string verification
PRINT '';
PRINT 'Connection Information:';
PRINT '----------------------';
PRINT 'Server: ' + @@SERVERNAME;
PRINT 'Database: ' + DB_NAME();
PRINT 'Authentication: ' + CASE WHEN IS_SRVROLEMEMBER('sysadmin') = 1 THEN 'Windows (Admin)' ELSE 'Windows (User)' END;

-- Final recommendation
PRINT '';
PRINT 'TROUBLESHOOTING RECOMMENDATIONS:';
PRINT '================================';

IF @TotalRecords = 0
BEGIN
    PRINT '1. Run Database/CleanCreateDatabase.sql to create tables';
    PRINT '2. Run Database/InsertSampleData.sql to add sample data';
END
ELSE
    PRINT '1. Database appears properly configured';

PRINT '2. Verify connection string in appsettings.json matches:';
PRINT '   Server=' + @@SERVERNAME + ';Database=' + DB_NAME() + ';...';
PRINT '3. Ensure SQL Server service is running';
PRINT '4. Check Windows Authentication permissions';
PRINT '5. Restart the .NET application after database changes';

PRINT '';
PRINT 'Test completed at: ' + CONVERT(VARCHAR, GETDATE(), 120);
PRINT '=================================================';