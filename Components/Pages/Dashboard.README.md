# Fortress Finance Dashboard

## Overview
The Dashboard provides a comprehensive view of all financial data from the database, including:
- Real-time KPIs (Key Performance Indicators)
- Revenue trends and analysis
- Customer metrics and growth
- Loan applications status
- Payment collection rates
- Overdue accounts monitoring

## Database Connection
The dashboard automatically connects to your `fn_crm` database and displays live data from all tables:

### Connected Tables:
- **Customers**: Total customers, new customers this month
- **LoanApplications**: Active loans, new applications, processing metrics
- **Payments**: Collection rates, recent payments, payment status
- **RevenueDatas**: Total revenue, interest earned, growth trends  
- **OverdueAccounts**: Overdue amounts, accounts at risk
- **Users**: System users and roles

## Key Features

### ?? Live KPI Cards
- **Total Revenue**: Displays sum of all paid amounts with growth percentage
- **Active Loans**: Shows approved/active loans with new applications count
- **Overdue Accounts**: Critical accounts with outstanding amounts
- **Total Customers**: Customer base with monthly growth metrics

### ?? Interactive Charts
- **Revenue Trend**: Filterable by time period (Month/Quarter/Year)
- **Collection Rate**: Circular progress showing payment efficiency
- **Recent Activity**: Tabbed view of latest payments and applications

### ?? Smart Features
- **Auto-Refresh**: Real-time data updates
- **Error Handling**: Displays connection issues with retry options
- **Responsive Design**: Works on desktop, tablet, and mobile
- **Loading States**: Professional loading animations while data loads

## Setup Instructions

### 1. Database Setup
First ensure your database is properly set up:
```sql
-- Run these scripts in order:
1. Database/CleanCreateDatabase.sql  -- Creates database structure
2. Database/InsertSampleData.sql     -- Adds sample data
3. Database/VerifyDatabase.sql       -- Verifies setup (optional)
```

### 2. Connection String
Verify your connection string in `appsettings.json`:
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=LAPTOP-9U7RNK0I\\SQLEXPRESS;Database=fn_crm;Trusted_Connection=true;MultipleActiveResultSets=true;TrustServerCertificate=true;"
  }
}
```

### 3. Navigation
Access the dashboard at: `/dashboard`

## Troubleshooting

### Database Connection Issues
If you see a red error banner:
1. **Check SQL Server**: Ensure SQL Server Express is running
2. **Verify Database**: Run the `VerifyDatabase.sql` script
3. **Connection String**: Confirm server name matches your SQL Server instance
4. **Windows Auth**: Ensure Windows Authentication is enabled
5. **Click Retry**: Use the "?? Retry Connection" button after fixing issues

### No Data Displaying
If KPIs show zeros or dashes:
1. **Run Sample Data**: Execute `InsertSampleData.sql` 
2. **Check Tables**: Use `VerifyDatabase.sql` to verify data exists
3. **Permissions**: Ensure database user has SELECT permissions
4. **Refresh Data**: Click refresh button or reload page

### Performance Issues
For large datasets:
- The dashboard uses `AsNoTracking()` for better performance
- Recent activities are limited to latest 10 records
- Consider adding database indexing for large tables

## Data Calculations

### KPI Formulas:
- **Total Revenue**: `SUM(RevenueDatas.PaidAmount)`
- **Collection Rate**: `(Completed Payments / Total Payments) * 100`
- **Monthly Growth**: `((Current Month - Last Month) / Last Month) * 100`
- **Average Loan**: `AVG(LoanApplications.Amount)` where Status = 'Approved'
- **Default Rate**: `(Rejected Loans / Total Processed) * 100`

### Time Period Filters:
- **This Month**: Last 30 days
- **Last Month**: 31-60 days ago  
- **Last 3 Months**: Last 90 days
- **This Year**: Last 365 days

## Customization

### Adding New KPIs
To add custom metrics, modify the `CalculateKPIs()` method in `Dashboard.razor.cs`:

```csharp
// Example: Add average customer age
private decimal averageCustomerAge = 0;

// In CalculateKPIs():
if (customersList.Any(c => c.DateOfBirth.HasValue))
{
    averageCustomerAge = (decimal)customersList
        .Where(c => c.DateOfBirth.HasValue)
        .Average(c => (DateTime.Now - c.DateOfBirth.Value).TotalDays / 365.25);
}
```

### Styling Changes
Customize appearance by modifying `Dashboard.razor.css`:
- KPI card colors: `.kpi-card.custom-type`
- Chart themes: `.chart-container` styles
- Responsive breakpoints: `@media` queries

## Browser Support
- ? Chrome 90+
- ? Firefox 88+  
- ? Safari 14+
- ? Edge 90+
- ? Mobile browsers (iOS Safari, Chrome Mobile)

## Security Notes
- Dashboard uses read-only database queries
- No sensitive data is cached in browser
- Connection strings are server-side only
- User authentication handled by parent application

---

**Need Help?** Check the browser console (F12) for detailed error messages and database connection logs.