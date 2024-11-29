using BusinessObjects.Models;
using Microsoft.AspNetCore.Mvc;
using StudentAttendanceClient.APIFunction;

namespace StudentAttendanceClient.Controllers
{
    public class ReportController : Controller
    {
        [HttpGet]
        public async Task<IActionResult> AttendStudent(int? semesterId, int courseId)
        {
            var studentId = HttpContext.Session.GetInt32("StudentId");

            if (studentId == null)
            {
                return RedirectToAction("Default", "Authentication"); // Chuyển hướng đến trang đăng nhập nếu không tìm thấy studentId
            }
            var listSemester = await SemesterAPI.GetListSemesterAsync();

            var listClass = await ReportAPI.GetClassBySemester(studentId.Value, semesterId.Value);


            var courseIdValue = await ReportAPI.CallGetCourseIdBySemester(studentId.Value, semesterId.Value);

            var listSchedule = await ReportAPI.GetClassScheduleAPI(studentId.Value, semesterId.Value, courseId);
            


            ViewBag.Semester = listSemester;
            ViewBag.ListClass = listClass;
            ViewBag.CourseId = courseIdValue;
            ViewBag.Schedule = listSchedule;


            return View();



        }
        [HttpGet]
        public async Task<IActionResult> ScheduleOfWeek(string filterType)
        {
            var studentId = HttpContext.Session.GetInt32("StudentId");

            if (studentId == null)
            {
                return RedirectToAction("Default", "Authentication"); // Chuyển hướng đến trang đăng nhập nếu không tìm thấy studentId
            }

            var itemSlotTime = await TimeSlotAPI.GetListTimeSlotAsync();
            ViewBag.ItemSlotTime = itemSlotTime;
            var classSchedules = await ReportAPI.GetStudentSchedule(studentId.Value);

            // Lọc lịch học theo filterType
            if (!string.IsNullOrEmpty(filterType))
            {
                DateTime today = DateTime.Today;
                switch (filterType.ToLower())
                {
                    case "today":
                        classSchedules = classSchedules
                            .Where(cs => cs.Date.Date == today)
                            .ToList();
                        break;
                    case "thisweek":
                        classSchedules = classSchedules
                            .Where(cs => cs.Date.Date >= today && cs.Date.Date < today.AddDays(7))
                            .ToList();
                        break;
                    default:
                        break;
                }
            }

            return View(classSchedules);
        }
        public async Task<IActionResult> AttendanceGroup(int semesterId, int courseId ,int classId)
        {

            var teacherId = HttpContext.Session.GetInt32("TeacherId"); // Thay "StudentId" bằng "TeacherId"
            if (teacherId == null)
            {
                return RedirectToAction("Default", "Authentication"); // Chuyển hướng đến trang đăng nhập nếu không tìm thấy studentId
            }
            var listSemester = await SemesterAPI.GetListSemesterAsync();
            var listCourse = await ReportAPI.GetCoursesBySemester(teacherId.Value, semesterId);
            var listClass = await ReportAPI.GetClassBySemesterAndCourse(teacherId.Value, semesterId,courseId);
            var listStudentTR1 = await ReportAPI.GetAllStudentByTeacherAndCourseAndClass(teacherId.Value, semesterId, courseId, classId); 
            var listDateSchedule = await ReportAPI.GetAllAttendanceStudentByDate(teacherId.Value, semesterId, courseId, classId); 
            var listStatus = await ReportAPI.GetAllAttendanceByTeacherAndCourseAndClass(teacherId.Value, semesterId, courseId, classId); 
            ViewBag.Semester = listSemester;
            ViewBag.ListCourses = listCourse;
            ViewBag.ListClass = listClass;
            ViewBag.ListStudent = listStudentTR1;
            ViewBag.ListDateSchedule = listDateSchedule;
            ViewBag.ListStatus = listStatus;
            return View(); // Đảm bảo bạn trả về dữ liệu từ API vào view
        }
    }
}
