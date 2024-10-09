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


        public async Task<IActionResult> Index( int currentPage = 1, int pageSize = 5)
        {
            // Lấy danh sách sinh viên từ API dưới dạng DTO
            var classes = await ClassAPI.GetListClassAsync();

            // Ánh xạ từ StudentDTOs sang đối tượng Student

            // Lấy danh sách phòng ban từ API
         

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
    }
}
