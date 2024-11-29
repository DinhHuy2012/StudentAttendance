using Microsoft.AspNetCore.Mvc;
using StudentAttendanceClient.APIFunction;
using StudentAttendanceClient.Models;
using System.Diagnostics;

namespace StudentAttendanceClient.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;

        public HomeController(ILogger<HomeController> logger)
        {
            _logger = logger;
        }


        public async Task<IActionResult> IndexAsync()
        {

          
            var semesterIdActive = await SemesterAPI.GetSemesterByStatus();

            ViewBag.SemesterIdActive = semesterIdActive.SemesterId;
            return View();
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
