using AutoMapper;
using BusinessObjects.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using StudentAttendanceClient.APIFunction;
using System.Net.Http.Headers;

namespace StudentAttendanceClient.Controllers
{
    public class ClassController : Controller
    {
        private readonly HttpClient client;
        private readonly IMapper mapper; // Inject IMapper


        public ClassController(IMapper mapper)
        {

            client = new HttpClient();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            this.mapper = mapper;
        }

        [HttpGet]
        public async Task<IActionResult> Index(int currentPage = 1, int pageSize = 5)
        {
            // Lấy danh sách sinh viên từ API dưới dạng DTO
            var classes = await ClassAPI.GetListClassAsync();
            

            // Tính toán số trang
            var totalClass = classes.Count();
            var totalPages = (int)Math.Ceiling(totalClass / (double)pageSize);

            // Lấy danh sách sinh viên cho trang hiện tại
            var pagedClasses = classes.Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            // Lưu thông tin phân trang vào ViewBag
            ViewBag.CurrentPage = currentPage;
            ViewBag.TotalPages = totalPages;
            // Trả về View với danh sách sinh viên đã phân trang
            return View(pagedClasses);
        }

     
        public async Task<IActionResult> Details(int id)
        {
            // Lấy thông tin sinh viên từ API
            var classdetail = await ClassAPI.GetClassByIdAsync(id); // Đảm bảo bạn đang nhận về đúng kiểu dữ liệu
            var schedule = await ScheduleAPI.GetScheduleByclassIdAsync(id);
            var firstCourseId = schedule
                .Select(c => c.CourseId)
                .FirstOrDefault();
            if (classdetail == null)
            {
                return NotFound(); // Trả về 404 nếu không tìm thấy sinh viên
            }
            if (firstCourseId == null) {
                ViewBag.FirstCourseId = 0;
            }

            ViewBag.FirstCourseId = firstCourseId;

            // Ánh xạ từ StudentDTO sang StudentDetailViewModel
            /*            var studentDetail = mapper.Map<Student>(studentDTO);
            */
            // Trả về View với thông tin chi tiết sinh viên
            return View(classdetail);
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
