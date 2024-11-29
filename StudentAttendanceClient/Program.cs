using Microsoft.AspNetCore.Http.Features;
using Microsoft.AspNetCore.SignalR;
using Repositories.Interface;
using Repositories.Repository;
using StudentAttendance.AutoMapper;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();
builder.Services.AddAutoMapper(typeof(ApplicationMapper));
builder.Services.AddSignalR();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30); // Thay đổi thời gian timeout nếu cần
    options.Cookie.HttpOnly = true; // Giúp bảo mật cookie
    options.Cookie.IsEssential = true; // Cookie cần thiết cho ứng dụng
});
builder.Services.Configure<FormOptions>(options =>
{
    options.MultipartBodyLengthLimit = 104857600; // Ví dụ: giới hạn 100MB
});
var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
}

app.UseStaticFiles();

app.UseRouting();
   // Thêm middleware session
    app.UseSession();
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Authentication}/{action=Default}/{id?}");
app.UseEndpoints(endpoints =>
{
    endpoints.MapHub<Hub>("/SignalHub"); // Định tuyến cho Hub
});
app.Run();
