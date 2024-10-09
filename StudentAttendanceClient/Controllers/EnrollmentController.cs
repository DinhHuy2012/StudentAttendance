using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using StudentAttendanceClient.APIFunction;
using System.Net.Http;
using System.Net.Http.Headers;

namespace StudentAttendanceClient.Controllers
{
    public class EnrollmentController : Controller
    {
        private readonly HttpClient client;
        private readonly IMapper mapper; // Inject IMapper

        public EnrollmentController(IMapper mapper)
        {
            client = new HttpClient();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            this.mapper = mapper;
        }

        public async Task<IActionResult> Index()
        {
            return View();
        }

        [HttpGet]
        public async Task<IActionResult> SearchStudents(string search)
        {
            // Gọi API bất đồng bộ để tìm sinh viên
            var students = await StudentAPI.GetSearchStudent(search);
            return Ok(students);
        }
    }
}
