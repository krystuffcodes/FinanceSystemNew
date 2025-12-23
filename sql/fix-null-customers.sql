-- Fix NULLs in dbo.Customers
-- Run this in SSMS against the fn_crm database.
SET NOCOUNT ON;
BEGIN TRANSACTION;

-- Inspect counts before
SELECT 'Before' AS Stage, COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END) AS MonthlyIncomeNulls,
    SUM(CASE WHEN HasActiveLoans IS NULL THEN 1 ELSE 0 END) AS HasActiveLoansNulls,
    SUM(CASE WHEN DateOfBirth IS NULL THEN 1 ELSE 0 END) AS DateOfBirthNulls,
    SUM(CASE WHEN IdType IS NULL THEN 1 ELSE 0 END) AS IdTypeNulls
FROM dbo.Customers;

-- Update sensible defaults where appropriate
UPDATE dbo.Customers
SET MonthlyIncome = 0
WHERE MonthlyIncome IS NULL;

UPDATE dbo.Customers
SET HasActiveLoans = 0
WHERE HasActiveLoans IS NULL;

UPDATE dbo.Customers
SET DateOfBirth = '1900-01-01'
WHERE DateOfBirth IS NULL;

UPDATE dbo.Customers
SET Notes = ''
WHERE Notes IS NULL;

UPDATE dbo.Customers
SET IdType = 'Unknown'
WHERE IdType IS NULL;

UPDATE dbo.Customers
SET IdNumber = ''
WHERE IdNumber IS NULL;

UPDATE dbo.Customers
SET IssuingAuthority = ''
WHERE IssuingAuthority IS NULL;

UPDATE dbo.Customers
SET ExpirationDate = '2099-12-31'
WHERE ExpirationDate IS NULL;

UPDATE dbo.Customers
SET AnnualSalary = 0
WHERE AnnualSalary IS NULL;

UPDATE dbo.Customers
SET Position = ''
WHERE Position IS NULL;

UPDATE dbo.Customers
SET CertificateUrl = ''
WHERE CertificateUrl IS NULL;

UPDATE dbo.Customers
SET AssignedTeller = 'Unassigned'
WHERE AssignedTeller IS NULL OR LTRIM(RTRIM(AssignedTeller)) = '';

-- Ensure CreatedAt/LastUpdated not null
UPDATE dbo.Customers
SET CreatedAt = SYSUTCDATETIME()
WHERE CreatedAt IS NULL;

UPDATE dbo.Customers
SET LastUpdated = SYSUTCDATETIME()
WHERE LastUpdated IS NULL;

-- Inspect counts after
SELECT 'After' AS Stage, COUNT(*) AS TotalCustomers,
    SUM(CASE WHEN MonthlyIncome IS NULL THEN 1 ELSE 0 END) AS MonthlyIncomeNulls,
    SUM(CASE WHEN HasActiveLoans IS NULL THEN 1 ELSE 0 END) AS HasActiveLoansNulls,
    SUM(CASE WHEN DateOfBirth IS NULL THEN 1 ELSE 0 END) AS DateOfBirthNulls,
    SUM(CASE WHEN IdType IS NULL THEN 1 ELSE 0 END) AS IdTypeNulls
FROM dbo.Customers;

COMMIT TRANSACTION;
PRINT 'Null-fix script completed.';
