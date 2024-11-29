using BusinessObjects.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CourseController : ControllerBase
    {
        [HttpGet("GetAllCourse")]
        public async Task<IActionResult> GetAllCourse()
        {
            try
            {
                // Tạo context để kết nối với cơ sở dữ liệu
                using (var context = new StudentAttendanceDBContext())
                {
                    // Lấy toàn bộ danh sách Department
                    var Courses = await context.Courses.ToListAsync();

                    // Trả về danh sách departments dưới dạng JSON
                    return Ok(Courses);
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ và trả về thông báo lỗi
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

      
    }
}
