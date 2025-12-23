-- Sample Data Insert Script for fn_crm Database
-- Run this after creating the database with CleanCreateDatabase.sql

USE fn_crm;
GO

-- Insert 10 sample Users (in addition to the existing admin user)
INSERT INTO Users (Username, Password, Email, FirstName, LastName, Role, IsActive, LastLoginAt) VALUES
('jsmith', 'password123', 'john.smith@fortressfinance.com', 'John', 'Smith', 'Teller', 1, '2024-01-15 09:30:00'),
('mmiller', 'secure456', 'mary.miller@fortressfinance.com', 'Mary', 'Miller', 'Manager', 1, '2024-01-14 08:15:00'),
('dbrown', 'mypass789', 'david.brown@fortressfinance.com', 'David', 'Brown', 'Loan Officer', 1, '2024-01-13 10:45:00'),
('swilson', 'pass321', 'sarah.wilson@fortressfinance.com', 'Sarah', 'Wilson', 'Teller', 1, '2024-01-12 14:20:00'),
('rjohnson', 'welcome123', 'robert.johnson@fortressfinance.com', 'Robert', 'Johnson', 'Supervisor', 1, '2024-01-11 11:00:00'),
('ltaylor', 'secure789', 'lisa.taylor@fortressfinance.com', 'Lisa', 'Taylor', 'Teller', 1, '2024-01-10 13:30:00'),
('mwhite', 'mykey456', 'michael.white@fortressfinance.com', 'Michael', 'White', 'Analyst', 1, '2024-01-09 09:15:00'),
('ajones', 'pass654', 'anna.jones@fortressfinance.com', 'Anna', 'Jones', 'Teller', 0, '2024-01-08 16:45:00'),
('cgarcia', 'welcome321', 'carlos.garcia@fortressfinance.com', 'Carlos', 'Garcia', 'Manager', 1, '2024-01-07 08:30:00'),
('edavis', 'secure987', 'emily.davis@fortressfinance.com', 'Emily', 'Davis', 'Loan Officer', 1, '2024-01-06 12:00:00');

-- Insert 10 sample Customers
INSERT INTO Customers (CustomerId, Name, Email, Phone, Address, EmploymentStatus, MonthlyIncome, DateOfBirth, HasActiveLoans, Notes, IdType, IdNumber, IssuingAuthority, ExpirationDate, AnnualSalary, Position, CertificateUrl, AssignedTeller) VALUES
('CUST001', 'Alice Thompson', 'alice.thompson@email.com', '+1-555-0101', '123 Main St, Anytown, CA 90210', 'Employed', 4500.00, '1985-03-15', 1, 'Excellent credit history', 'Driver License', 'DL1234567', 'CA DMV', '2026-03-15', 54000.00, 'Marketing Manager', 'https://docs.com/cert1', 'John Smith'),
('CUST002', 'Benjamin Rodriguez', 'ben.rodriguez@email.com', '+1-555-0102', '456 Oak Ave, Springfield, IL 62701', 'Self-Employed', 3200.00, '1978-08-22', 0, 'Small business owner', 'State ID', 'ID2345678', 'IL Secretary of State', '2025-08-22', 38400.00, 'Restaurant Owner', 'https://docs.com/cert2', 'Mary Miller'),
('CUST003', 'Catherine Lee', 'catherine.lee@email.com', '+1-555-0103', '789 Pine Rd, Denver, CO 80202', 'Employed', 6800.00, '1990-11-30', 1, 'High income professional', 'Driver License', 'DL3456789', 'CO DMV', '2027-11-30', 81600.00, 'Software Engineer', 'https://docs.com/cert3', 'David Brown'),
('CUST004', 'Daniel Martinez', 'daniel.martinez@email.com', '+1-555-0104', '321 Elm St, Austin, TX 73301', 'Part-Time', 2100.00, '1995-05-18', 0, 'College student', 'Student ID', 'STU4567890', 'University of Texas', '2025-05-31', 25200.00, 'Student/Part-time Worker', 'https://docs.com/cert4', 'Sarah Wilson'),
('CUST005', 'Eleanor Chen', 'eleanor.chen@email.com', '+1-555-0105', '654 Maple Dr, Seattle, WA 98101', 'Employed', 5500.00, '1982-12-08', 1, 'Reliable borrower', 'Passport', 'PP5678901', 'US State Department', '2029-12-08', 66000.00, 'Nurse Practitioner', 'https://docs.com/cert5', 'Robert Johnson'),
('CUST006', 'Frank Williams', 'frank.williams@email.com', '+1-555-0106', '987 Cedar Ln, Miami, FL 33101', 'Retired', 3800.00, '1955-07-25', 0, 'Pension income', 'Driver License', 'DL6789012', 'FL DMV', '2025-07-25', 45600.00, 'Retired Teacher', 'https://docs.com/cert6', 'Lisa Taylor'),
('CUST007', 'Grace Anderson', 'grace.anderson@email.com', '+1-555-0107', '159 Birch St, Portland, OR 97201', 'Employed', 4200.00, '1987-04-12', 1, 'First-time borrower', 'Driver License', 'DL7890123', 'OR DMV', '2026-04-12', 50400.00, 'Graphic Designer', 'https://docs.com/cert7', 'Michael White'),
('CUST008', 'Henry Kim', 'henry.kim@email.com', '+1-555-0108', '753 Willow Way, Boston, MA 02101', 'Employed', 7200.00, '1975-09-03', 1, 'High net worth client', 'Driver License', 'DL8901234', 'MA RMV', '2025-09-03', 86400.00, 'Financial Advisor', 'https://docs.com/cert8', 'Carlos Garcia'),
('CUST009', 'Isabella Davis', 'isabella.davis@email.com', '+1-555-0109', '852 Poplar Ave, Phoenix, AZ 85001', 'Unemployed', 1800.00, '1992-02-14', 0, 'Seeking employment', 'State ID', 'ID9012345', 'AZ MVD', '2026-02-14', 21600.00, 'Job Seeker', 'https://docs.com/cert9', 'Emily Davis'),
('CUST010', 'James Wilson', 'james.wilson@email.com', '+1-555-0110', '741 Spruce Ct, Las Vegas, NV 89101', 'Employed', 3900.00, '1980-10-20', 1, 'Casino employee', 'Driver License', 'DL0123456', 'NV DMV', '2027-10-20', 46800.00, 'Dealer', 'https://docs.com/cert10', 'John Smith');

-- Insert 10 sample Loan Applications
INSERT INTO LoanApplications (ApplicationId, CustomerId, ApplicantName, Amount, Purpose, ApplicationDate, Status, InterestRate, EmploymentType, Income, LoanTerm, Notes) VALUES
('LOAN001', 'CUST001', 'Alice Thompson', 15000.00, 'Home renovation', '2024-01-10 10:30:00', 'Approved', 4.5, 'Full-Time', 54000.00, '36 months', 'Approved for home improvement loan'),
('LOAN002', 'CUST002', 'Benjamin Rodriguez', 25000.00, 'Business expansion', '2024-01-12 14:15:00', 'Under Review', 6.2, 'Self-Employed', 38400.00, '60 months', 'Restaurant equipment purchase'),
('LOAN003', 'CUST003', 'Catherine Lee', 50000.00, 'Debt consolidation', '2024-01-08 09:45:00', 'Approved', 3.8, 'Full-Time', 81600.00, '84 months', 'Consolidating multiple credit cards'),
('LOAN004', 'CUST004', 'Daniel Martinez', 8000.00, 'Education expenses', '2024-01-15 16:20:00', 'Pending', 5.0, 'Part-Time', 25200.00, '48 months', 'Student loan for final semester'),
('LOAN005', 'CUST005', 'Eleanor Chen', 35000.00, 'Vehicle purchase', '2024-01-09 11:00:00', 'Approved', 4.8, 'Full-Time', 66000.00, '72 months', 'New car loan approved'),
('LOAN006', 'CUST006', 'Frank Williams', 12000.00, 'Medical expenses', '2024-01-11 13:30:00', 'Rejected', 7.5, 'Retired', 45600.00, '36 months', 'Insufficient income verification'),
('LOAN007', 'CUST007', 'Grace Anderson', 20000.00, 'Home down payment', '2024-01-13 08:15:00', 'Under Review', 4.2, 'Full-Time', 50400.00, '120 months', 'First-time home buyer program'),
('LOAN008', 'CUST008', 'Henry Kim', 75000.00, 'Investment property', '2024-01-07 15:45:00', 'Approved', 5.5, 'Full-Time', 86400.00, '180 months', 'Investment property mortgage'),
('LOAN009', 'CUST009', 'Isabella Davis', 5000.00, 'Emergency expenses', '2024-01-14 12:00:00', 'Pending', 8.0, 'Unemployed', 21600.00, '24 months', 'Emergency fund needed'),
('LOAN010', 'CUST010', 'James Wilson', 18000.00, 'Vacation/Travel', '2024-01-06 10:15:00', 'Approved', 6.8, 'Full-Time', 46800.00, '36 months', 'Approved for travel expenses');

-- Insert 10 sample Payments
INSERT INTO Payments (CustomerName, PaymentDate, Amount, PaymentMethod, Status, ReferenceId, Description) VALUES
('Alice Thompson', '2024-01-15 09:00:00', 523.45, 'Bank Transfer', 'Completed', 'PAY001', 'Monthly loan payment - Home renovation loan'),
('Catherine Lee', '2024-01-14 14:30:00', 892.67, 'Online Banking', 'Completed', 'PAY002', 'Monthly payment - Debt consolidation loan'),
('Eleanor Chen', '2024-01-13 10:15:00', 634.21, 'Auto Debit', 'Completed', 'PAY003', 'Monthly car loan payment'),
('Henry Kim', '2024-01-12 16:45:00', 1245.80, 'Check', 'Completed', 'PAY004', 'Monthly mortgage payment - Investment property'),
('James Wilson', '2024-01-11 11:20:00', 567.33, 'Credit Card', 'Completed', 'PAY005', 'Travel loan monthly payment'),
('Alice Thompson', '2024-01-10 13:00:00', 523.45, 'Bank Transfer', 'Pending', 'PAY006', 'February loan payment - Home renovation'),
('Catherine Lee', '2024-01-09 08:30:00', 892.67, 'Online Banking', 'Failed', 'PAY007', 'Payment failed - insufficient funds'),
('Eleanor Chen', '2024-01-08 15:15:00', 634.21, 'Auto Debit', 'Completed', 'PAY008', 'Car loan payment - December'),
('Benjamin Rodriguez', '2024-01-07 12:45:00', 425.50, 'Cash', 'Completed', 'PAY009', 'Partial payment towards business loan'),
('Henry Kim', '2024-01-06 09:30:00', 1245.80, 'Wire Transfer', 'Completed', 'PAY010', 'Investment property payment - January');

-- Insert 10 sample Revenue Data
INSERT INTO RevenueDatas (CustomerId, CustomerName, LoanAmount, InterestRate, PaidAmount, InterestEarned, Status, LoanDate, LastPaymentDate) VALUES
('CUST001', 'Alice Thompson', 15000.00, 4.5, 2617.25, 235.55, 'Active', '2023-06-15', '2024-01-15'),
('CUST003', 'Catherine Lee', 50000.00, 3.8, 8926.70, 1702.35, 'Active', '2023-04-10', '2024-01-14'),
('CUST005', 'Eleanor Chen', 35000.00, 4.8, 6342.10, 1524.88, 'Active', '2023-08-22', '2024-01-13'),
('CUST008', 'Henry Kim', 75000.00, 5.5, 12458.00, 6879.45, 'Active', '2023-02-01', '2024-01-12'),
('CUST010', 'James Wilson', 18000.00, 6.8, 5673.30, 1947.22, 'Active', '2023-09-10', '2024-01-11'),
('CUST002', 'Benjamin Rodriguez', 25000.00, 6.2, 4255.00, 1575.50, 'Pending', '2023-12-01', '2024-01-07'),
('CUST007', 'Grace Anderson', 20000.00, 4.2, 0.00, 0.00, 'New', '2024-01-13', NULL),
('CUST004', 'Daniel Martinez', 8000.00, 5.0, 0.00, 0.00, 'Pending Approval', '2024-01-15', NULL),
('CUST006', 'Frank Williams', 12000.00, 7.5, 0.00, 0.00, 'Rejected', '2024-01-11', NULL),
('CUST009', 'Isabella Davis', 5000.00, 8.0, 0.00, 0.00, 'Under Review', '2024-01-14', NULL);

-- Insert 10 sample Overdue Accounts
INSERT INTO OverdueAccounts (CustomerId, CustomerName, OutstandingAmount, DaysOverdue, LastPaymentDate, NextDueDate) VALUES
('CUST003', 'Catherine Lee', 892.67, 5, '2024-01-09', '2024-01-20'),
('CUST002', 'Benjamin Rodriguez', 1275.25, 15, '2023-12-20', '2024-01-05'),
('CUST006', 'Frank Williams', 2450.80, 45, '2023-11-25', '2023-12-25'),
('CUST009', 'Isabella Davis', 520.33, 8, '2024-01-05', '2024-01-15'),
('CUST004', 'Daniel Martinez', 340.50, 3, '2024-01-10', '2024-01-18'),
('CUST007', 'Grace Anderson', 1680.90, 22, '2023-12-15', '2024-01-01'),
('CUST001', 'Alice Thompson', 523.45, 2, '2024-01-13', '2024-01-16'),
('CUST010', 'James Wilson', 1134.66, 12, '2023-12-28', '2024-01-10'),
('CUST005', 'Eleanor Chen', 634.21, 1, '2024-01-14', '2024-01-16'),
('CUST008', 'Henry Kim', 2491.60, 7, '2024-01-07', '2024-01-21');

-- Verify data insertion
PRINT '=================================================';
PRINT 'Sample data inserted successfully!';
PRINT '=================================================';

-- Show counts for each table
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

PRINT 'Data insertion completed successfully!';