using BusinessObjects.DTO;
using BusinessObjects.DTO.StudentDTO;
using Microsoft.AspNetCore.Mvc;
using StudentAttendanceClient.APIFunction;

namespace StudentAttendanceClient.Controllers
{
    public class AuthenticationController : Controller
    {
        public IActionResult Default()
        {


            return View();
        }


        [HttpPost]
        public async Task<IActionResult> LoginByStudent(StudentLoginDTO student)
        {
            if (ModelState.IsValid)
            {
                var token = await AuthAPI.LoginByStudent(student);

                if (token != null)  
                {
                    // Lưu trữ token
                    HttpContext.Session.SetString("Token", token);
                    var studentInfo = await StudentAPI.GetStudentByEmailAsync(student.Email); // Giả sử bạn có phương thức này

                    if (studentInfo != null)
                    {   
                        // Lưu trữ thông tin sinh viên vào session
                        HttpContext.Session.SetInt32("StudentId", studentInfo.StudentId);
                        HttpContext.Session.SetString("FullName", studentInfo.FullName);
                        HttpContext.Session.SetString("Email", studentInfo.Email);
                        HttpContext.Session.SetString("PhoneNumber", studentInfo.PhoneNumber);
                        // Thêm các thông tin khác nếu cần
                    }
                    // Chuyển hướng đến trang chính
                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ViewBag.Message = "Đăng nhập không thành công. Vui lòng kiểm tra lại thông tin.";
                }
            }

            return View("Default");
        }

        [HttpPost]
        public async Task<IActionResult> LoginByTeacherOrAdmin(TeacherLoginDTO teacher)
        {
            if (ModelState.IsValid)
            {
                var token = await AuthAPI.LoginByTeacher(teacher);

                if (token != null)
                {
                    // Lưu trữ token
                    HttpContext.Session.SetString("Token", token);
                    var teacherInfo = await TeacherAPI.GetTeacherByEmail(teacher.Email); // Giả sử bạn có phương thức này

                    if (teacherInfo != null)
                    {
                        // Lưu trữ thông tin sinh viên vào session
                        HttpContext.Session.SetInt32("TeacherId", teacherInfo.TeacherId);
                        HttpContext.Session.SetString("Username", teacherInfo.Username);
                        HttpContext.Session.SetString("Email", teacherInfo.Email);
                        HttpContext.Session.SetString("FullName", teacherInfo.FullName);
                        HttpContext.Session.SetString("Role", teacherInfo.Role);
                        return RedirectToAction("Index", "Home");

                        // Thêm các thông tin khác nếu cần      
                    }
                    // Chuyển hướng đến trang chính
                }
                else
                {
                    ViewBag.MessageTeacher = "Đăng nhập không thành công. Vui lòng kiểm tra lại thông tin.";
                }
            }

            return View("Default");
        }
        [HttpGet]
        public IActionResult Logout()
        {
            // Xóa thông tin session đã lưu
            HttpContext.Session.Clear();

            // Chuyển hướng về trang đăng nhập
            return RedirectToAction("Default", "Authentication");
        }
    }





}
