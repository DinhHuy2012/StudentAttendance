using AutoMapper;
using BusinessObjects.DTO.EnrollmentDto;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;
using DataAccess.DAO;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Repositories.Interface;

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
        public async Task<IActionResult> AddStudentsToClass(int classId, List<int> studentIds)
        {
            var enrollments = new List<Enrollment>();

            foreach (var studentId in studentIds)
            {
                // Kiểm tra xem sinh viên đã được ghi danh chưa
                var existingEnrollment = await _enrollmentRepository.GetEnrollmentByClassAndStudentAsync(classId, studentId);

                if (existingEnrollment == null)
                {
                    // Nếu chưa có, thêm sinh viên vào danh sách enrollments
                    enrollments.Add(new Enrollment
                    {
                        ClassId = classId,
                        StudentId = studentId,
                        EnrolledAt = DateTime.Now,
                        Status = "Active" // Ví dụ gán trạng thái
                    });
                }
            }

            if (enrollments.Any())
            {
                // Thêm danh sách enrollments vào database
                await _enrollmentRepository.AddEnrollmentsAsync(enrollments);
                await _enrollmentRepository.SaveChangesAsync();
            }

            return Ok("Students added successfully.");
        }
    }
}