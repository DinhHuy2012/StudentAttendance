using BusinessObjects.DTO.AttendanceDTO;
using BusinessObjects.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Repositories.Interface;
using Repositories.Repository;

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AttendanceController : ControllerBase
    {
        private readonly IAttendanceRepository _attendanceRepository;

        public AttendanceController(IAttendanceRepository attendanceRepository)
        {
            _attendanceRepository = attendanceRepository;
        }
        [HttpGet("get-all")]
        public async Task<IActionResult> GetAllAttendances()
        {
            var attendances = await _attendanceRepository.GetAllAttendancesAsync();
            return Ok(attendances);
        }
        [HttpGet("GetAllAttendanceByScheduleID/{scheduleId}/{classId}")]
        public async Task<IActionResult> GetAllAttendanceByScheduleID(int scheduleId,int classId)
        {
            using (var context = new StudentAttendanceDBContext())
            {
                var result = await context.Attendances
                    .Where(a => a.ScheduleId == scheduleId & a.Enrollment.ClassId == classId) // Đảm bảo trường đúng với cơ sở dữ liệu
                    .Select(a => new ViewAttendanceDTO
                    {
                        StudentId = a.Enrollment.StudentId,
                        TeacherName = a.Schedule.Teacher.Username,
                        TimeSlotId = a.Schedule.TimeSlotId,
                        Date = a.Schedule.Date,
                        Room = a.Schedule.Room,
                        ClassId = a.Enrollment.ClassId.Value,
                        ClassCode = a.Enrollment.Class.ClassCode,
                        StudentCode = a.Enrollment.Student.StudentCode,
                        FullName = a.Enrollment.Student.FullName,
                        Avatar = a.Enrollment.Student.Avatar,
                        Status = a.Status,
                        UpdatedAt = a.UpdatedAt,
                        SubstituteTeacherName = a.Schedule.SubstituteTeacher.Username,
                        TearcherName = a.Schedule.Teacher.Username,
                        DepartmentName = a.Enrollment.Student.Department.DepartmentName,
                        Note = a.Note
                    })
                    .ToListAsync(); // Sử dụng ToListAsync để truy xuất dữ liệu không đồng bộ
                return Ok(result); // Trả về kết quả

            }

        }

     


        [HttpPost("add-attendance")]
        public async Task<IActionResult> AddAttendance([FromBody] int classId)
        {
            try
            {
                await _attendanceRepository.AddAttendancesAsync(classId);
                return Ok("Thêm điểm danh thành công.");
            }
            catch (Exception ex)
            {
                // Ghi log thông tin lỗi nếu cần
                Console.WriteLine($"Lỗi khi thêm điểm danh: {ex.Message}");

                // Kiểm tra loại lỗi và trả về phản hồi tương ứng
                if (ex.Message.Contains("Không có Enrollment hoặc Schedule nào thỏa mãn điều kiện."))
                {
                    return NotFound("Không có Enrollment hoặc Schedule nào phù hợp với classId đã cho.");
                }
                else if (ex.Message.Contains("Không có bản ghi nào cần thêm mới."))
                {
                    return Conflict("Tất cả các bản ghi đã tồn tại trong hệ thống.");
                }
                else
                {
                    // Trả về lỗi nội bộ server nếu có lỗi không xác định
                    return StatusCode(500, "Đã xảy ra lỗi khi thêm điểm danh.");
                }
            }
        }

        [HttpPost("UpdateAttendance/{scheduleId}/{classId}")]
        public async Task<IActionResult> UpdateAttendance([FromBody] List<AttendanceUpdateDTO> updates, int scheduleId,int classId)
        {
            if (updates == null || !updates.Any())
            {
                return BadRequest("Invalid attendance data.");
            }

            using (var _context = new StudentAttendanceDBContext())
            {
                foreach (var update in updates)
                {
                    // Lấy EnrollmentId tương ứng với StudentId
                    var enrollment = await _context.Enrollments
                        .FirstOrDefaultAsync(e => e.StudentId == update.StudentId & e.ClassId == classId);

                    if (enrollment == null)
                    {
                        return BadRequest($"No enrollment found for StudentId {update.StudentId}.");
                    }
                        
                    // Tìm bản ghi điểm danh cho sinh viên theo EnrollmentId, ngày hôm nay và lịch học cụ thể
                    var attendanceRecord = await _context.Attendances
                        .Include(a => a.Schedule) // Đảm bảo bao gồm bảng Schedule
                        .FirstOrDefaultAsync(a =>
                            a.EnrollmentId == enrollment.EnrollmentId && // Sử dụng EnrollmentId
                            a.ScheduleId == scheduleId &&
                            a.Enrollment.ClassId == classId
                            ); // Thêm điều kiện cho ScheduleId
     
                    if (attendanceRecord != null)
                    {
                        // Cập nhật trạng thái và thời gian cập nhật
                        attendanceRecord.Status = string.IsNullOrWhiteSpace(update.Status) ? "Absent" : update.Status; // Gán "Absent" nếu không có trạng thái
                        attendanceRecord.UpdatedAt = DateTime.Now;
                        attendanceRecord.Note = update.Note;
                        attendanceRecord.Schedule.Status = "Present";
                    }
                    else
                    {
                        // Nếu không tìm thấy bản ghi, tạo bản ghi mới
                        attendanceRecord = new Attendance
                        {
                            EnrollmentId = enrollment.EnrollmentId, // Gán EnrollmentId
                            Status = string.IsNullOrWhiteSpace(update.Status) ? "Absent" : update.Status,
                            CreatedAt = DateTime.Today,
                            UpdatedAt = DateTime.Now,
                            ScheduleId = scheduleId // Thêm ScheduleId vào bản ghi mới
                        };
                        _context.Attendances.Add(attendanceRecord); // Thêm bản ghi mới vào DbSet
                    }
                }

                // Lưu thay đổi vào cơ sở dữ liệu
                await _context.SaveChangesAsync();
            }

            return Ok("Attendance updated successfully.");
        }

    }


}
