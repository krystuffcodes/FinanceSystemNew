using Microsoft.EntityFrameworkCore;
using FinanceSystem1.Data;

namespace FinanceSystem1.Services
{
    public interface IAuthenticationService
    {
        Task<bool> LoginAsync(string username, string password);
        Task<bool> IsLoggedInAsync();
        Task LogoutAsync();
        Task<string> GetCurrentUserAsync();
    }

    public class AuthenticationService : IAuthenticationService
    {
        private readonly AppDbContext _context;
        private bool _isLoggedIn = false;
        private string _currentUser = "";

        public AuthenticationService(AppDbContext context)
        {
            _context = context;
        }

        public async Task<bool> LoginAsync(string username, string password)
        {
            try
            {
                var user = await _context.Users
                    .FirstOrDefaultAsync(u => u.Username == username && u.IsActive);

                if (user != null)
                {
                    // Simple plain text password check
                    if (user.Password == password)
                    {
                        _isLoggedIn = true;
                        _currentUser = user.Username;
                        
                        // Update last login time
                        user.LastLoginAt = DateTime.Now;
                        await _context.SaveChangesAsync();
                        
                        return true;
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error
                System.Diagnostics.Debug.WriteLine($"Login error: {ex.Message}");
            }

            return false;
        }

        public async Task<bool> IsLoggedInAsync()
        {
            return await Task.FromResult(_isLoggedIn);
        }

        public async Task LogoutAsync()
        {
            _isLoggedIn = false;
            _currentUser = "";
            await Task.CompletedTask;
        }

        public async Task<string> GetCurrentUserAsync()
        {
            return await Task.FromResult(_currentUser);
        }
    }
}