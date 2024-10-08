using AutoMapper;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;
using DataAccess.DAO;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Repositories.Interface;
using StudentAttendanceClient.APIFunction;
using System.Net.Http.Headers;

namespace StudentAttendanceClient.Controllers
{
    public class StudentController : Controller
    {
        private readonly HttpClient client;
        private readonly IMapper mapper; // Inject IMapper
        private readonly IHubContext<Hub> _hubContext;


        public StudentController(IMapper mapper, IHubContext<Hub> hubContext)
        {

            client = new HttpClient();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            _hubContext = hubContext;
            this.mapper = mapper;
        }


        public async Task<IActionResult> Index(int DepartmentFilter = 0, int currentPage = 1, int pageSize = 5)
        {
            // Lấy danh sách sinh viên từ API dưới dạng DTO
            var studentDTOs = await StudentAPI.GetListStudentAsync();

            // Ánh xạ từ StudentDTOs sang đối tượng Student
            var students = mapper.Map<List<Student>>(studentDTOs);

            // Lấy danh sách phòng ban từ API
            var departments = await DepartmentAPI.GetListDepartmentAsync();

            // Lọc sinh viên theo phòng ban nếu đã chọn
            if (DepartmentFilter != 0)
            {
                students = students.Where(s => s.DepartmentId == DepartmentFilter).ToList();
            }

            // Tính toán số trang
            var totalStudents = students.Count();
            var totalPages = (int)Math.Ceiling(totalStudents / (double)pageSize);

            // Lấy danh sách sinh viên cho trang hiện tại
            var pagedStudents = students.Skip((currentPage - 1) * pageSize).Take(pageSize).ToList();

            // Lưu thông tin phân trang vào ViewBag
            ViewBag.Department = departments;
            ViewBag.CurrentPage = currentPage;
            ViewBag.TotalPages = totalPages;
            ViewBag.DepartmentFilter = DepartmentFilter;

            // Trả về View với danh sách sinh viên đã phân trang
            return View(pagedStudents);
        }
        [HttpPost]
        public async Task<IActionResult> Index(string searchString)
        {
            // Lấy danh sách sinh viên từ API dưới dạng DTO
            var studentDTOs = await StudentAPI.GetListStudentAsync();

            // Ánh xạ từ StudentDTOs sang đối tượng Student
            var students = mapper.Map<List<Student>>(studentDTOs);

            // Lấy danh sách phòng ban từ API
            var departments = await DepartmentAPI.GetListDepartmentAsync();

            // Lọc sinh viên theo searchString nếu có
            if (!string.IsNullOrEmpty(searchString))
            {
                // Chuyển đổi searchString thành số nguyên nếu có thể
                int studentCode;
                bool isStudentCodeValid = int.TryParse(searchString, out studentCode);

                students = students.Where(s =>
                    (isStudentCodeValid && s.StudentCode == studentCode) ||
                    s.Email.Contains(searchString, StringComparison.OrdinalIgnoreCase)).ToList();
            }

            // Cập nhật ViewBag với danh sách phòng ban
            ViewBag.Department = departments;

            // Trả về View với danh sách sinh viên đã lọc
            return View(students);
        }


        public async Task<IActionResult> Details(int id)
        {
            // Lấy thông tin sinh viên từ API
            var studentDTO = await StudentAPI.GetStudentByIdAsync(id); // Đảm bảo bạn đang nhận về đúng kiểu dữ liệu

            if (studentDTO == null)
            {
                return NotFound(); // Trả về 404 nếu không tìm thấy sinh viên
            }

            // Ánh xạ từ StudentDTO sang StudentDetailViewModel
            var studentDetail = mapper.Map<Student>(studentDTO);

            // Trả về View với thông tin chi tiết sinh viên
            return View(studentDetail);
        }

        public async Task<IActionResult> Create()
        {
            // Lấy thông tin sinh viên từ API
            var departments = await DepartmentAPI.GetListDepartmentAsync();
            ViewBag.Department = departments;

            // Tạo mã sinh viên mới
            var maxStudentCode = await StudentAPI.GetMaxStudentCodeAsync();
            ViewBag.MaxStudentCode = maxStudentCode + 1;


            // Ánh xạ từ StudentDTO sang StudentDetailViewModel
            // Trả về View với thông tin chi tiết sinh viên
            return View();
        }
        [HttpPost]
        public async Task<IActionResult> Create(AddStudentDTO student)
        {
            // Gọi API để tạo sinh viên mới
            int result = await StudentAPI.CreateStudentAsync(student);
            string message;


            if (result == 200 || result == 201) // Kiểm tra thành công (200 OK hoặc 201 Created)
            {
                message = "Student created successfully.";
                await _hubContext.Clients.All.SendAsync("ReceiveUpdate", "A new student has been created.");

                // Chuyển hướng đến trang danh sách sinh viên
                return RedirectToAction("Index");
            }
            else if (result == 400)
            {
                message = "Invalid data provided. Please check your input.";
            }
            else if (result == 409) // HTTP 409 Conflict - Email hoặc studentCode đã tồn tại
            {
                message = "Email or StudentCode already exists. Please use a different one.";
            }
            else if (result == -1 || result == -2)
            {
                message = "Failed to connect to the server. Please try again later.";
            }
            else
            {
                message = "An unexpected error occurred. Please try again.";
            }

            // Lưu thông báo để hiển thị cho người dùng
            ViewBag.Message = message;

            // Lấy danh sách phòng ban để hiển thị trong view
            var departments = await DepartmentAPI.GetListDepartmentAsync();
            ViewBag.Department = departments;


            // Tạo mã sinh viên mới
            var maxStudentCode = await StudentAPI.GetMaxStudentCodeAsync();
            ViewBag.MaxStudentCode = maxStudentCode + 1;
            if (student.StudentCode != maxStudentCode)
            {
                // Xử lý trường hợp mã đã bị thay đổi (có thể log và báo lỗi)
                message = "Student code is invalid or has been tampered with.";
                // Return lại View nếu có lỗi            }
                // Trả lại view với thông tin đã nhập và thông báo lỗi
                return View(student);
            }
            return View(student);
        }

        public async Task<IActionResult> Edit(int id)
        {
            // Lấy thông tin sinh viên từ API
            var departments = await DepartmentAPI.GetListDepartmentAsync();
            ViewBag.Department = departments;
            var student = await StudentAPI.GetStudentByIdAsync(id);
            ViewBag.Student = student;


       /*     // Tạo mã sinh viên mới
            var maxStudentCode = await StudentAPI.GetMaxStudentCodeAsync();
            ViewBag.MaxStudentCode = maxStudentCode;*/


            // Ánh xạ từ StudentDTO sang StudentDetailViewModel
            // Trả về View với thông tin chi tiết sinh viên
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Edit(UpdateStudentDTO updateStudent)
        {
          
            string message;
            int result = await StudentAPI.EditStudentAsync(updateStudent);

            // Log sản phẩm trước khi cập nhật
            if (result == 200 || result == 201) // Kiểm tra thành công (200 OK hoặc 201 Created)
            {
                message = "Student edited successfully.";

                // Chuyển hướng đến trang danh sách sinh viên
                return RedirectToAction("Index");
            }

            // Log mã trạng thái và phản hồi
            message= ($"API response: {result}");

            if (result == 200)
            {
                return RedirectToAction("Index");
            }
            else
            {
                ModelState.AddModelError("", "Unable to update the student. Please try again.");
                return View(updateStudent);
            }

        }

        public async Task<IActionResult> Delete(int id)
        {
            int result = await StudentAPI.DeleteStudent(id);
            if (result == 200)
            {
                TempData["Message"] = "Student deleted successfully.";
            }
            else
            {
                TempData["Message"] = "Error deleting product. Please try again.";
            }
            return RedirectToAction("Index");
        }
    }
}

