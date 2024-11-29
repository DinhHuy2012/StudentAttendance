using BusinessObjects.DTO.ScheduleDTO;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using StudentAttendanceClient.APIFunction;
using System.Runtime.InteropServices;

namespace StudentAttendanceClient.Controllers
{
    public class ScheduleController : Controller
    {
        [HttpGet]
        public async Task<IActionResult> ScheduleOfClass(int classId, int courseId)
        {
            var schedulebyclass =  await ScheduleAPI.GetScheduleByClassAndCourseAsync(classId,courseId);
            var classDetail = await ClassAPI.GetClassByIdAsync(classId);
            var listScheduleByClass = await ScheduleAPI.GetScheduleByclassIdAsync(classId);
            ViewBag.ListScheduleByClass = listScheduleByClass.GroupBy(x => x.CourseCode);

                
            ViewBag.ClassDetail = classDetail;


            return View(schedulebyclass);
        }
        [HttpGet]
        public async Task<IActionResult> AddSchedule(int classId)
        {   
            List<TimeSlot> t = await TimeSlotAPI.GetListTimeSlotAsync();
            ViewBag.TimeSlot = t;

            List<Course> c = await CourseAPI.GetListCourseAsync();  
            ViewBag.Course = c;

            List<Teacher> teachers = await TeacherAPI.GetListTeacherAsync();
            ViewBag.Teacher = teachers;

            var item = await ClassAPI.GetClassByIdAsync(classId);
            ViewBag.ClassDetail = item;
            
            

            // Gọi API để thêm lịch học
            var itemSchedule = await ScheduleAPI.AddScheduleByClassIdAsync(item.ClassId);
            var attend = await AttendanceAPI.AddAttendanceAsync(item.ClassId);

            // Kiểm tra nếu itemSchedule là null
            if (itemSchedule == null && attend == null)
            {
                // Nếu null, có thể tạo một đối tượng AddScheduleDTO mới hoặc xử lý khác
                // Cách này là tạo một đối tượng AddScheduleDTO mặc định
                var addScheduleDTO = new AddScheduleDTO(); // Tạo đối tượng mặc định
                ViewBag.ErrorMessage = "Không thể thêm lịch học cho lớp này."; // Thông báo lỗi
                return View(addScheduleDTO); // Trả về View với đối tượng AddScheduleDTO
            }

            // Nếu không null, trả về view với itemSchedule
            return View(itemSchedule);
        }

        [HttpPost]
        public async Task<IActionResult> AddSchedule(AddScheduleDTO addScheduleDTO)
        {
            // Gọi API để tạo lịch học mới
            int result = await ScheduleAPI.AddScheduleAsync(addScheduleDTO);
            string message = string.Empty;

            // Kiểm tra mã kết quả trả về từ API
            if (result == 200 || result == 201) // Kiểm tra thành công (200 OK hoặc 201 Created)
            {
                // Nếu lịch học được tạo thành công, thực hiện điểm danh
                var attendanceResult = await AttendanceAPI.AddAttendanceAsync(addScheduleDTO.ClassId);

                // Kiểm tra kết quả điểm danh
                if (attendanceResult != 200) // Giả sử 200 là mã thành công cho điểm danh
                {
                    // Xử lý nếu điểm danh không thành công
                    message = "Schedule created successfully, but attendance could not be added.";
                }
                else
                {
                    message = "Schedule and attendance created successfully.";
                }
                return RedirectToAction("ScheduleOfClass", "Schedule", new { classId = addScheduleDTO.ClassId, courseId = addScheduleDTO.CourseId });
            }

            // Xử lý các mã lỗi khác
            switch (result)
            {
                case 400:
                    message = "Invalid data provided. Please check your input.";
                    break;
                case 409: // HTTP 409 Conflict
                    message = "Schedule already exists.";
                    break;
                case -1:
                case -2:
                    message = "Failed to connect to the server. Please try again later.";
                    break;
                default:
                    message = "An unexpected error occurred. Please try again.";
                    break;
            }

            // Lưu thông báo để hiển thị cho người dùng
            ViewBag.Message = message;

            // Tải lại danh sách TimeSlot, Course, Teacher và ClassDetail
            ViewBag.TimeSlot = await TimeSlotAPI.GetListTimeSlotAsync();
            ViewBag.Course = await CourseAPI.GetListCourseAsync();
            ViewBag.Teacher = await TeacherAPI.GetListTeacherAsync();
            ViewBag.ClassDetail = await ScheduleAPI.AddScheduleByClassIdAsync(addScheduleDTO.ClassId);

            // Trả lại view với AddScheduleDTO
            return View(addScheduleDTO);
        }

        [HttpGet]
        public async Task<IActionResult> EditSchedule(int scheduleId)
        {
            List<TimeSlot> t = await TimeSlotAPI.GetListTimeSlotAsync();
            ViewBag.TimeSlot = t;

            List<Course> c = await CourseAPI.GetListCourseAsync();
            ViewBag.Course = c;

            List<Teacher> teachers = await TeacherAPI.GetListTeacherAsync();
            ViewBag.Teacher = teachers;

            var item = await ScheduleAPI.GetScheduleByScheduleId(scheduleId);

            // Nếu không null, trả về view với itemSchedule
            return View(item);
        }
        [HttpPost]
        public async Task<IActionResult> EditSchedule(EditScheduleDTO editSchedule)
        {

            string message;
            int result = await ScheduleAPI.EditScheduleAsync(editSchedule);

            // Log sản phẩm trước khi cập nhật
            if (result == 200 || result == 201) // Kiểm tra thành công (200 OK hoặc 201 Created)
            {
                message = "Student edited successfully.";

                // Chuyển hướng đến trang danh sách sinh viên
                return RedirectToAction("ScheduleOfClass", new { classId = editSchedule.ClassId, courseId = editSchedule.CourseId });
            }

            // Log mã trạng thái và phản hồi
            message = ($"API response: {result}");

            if (result == 200)
            {
                return RedirectToAction("Index");
            }
            else
            {
                ModelState.AddModelError("", "Unable to update the schedule. Please try again.");
                return View(editSchedule);
            }

        }
        public async Task<IActionResult> DeleteSchedule(int id)
        {
            // Call the API to delete the schedule
            int result = await ScheduleAPI.DeleteSchedule(id);

            if (result == 200)
            {
                TempData["Message"] = "Schedule deleted successfully.";
            }
            else
            {
                TempData["Message"] = "Error deleting schedule. Please try again.";
            }

            // You need to fetch the schedule details (classId and courseId) before redirection
            var schedule = await ScheduleAPI.GetScheduleByScheduleId(id);
            if (schedule == null)
            {
                // Handle the case where the schedule does not exist (optional)
                return RedirectToAction("Index", "Home"); // Redirect to a different action if needed
            }

            // Redirect to ScheduleOfClass with the corresponding classId and courseId
            return RedirectToAction("ScheduleOfClass", new { classId = schedule.ClassId, courseId = schedule.CourseId });
        }

    }
}
