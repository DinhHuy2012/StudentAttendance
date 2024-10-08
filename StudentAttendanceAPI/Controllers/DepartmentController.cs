using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DepartmentController : Controller
    {
        [HttpGet("GetAllDepartment")]
        public async Task<IActionResult> GetAllDepartment()
        {
            try
            {
                // Tạo context để kết nối với cơ sở dữ liệu
                using (var context = new StudentAttendanceDBContext())
                {
                    // Lấy toàn bộ danh sách Department
                    var departments = await context.Departments.ToListAsync();

                    // Trả về danh sách departments dưới dạng JSON
                    return Ok(departments);
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
