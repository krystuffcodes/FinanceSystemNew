# Database Setup Instructions for fn_crm

## Step 1: Create Database in SQL Server Management Studio (SSMS)

1. **Open SQL Server Management Studio (SSMS)**
   - Connect to your SQL Server instance: `LAPTOP-9U7RNK0\SQLEXPRESS`

2. **Execute the Database Creation Script**
   - Open the file `Database/CreateDatabase.sql`
   - Execute the entire script in SSMS
   - This will:
     - Create the `fn_crm` database
     - Create all required tables (Customers, LoanApplications, Payments, RevenueDatas, OverdueAccounts, Users)
     - Create the admin user with username: `admin` and password: `admin`
     - Set up indexes for better performance

## Step 2: Verify Database Creation

After running the script, verify in SSMS that:
- [ ] Database `fn_crm` exists under Databases
- [ ] All tables are created:
  - [ ] Customers
  - [ ] LoanApplications
  - [ ] Payments  
  - [ ] RevenueDatas
  - [ ] OverdueAccounts
  - [ ] Users
- [ ] Admin user exists in Users table

## Step 3: Connection String Configuration

The application is already configured to connect to:
```
Server=LAPTOP-9U7RNK0\SQLEXPRESS;Database=fn_crm;Trusted_Connection=true;MultipleActiveResultSets=true;TrustServerCertificate=true;
```

## Step 4: Clean Existing Mock Data (Optional)

If you need to clean the database and remove any test data:
1. Open the file `Database/CleanDatabase.sql`
2. Execute it in SSMS
3. This will remove all data and recreate the admin user

## Step 5: Login Credentials

Use these credentials to log into the application:
- **Username:** `admin`
- **Password:** `admin`

## Step 6: Build and Run Application

1. Build the solution in Visual Studio
2. Run the MAUI application
3. The login page should appear
4. Use admin/admin credentials to access the system
5. All mock/dummy data has been removed - the system will start with clean tables

## Database Schema Overview

### Users Table
- Stores login credentials and user information
- Admin user: admin/admin

### Core Business Tables
- **Customers**: Customer information and profiles
- **LoanApplications**: Loan application data
- **Payments**: Payment records and transactions  
- **RevenueDatas**: Revenue and earnings data
- **OverdueAccounts**: Overdue account information

## Troubleshooting

### Connection Issues
1. Verify SQL Server Express is running
2. Check Windows Authentication is enabled
3. Ensure SQL Server Browser service is running
4. Verify server name: `LAPTOP-9U7RNK0\SQLEXPRESS`

### Login Issues
1. Verify admin user exists in Users table:
   ```sql
   SELECT * FROM Users WHERE Username = 'admin'
   ```
2. Ensure IsActive = 1 for admin user

### Missing Tables
1. Re-run `Database/CreateDatabase.sql`
2. Check for any error messages in SSMS

## Security Notes

?? **Important**: 
- The current setup uses simple password storage for demo purposes
- For production use, implement proper password hashing (BCrypt, etc.)
- Change default admin credentials
- Enable additional security measures