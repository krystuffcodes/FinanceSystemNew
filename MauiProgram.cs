using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;
using FinanceSystem1.Data;

namespace FinanceSystem1
{
    public static class MauiProgram
    {
        public static MauiApp CreateMauiApp()
        {
            var builder = MauiApp.CreateBuilder();
            builder
                .UseMauiApp<App>()
                .ConfigureFonts(fonts =>
                {
                    fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                });

            builder.Services.AddMauiBlazorWebView();

            // Configure EF Core SQL Server DbContext
            // Local connection (developer):
            var localConn = "Data Source=U8813V195;Initial Catalog=fn_crm;Integrated Security=True;Connect Timeout=30;Encrypt=True;Trust Server Certificate=True;Application Intent=ReadWrite;Multi Subnet Failover=False;Command Timeout=30";
            // Online connection (production):
            var onlineConn = "Server=db32949.public.databaseasp.net; Database=db32949; User Id=db32949; Password=A!a76L_gs-4D; Encrypt=True; TrustServerCertificate=True; MultipleActiveResultSets=True;";

            // Choose connection string based on environment variable or default to local
            var useOnline = Environment.GetEnvironmentVariable("USE_ONLINE_DB");
            var connectionString = !string.IsNullOrEmpty(useOnline) && useOnline == "1" ? onlineConn : localConn;

            builder.Services.AddDbContext<AppDbContext>(options =>
            {
                options.UseSqlServer(connectionString);
            });

#if DEBUG
			builder.Services.AddBlazorWebViewDeveloperTools();
			builder.Logging.AddDebug();
#endif

            return builder.Build();
        }
    }
}
