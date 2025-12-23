-- Clean up existing data and reset the database
USE fn_crm;
GO

-- Clear all existing data from tables
DELETE FROM RevenueDatas;
DELETE FROM OverdueAccounts;
DELETE FROM Payments;
DELETE FROM LoanApplications;
DELETE FROM Customers;
DELETE FROM Users;

-- Reset identity columns if any exist
-- DBCC CHECKIDENT ('Customers', RESEED, 0);

-- Recreate the admin user (plain text password)
INSERT INTO Users (Username, Password, Email, FirstName, LastName, Role, IsActive, CreatedAt, LastUpdated)
VALUES ('admin', 'admin', 'admin@fortressfinance.com', 'System', 'Administrator', 'Admin', 1, GETDATE(), GETDATE());

-- Verify the admin user was created
SELECT * FROM Users WHERE Username = 'admin';

PRINT 'Database cleaned and admin user created successfully!'
PRINT 'Login credentials: Username = admin, Password = admin';