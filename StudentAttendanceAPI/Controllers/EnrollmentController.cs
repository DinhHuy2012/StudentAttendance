using AutoMapper;
using BusinessObjects.DTO.EnrollmentDto;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;
using DataAccess.DAO;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using OfficeOpenXml;
using Repositories.Interface;
using Repositories.Repository;
using OfficeOpenXml; // Đảm bảo bạn đã thêm thư viện này vào phần đầu của tệp

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class EnrollmentController : ControllerBase
    {
        private readonly IEnrollmentRepository _enrollmentRepository;
        private readonly IMapper _mapper;

        public EnrollmentController(IEnrollmentRepository enrollmentRepository, IMapper mapper)
        {
            _enrollmentRepository = enrollmentRepository;
            _mapper = mapper;

        }
        [HttpGet("{classId}/{studentId}")]
        public async Task<ActionResult<Enrollment>> GetEnrollment(int classId, int studentId)
        {
            var enrollment = await _enrollmentRepository.GetEnrollmentByClassAndStudentAsync(classId, studentId);
            if (enrollment == null)
            {
                return NotFound();
            }
            var result = _mapper.Map<EnrollmentDTO>(enrollment);

            return Ok(result);
        }
        [HttpPost("AddStudentsToClass")]
        public async Task<IActionResult> AddStudentsToClass([FromBody] AddEnrollmentDTO dto)
        {
            if (dto.ClassId <= 0)
            {
                return BadRequest("Invalid class ID.");
            }

            if (dto.StudentIds == null || !dto.StudentIds.Any())
            {
                return BadRequest("No student IDs provided.");
            }

            var enrollments = new List<Enrollment>();

            foreach (var studentId in dto.StudentIds)
            {
                var existingEnrollment = await _enrollmentRepository.GetEnrollmentByClassAndStudentAsync(dto.ClassId, studentId);
                if (existingEnrollment != null)
                {
                    return Conflict($"Student {studentId} is already enrolled in class {dto.ClassId}.");
                }

                enrollments.Add(new Enrollment
                {
                    ClassId = dto.ClassId,
                    StudentId = studentId,
                    EnrolledAt = DateTime.Now,
                    Status = "Active"
                });
            }

            try
            {
                await _enrollmentRepository.AddEnrollmentsAsync(enrollments);
                await _enrollmentRepository.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error saving enrollments: {ex.Message}");
                return StatusCode(500, "An error occurred while saving the enrollments.");
            }

            return Ok("Students added successfully.");
        }


        [HttpPost("import-from-excel")]
        public async Task<IActionResult> ImportFromExcel(IFormFile file, [FromForm] int classId)
        {
            if (classId == 0) // Khi classId là int, nó không thể là null nhưng có thể mặc định là 0  
            {
                return BadRequest("classId is required.");
            }
            if (file == null || file.Length == 0)
            {
                return BadRequest("No file provided.");
            }

            // Thiết lập ngữ cảnh giấy phép cho EPPlus
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial; // Hoặc LicenseContext.Commercial nếu bạn có giấy phép

            var enrollments = new List<Enrollment>();

            using (var stream = new MemoryStream())
            {
                await file.CopyToAsync(stream);
                using (var package = new ExcelPackage(stream))
                {
                    var worksheet = package.Workbook.Worksheets[0]; // Lấy worksheet đầu tiên
                    var rowCount = worksheet.Dimension.Rows;

                    for (int row = 2; row <= rowCount; row++) // Giả sử dòng đầu tiên là tiêu đề
                    {
                        var studentId = worksheet.Cells[row, 2].GetValue<int?>(); // Giả sử StudentId ở cột thứ hai

                        if (studentId.HasValue)
                        {
                            // Kiểm tra xem sinh viên đã tồn tại trong lớp chưa
                            var existingEnrollment = await _enrollmentRepository.GetEnrollmentByClassAndStudentAsync(studentId.Value, classId);
                            if (existingEnrollment == null) // Nếu không tồn tại
                            {
                                var enrollment = new Enrollment
                                {
                                    StudentId = studentId.Value,
                                    ClassId = classId, // Gán ClassId từ tham số
                                                       // Các thuộc tính khác...
                                };

                                enrollments.Add(enrollment);
                            }
                            else
                            {
                                // Nếu sinh viên đã tồn tại, bạn có thể ghi lại hoặc bỏ qua
                                Console.WriteLine($"Student with ID {studentId.Value} is already enrolled in class {classId}. Skipping.");
                            }
                        }
                    }
                }
            }

          
                await _enrollmentRepository.AddEnrollmentsAsync(enrollments);
                await _enrollmentRepository.SaveChangesAsync();
          

            return Ok("Students imported successfully.");
        }




    }


}