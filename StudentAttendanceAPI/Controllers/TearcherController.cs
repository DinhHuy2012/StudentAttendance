using AutoMapper;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Repositories.Interface;

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TearcherController : ControllerBase
    {
        public ITeacherRepository _teacherRepository;
        private readonly IMapper _mapper;

        public TearcherController(ITeacherRepository teacherRepository, IMapper mapper)
        {
            _teacherRepository = teacherRepository;
            _mapper = mapper;

        }
        [HttpGet("GetAllTeacher")]
        public async Task<IActionResult> GetAllTeacher()
        {
            try
            {
                // Tạo context để kết nối với cơ sở dữ liệu
                using (var context = new StudentAttendanceDBContext())
                {
                    // Lấy toàn bộ danh sách Department
                    var tearchers = await context.Teachers.Where(s => s.Role == "teacher").ToListAsync();

                    // Trả về danh sách departments dưới dạng JSON
                    return Ok(tearchers);
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ và trả về thông báo lỗi
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpGet("GetTeacherByEmail/{email}")]
        public async Task<IActionResult> GetTeacherByEmail(string email)
        {
            try
            {
                var tearchers = await _teacherRepository.GetTeacherByEmailAsync(email);

                return Ok(tearchers);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
