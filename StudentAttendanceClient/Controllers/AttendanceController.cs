using AutoMapper;
using BusinessObjects.DTO.AttendanceDTO;
using BusinessObjects.DTO.ReportDTO;
using BusinessObjects.DTO.ScheduleDTO;
using BusinessObjects.Models;
using Microsoft.AspNetCore.Mvc;
using Repositories.Interface;
using StudentAttendanceClient.APIFunction;

namespace StudentAttendanceClient.Controllers
{
    public class AttendanceController : Controller
    {


        public async Task<IActionResult> TakeAttendance(string filterType)
        {
            // Lấy thời gian hiện tại
            DateTime dateTime = DateTime.Today;

            // Lấy teacherId từ session
            var teacherId = HttpContext.Session.GetInt32("TeacherId"); // Thay "StudentId" bằng "TeacherId"
            if (teacherId == null)
            {
                return RedirectToAction("Default", "Authentication"); // Chuyển hướng đến trang đăng nhập nếu không tìm thấy studentId
            }
            // Chuyển đổi teacherId sang int
            var attendanceTeacher = await ScheduleAPI.GetSchedulesAsync(teacherId.Value);

            if (string.IsNullOrEmpty(filterType) || filterType.ToLower() == "today")
            {
                DateTime todaytv = DateTime.Today;

                // Lọc cho ngày hôm nay hoặc khi không có filterType
                attendanceTeacher = attendanceTeacher
                        .Where(cs => cs.Date == todaytv)
                        .ToList();
            }
            else
            {
                switch (filterType.ToLower())
                {
                    case "2daysbefore":
                        DateTime twoDaysBefore = dateTime.AddDays(-2);
                        attendanceTeacher = attendanceTeacher
                            .Where(cs => cs.Date >= twoDaysBefore && cs.Date < dateTime.AddDays(1)) // Lấy từ 2 ngày trước đến trước ngày hôm nay
                            .ToList();
                        break;
                    default:
                        break;
                }
            }

            // Gọi API để lấy danh sách lịch

            // Truyền dữ liệu vào view
            return View(attendanceTeacher); // Đảm bảo bạn trả về dữ liệu từ API vào view
        }


        public async Task<IActionResult> ViewAttendance(int scheduleId, int classId)
        {
            ScheduleListDTO checkScheduleId = await ScheduleAPI.GetScheduleByViewAttendanceId(scheduleId);
            if (checkScheduleId == null)
            {
                return BadRequest("Schedule Not Found");
            }
            List<ScheduleListDTO> schedules = await ScheduleAPI.GetScheduleByClassAndCourseAsync(checkScheduleId.ClassId, checkScheduleId.CourseId.Value);

            // Kiểm tra kiểu dữ liệu của schedules
            if (schedules == null || !schedules.Any())
            {
                return NotFound("No schedules found.");
            }
            int position = schedules.FindIndex(s => s.ScheduleId == scheduleId);
            if (position == -1)
            {
                return BadRequest("Schedule ID not found in the list.");
            }
            ViewBag.position = position + 1;

            ViewBag.Schedule = checkScheduleId;
            var teacherId = HttpContext.Session.GetInt32("TeacherId"); // Thay "StudentId" bằng "TeacherId"
            if (teacherId == null)
            {
                return RedirectToAction("Default", "Authentication"); // Chuyển hướng đến trang đăng nhập nếu không tìm thấy studentId
            }
            var viewAttendance = await AttendanceAPI.GetAllAttendanceByScheduleID(scheduleId, classId);
            return View(viewAttendance); // Đảm bảo bạn trả về dữ liệu từ API vào view
        }


        public async Task<IActionResult> EditAttendance(int scheduleId, int classId)
        {
            ScheduleListDTO checkScheduleId = await ScheduleAPI.GetScheduleByViewAttendanceId(scheduleId);
            if (checkScheduleId == null)
            {
                return BadRequest("Schedule Not Found");
            }
            List<ScheduleListDTO> schedules = await ScheduleAPI.GetScheduleByClassAndCourseAsync(checkScheduleId.ClassId, checkScheduleId.CourseId.Value);

            // Kiểm tra kiểu dữ liệu của schedules
            if (schedules == null || !schedules.Any())
            {
                return NotFound("No schedules found.");
            }
            int position = schedules.FindIndex(s => s.ScheduleId == scheduleId);
            if (position == -1)
            {
                return BadRequest("Schedule ID not found in the list.");
            }
            ViewBag.position = position + 1;

            ViewBag.Schedule = checkScheduleId;
            var teacherId = HttpContext.Session.GetInt32("TeacherId"); // Thay "StudentId" bằng "TeacherId"
            if (teacherId == null)
            {
                return RedirectToAction("Default", "Authentication"); // Chuyển hướng đến trang đăng nhập nếu không tìm thấy studentId
            }
            var viewAttendance = await AttendanceAPI.GetAllAttendanceByScheduleID(scheduleId, classId);
            return View(viewAttendance); // Đảm bảo bạn trả về dữ liệu từ API vào view
        }


        [HttpPost]
        public async Task<IActionResult> EditAttendance(int scheduleId, int classId, List<AttendanceUpdateDTO> updates)
            {
            if (updates.Any(u => u.StudentId == 0 || string.IsNullOrEmpty(u.Status)))
            {
                return BadRequest("Một số thuộc tính trong updates không hợp lệ.");
            }

            // Gọi phương thức UpdateAttendanceAsync từ AttendanceAPI
            var result = await AttendanceAPI.UpdateAttendanceAsync(scheduleId, classId, updates);

            if (result >= 200 && result < 300)
            {
                return RedirectToAction("TakeAttendance", "Attendance"); // Chuyển hướng đến trang đăng nhập nếu không tìm thấy studentId

            }
            else
            {
                return StatusCode(result, "Failed to update attendance."); // Trả về mã lỗi tương ứng
            }
        }

    }

}
