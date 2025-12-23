using Microsoft.Extensions.Logging;
using Microsoft.EntityFrameworkCore;
using FinanceSystem1.Data;
using FinanceSystem1.Services;

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
            // Updated to use correct computer name with 'I' at the end
            var connectionString = "Server=LAPTOP-9U7RNK0I\\SQLEXPRESS;Database=fn_crm;Trusted_Connection=true;MultipleActiveResultSets=true;TrustServerCertificate=true;";

            builder.Services.AddDbContext<AppDbContext>(options =>
            {
                options.UseSqlServer(connectionString);
            });

            // Register authentication service
            builder.Services.AddScoped<IAuthenticationService, AuthenticationService>();

#if DEBUG
			builder.Services.AddBlazorWebViewDeveloperTools();
			builder.Logging.AddDebug();
#endif

            return builder.Build();
        }
    }
}
