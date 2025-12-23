using System;
using Microsoft.EntityFrameworkCore;

namespace FinanceSystem1.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options)
        {
        }

        public DbSet<Customer> Customers { get; set; }
        public DbSet<LoanApplication> LoanApplications { get; set; }
        public DbSet<Payment> Payments { get; set; }
        public DbSet<RevenueData> RevenueDatas { get; set; }
        public DbSet<OverdueAccount> OverdueAccounts { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Customer>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.CustomerId).HasMaxLength(50);
                entity.Property(e => e.Name).HasMaxLength(200);
                entity.Property(e => e.Email).HasMaxLength(200);
            });

            modelBuilder.Entity<LoanApplication>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.ApplicationId).HasMaxLength(50);
                entity.Property(e => e.ApplicantName).HasMaxLength(200);
            });

            modelBuilder.Entity<Payment>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.ReferenceId).HasMaxLength(100);
                entity.Property(e => e.CustomerName).HasMaxLength(200);
            });

            modelBuilder.Entity<RevenueData>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.CustomerId).HasMaxLength(50);
                entity.Property(e => e.CustomerName).HasMaxLength(200);
            });

            modelBuilder.Entity<OverdueAccount>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.CustomerId).HasMaxLength(50);
                entity.Property(e => e.CustomerName).HasMaxLength(200);
            });
        }
    }

    public class Customer
    {
        public Guid Id { get; set; } = Guid.NewGuid();
        public string CustomerId { get; set; } = "";
        public string Name { get; set; } = "";
        public string Email { get; set; } = "";
        public string Phone { get; set; } = "";
        public string Address { get; set; } = "";
        public string EmploymentStatus { get; set; } = "";
        // Made nullable to match DB where these columns can be NULL
        public decimal? MonthlyIncome { get; set; }
        public DateTime? DateOfBirth { get; set; }
        public bool? HasActiveLoans { get; set; }
        public string Notes { get; set; } = "";
        public DateTime? CreatedAt { get; set; } = DateTime.Now;
        public DateTime? LastUpdated { get; set; } = DateTime.Now;

        // Additional fields
        public string IdType { get; set; } = "";
        public string IdNumber { get; set; } = "";
        public string IssuingAuthority { get; set; } = "";
        public DateTime? ExpirationDate { get; set; }
        public decimal? AnnualSalary { get; set; }
        public string Position { get; set; } = "";
        public string CertificateUrl { get; set; } = "";
        public string AssignedTeller { get; set; } = "";
    }

    public class LoanApplication
    {
        public Guid Id { get; set; } = Guid.NewGuid();
        public string ApplicationId { get; set; } = "";
        public string CustomerId { get; set; } = "";
        public string ApplicantName { get; set; } = "";
        public decimal? Amount { get; set; }
        public string Purpose { get; set; } = "";
        public DateTime? ApplicationDate { get; set; } = DateTime.Now;
        public string Status { get; set; } = "Pending";
        public decimal? InterestRate { get; set; } = 5.5m;
        public string EmploymentType { get; set; } = "";
        public decimal? Income { get; set; }
        public string LoanTerm { get; set; } = "";
        public string Notes { get; set; } = "";
        public DateTime? CreatedAt { get; set; } = DateTime.Now;
        public DateTime? LastUpdated { get; set; } = DateTime.Now;
    }

    public class Payment
    {
        public Guid Id { get; set; } = Guid.NewGuid();
        public string CustomerName { get; set; } = "";
        public DateTime? PaymentDate { get; set; } = DateTime.Today;
        public decimal? Amount { get; set; }
        public string PaymentMethod { get; set; } = "";
        public string Status { get; set; } = "";
        public string ReferenceId { get; set; } = "";
        public string Description { get; set; } = "";
        public DateTime? CreatedAt { get; set; } = DateTime.Now;
    }

    public class RevenueData
    {
        public Guid Id { get; set; } = Guid.NewGuid();
        public string CustomerId { get; set; } = "";
        public string CustomerName { get; set; } = "";
        public decimal? LoanAmount { get; set; }
        public decimal? InterestRate { get; set; }
        public decimal? PaidAmount { get; set; }
        public decimal? InterestEarned { get; set; }
        public string Status { get; set; } = "";
        public DateTime? LoanDate { get; set; } = DateTime.Now;
        public DateTime? LastPaymentDate { get; set; } = DateTime.Now;
    }

    public class OverdueAccount
    {
        public Guid Id { get; set; } = Guid.NewGuid();
        public string CustomerId { get; set; } = "";
        public string CustomerName { get; set; } = "";
        public decimal? OutstandingAmount { get; set; }
        public int? DaysOverdue { get; set; }
        public DateTime? LastPaymentDate { get; set; } = DateTime.Now;
        public DateTime? NextDueDate { get; set; } = DateTime.Now;
    }
}
