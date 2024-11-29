using BusinessObjects.DTO.ReportDTO;
using BusinessObjects.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReportController : ControllerBase
    {
        [HttpGet("GetClassBySemester/{studentId}/{semesterId}")]
        public async Task<IActionResult> GetClassBySemester(int studentId, int semesterId)
        {
            
            try
            {
                // Tạo context để kết nối với cơ sở dữ liệu
                using (var context = new StudentAttendanceDBContext())
                {
                    // Truy vấn dữ liệu theo yêu cầu
                    var classes = await context.Enrollments
                   .Where(e => e.StudentId == studentId && e.Class.SemesterId == semesterId)
                      .GroupBy(e => new
                      {
                          e.Class.ClassId,
                          e.Class.ClassCode,
                          e.Class.Semester.SemesterId,
                          e.Class.Semester.SemesterName,
                          e.Class.Semester.Status,
                          CourseId = e.Class.Schedules.FirstOrDefault().CourseId,
                          CourseCode = e.Class.Schedules.FirstOrDefault().Course != null ? e.Class.Schedules.FirstOrDefault().Course.CourseCode : null,
                          CourseName = e.Class.Schedules.FirstOrDefault().Course != null ? e.Class.Schedules.FirstOrDefault().Course.CourseName : null
                      })
                          .Select(g => new
                          {
                              ClassID = g.Key.ClassId,
                              ClassCode = g.Key.ClassCode,
                              SemesterID = g.Key.SemesterId,
                              SemesterName = g.Key.SemesterName,
                              Status = g.Key.Status,
                              CourseID = g.Key.CourseId,
                              CourseCode = g.Key.CourseCode,
                              CourseName = g.Key.CourseName
                          })
                .ToListAsync();


                    // Trả về danh sách classes dưới dạng JSON
                    return Ok(classes);
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ và trả về thông báo lỗi
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
        [HttpGet("GetCoursesBySemester/{teacherId}/{semesterId}")]
        public async Task<IActionResult> GetCoursesBySemester(int teacherId, int semesterId)
        {
            try
            {
                // Tạo context để kết nối với cơ sở dữ liệu
                using (var context = new StudentAttendanceDBContext())
                {
                    var result = await context.Schedules
                        .Where(s => s.TeacherId == teacherId) // Sử dụng tham số teacherId
                        .Join(context.Classes, s => s.ClassId, cl => cl.ClassId, (s, cl) => new { s, cl })
                        .Where(x => x.cl.SemesterId == semesterId) // Lọc theo semesterId
                        .Join(context.Courses, x => x.s.CourseId, c => c.CourseId, (x, c) => new
                        {
                            x.cl.ClassId,
                            x.cl.ClassCode,
                            x.cl.SemesterId,
                            x.s.CourseId,
                            c.CourseCode,
                            c.CourseName
                        })
                        .GroupBy(x => x.CourseId)
                        .Select(g => g.FirstOrDefault()) // Lấy bản ghi đầu tiên cho mỗi CourseId
                        .ToListAsync(); // Sử dụng ToListAsync để thực hiện truy vấn bất đồng bộ

                    // Trả về danh sách lớp học và khóa học dưới dạng JSON
                    return Ok(result);
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ và trả về thông báo lỗi
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }
        [HttpGet("GetClassBySemesterAndCourse/{teacherId}/{semesterId}/{courseId}")]
        public async Task<IActionResult> GetClassBySemesterAndCourse(int teacherId, int semesterId, int courseId)
        {
            try
            {
                // Tạo context để kết nối với cơ sở dữ liệu
                using (var context = new StudentAttendanceDBContext())
                {
                    var result = await context.Schedules
     .Include(s => s.Class) // Bao gồm thông tin lớp
     .Include(s => s.Course) // Bao gồm thông tin khóa học
     .Where(s => s.TeacherId == teacherId && s.Class.SemesterId == semesterId && s.CourseId == courseId) // Lọc theo TeacherId, CourseId và SemesterId
     .Select(s => new
     {
         ClassID = s.Class.ClassId,
         ClassCode = s.Class.ClassCode,
         SemesterID = s.Class.SemesterId,
         CourseID = s.CourseId,
         CourseCode = s.Course.CourseCode,
         CourseName = s.Course.CourseName
     })
     .Distinct() // Lấy các bản ghi duy nhất
     .ToListAsync(); // Thực hiện truy vấn một cách bất đồng bộ
                    return Ok(result);
                }
            }
            catch (Exception ex)
            {
                // Xử lý ngoại lệ và trả về thông báo lỗi
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }



        [HttpGet("GetCourseIdBySemester/{studentId}/{semesterId}")]
        public async Task<IActionResult> GetCourseIdBySemester(int studentId, int semesterId)
        {
            try
            {
                using (var context = new StudentAttendanceDBContext())
                {
                    var courseId = (from e in context.Enrollments
                                    join cl in context.Classes on e.ClassId equals cl.ClassId
                                    join s in context.Semesters on cl.SemesterId equals s.SemesterId
                                    join sch in context.Schedules on cl.ClassId equals sch.ClassId
                                    where e.StudentId == studentId && s.SemesterId == semesterId
                                    group new { cl, s, e, sch } by new
                                    {
                                        cl.ClassId,
                                        cl.ClassCode,
                                        s.SemesterId,
                                        s.SemesterName,
                                        e.Status,
                                        sch.CourseId
                                    } into grouped
                                    select grouped.Key.CourseId)
                                .FirstOrDefault();

                    if (courseId == null)
                    {
                        // Trả về danh sách rỗng nếu không tìm thấy khóa học
                        return Ok(0);
                    }

                    return Ok(courseId);
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpGet("GetClassSchedule/{studentId}/{semesterId}/{courseId}")]
        public async Task<IActionResult> GetClassSchedule(int studentId, int semesterId, int courseId)
        {
            try
            {
                using (var context = new StudentAttendanceDBContext())
                {
                    var result = await context.Enrollments
                        .Where(e => e.StudentId == studentId && e.Class.Semester.SemesterId == semesterId)
                        .SelectMany(e => e.Class.Schedules
                            .Where(s => s.CourseId == courseId)
                            .Select(s => new ClassSchedule
                            {
                                ClassID = e.Class.ClassId,
                                ClassCode = e.Class.ClassCode,
                                SemesterID = e.Class.Semester.SemesterId,
                                SemesterName = e.Class.Semester.SemesterName,
                                Status = e.Status,
                                CourseCode = s.Course.CourseCode,
                                ScheduleID = s.ScheduleId,
                                CourseID = s.CourseId.Value,
                                Room = s.Room,
                                Date = s.Date.Value,
                                TimeSlotID = s.TimeSlotId,
                                StartTime = s.TimeSlot.StartTime, // Joining TimeSlot to get StartTime
                                EndTime = s.TimeSlot.EndTime,     // Joining TimeSlot to get EndTime
                                TeacherID = s.TeacherId.Value,
                                TeacherName = s.Teacher.Username,
                                AttendanceStatus = e.Attendances
                                    .Where(at => at.ScheduleId == s.ScheduleId) // Filter for the correct schedule
                                    .Select(at => at.Status)
                                    .FirstOrDefault(), // Get the latest attendance status
                                Note = e.Attendances
                                    .Where(at => at.ScheduleId == s.ScheduleId) // Filter for the correct schedule
                                    .Select(at => at.Note)
                                    .FirstOrDefault() // Get the latest attendance note
                            })
                        ).OrderBy(cs => cs.Date)

                        .ToListAsync();

                    return Ok(result);
                }

            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpGet("GetStudentSchedule/{studentId}")]
        public async Task<IActionResult> GetStudentSchedule(int studentId)
        {
            try
            {
                using (var context = new StudentAttendanceDBContext())
                {
                    var result = await context.Enrollments
                        .Where(e => e.StudentId == studentId)
                        .SelectMany(e => e.Class.Schedules

                            .Select(s => new ClassSchedule
                            {
                                ClassID = e.Class.ClassId,
                                ClassCode = e.Class.ClassCode,
                                SemesterID = e.Class.Semester.SemesterId,
                                SemesterName = e.Class.Semester.SemesterName,
                                Status = e.Status,
                                CourseCode = s.Course.CourseCode,
                                ScheduleID = s.ScheduleId,
                                CourseID = s.CourseId.Value,
                                Room = s.Room,
                                Date = s.Date.Value,
                                TimeSlotID = s.TimeSlotId,
                                StartTime = s.TimeSlot.StartTime, // Joining TimeSlot to get StartTime
                                EndTime = s.TimeSlot.EndTime,     // Joining TimeSlot to get EndTime
                                TeacherID = s.TeacherId.Value,
                                TeacherName = s.Teacher.Username,
                                AttendanceStatus = e.Attendances
                                    .Where(at => at.ScheduleId == s.ScheduleId) // Filter for the correct schedule
                                    .Select(at => at.Status)
                                    .FirstOrDefault(), // Get the latest attendance status
                                Note = e.Attendances
                                    .Where(at => at.ScheduleId == s.ScheduleId) // Filter for the correct schedule
                                    .Select(at => at.Note)
                                    .FirstOrDefault() // Get the latest attendance note
                            })
                        ).OrderBy(cs => cs.Date)

                        .ToListAsync();

                    return Ok(result);
                }

            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }

        [HttpGet("GetAllStudentByTeacherAndCourseAndClass/{teacherId}/{semesterId}/{courseId}/{classId}")]
        public async Task<IActionResult> GetAllStudentByTeacherAndCourseAndClass(int teacherId, int semesterId, int courseId, int classId)
        {
            using (var context = new StudentAttendanceDBContext())
            {
                var result = context.Attendances
      .Where(a => a.Enrollment.ClassId == classId
                  && a.Schedule.CourseId == courseId
                  && a.Enrollment.Class.SemesterId == semesterId
                  && a.Schedule.TeacherId == teacherId)
      .GroupBy(a => new { a.Enrollment.Student.FullName, a.Enrollment.StudentId, a.Enrollment.Student.StudentCode, a.Enrollment.Student.Department.DepartmentName })
      .Select(g => new
      {
          g.Key.FullName,
          g.Key.StudentId,
          g.Key.StudentCode,
          g.Key.DepartmentName,
          TotalSessions = g.Count(),
          AbsentSessions = g.Count(a => a.Status == "Absent"),
          AbsentPercentage = (g.Count(a => a.Status == "Absent") * 100.0) / g.Count()
      })
      .OrderBy(x => x.FullName)
      .ToList();
                return Ok(result); // Trả về kết quả

            }

        }

        [HttpGet("GetAllAttendanceByTeacherAndCourseAndClass/{teacherId}/{semesterId}/{courseId}/{classId}")]
        public async Task<IActionResult> GetAllAttendanceByTeacherAndCourseAndClass(int teacherId, int semesterId, int courseId, int classId)
        {
            using (var context = new StudentAttendanceDBContext())
            {
                var result = context.Attendances
        .Where(a => a.Enrollment.ClassId == classId
                  && a.Schedule.CourseId == courseId
                  && a.Enrollment.Class.SemesterId == semesterId
                  && a.Schedule.TeacherId == teacherId)
        .OrderBy(a => a.Enrollment.Student.FullName )
                    .ThenBy(a => a.Schedule.Date)

        .Select(a => new { a.Enrollment.Student.FullName,a.Enrollment.Student.Department.DepartmentName,a.Enrollment.Student.StudentCode, a.ScheduleId, a.Status, a.Enrollment.StudentId, a.Schedule.Date })

        .ToList();

                return Ok(result); // Trả về kết quả

            }

        }

        [HttpGet("GetAllAttendanceStudentByDate/{teacherId}/{semesterId}/{courseId}/{classId}")]
        public async Task<IActionResult> GetAllAttendanceStudentByDate(int teacherId, int semesterId, int courseId, int classId)
        {
            using (var context = new StudentAttendanceDBContext())
            {
                var result = context.Attendances
        .Where(a => a.Enrollment.ClassId == classId
                  && a.Schedule.CourseId == courseId
                  && a.Enrollment.Class.SemesterId == semesterId
                  && a.Schedule.TeacherId == teacherId)
       .Select(a => a.Schedule.Date)
       .Distinct()
       .OrderBy(date => date)
 .ToList()
    .Select((date, index) => new
    {
        RowNumber = index + 1, // Bắt đầu từ 1
        Date = date
    })
    .ToList();
                return Ok(result); // Trả về kết quả

            }

        }


    }
}
