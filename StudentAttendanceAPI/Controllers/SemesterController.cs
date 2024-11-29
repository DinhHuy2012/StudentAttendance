using BusinessObjects.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SemesterController : ControllerBase
    {
        [HttpGet("GetAllSemester")]
        public async Task<IActionResult> GetAllSemester()
        {
            try
            {
                // Tạo context để kết nối với cơ sở dữ liệu
                using (var context = new StudentAttendanceDBContext())
                {
                    // Lấy toàn bộ danh sách Department
                    var Courses = await context.Semesters.ToListAsync();

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
        [HttpGet("GetSemesterByStatus")]
        public async Task<IActionResult> GetSemesterByStatus()
        {
            try
            {
                // Tạo context để kết nối với cơ sở dữ liệu
                using (var context = new StudentAttendanceDBContext())
                {
                    // Lấy toàn bộ danh sách Department
                    var course = await context.Semesters.FirstOrDefaultAsync(x => x.Status == "Active");

                    // Trả về danh sách departments dưới dạng JSON
                    return Ok(course);
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
