using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using OfficeOpenXml;
using StudentAttendanceClient.APIFunction;
using System.Net.Http;
using System.Net.Http.Headers;

namespace StudentAttendanceClient.Controllers
{
    public class EnrollmentController : Controller
    {
        private readonly HttpClient client;
        private readonly IMapper mapper; // Inject IMapper

        public EnrollmentController(IMapper mapper)
        {
            client = new HttpClient();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            this.mapper = mapper;
        }

        public async Task<IActionResult> AddMember(int id)
        {
            var classID = await ClassAPI.GetClassByIdAsync(id);
            if (classID == null)
            {
                return NotFound(); // Trả về 404 nếu không tìm thấy sinh viên
            }
            ViewBag.Student = classID;
            return View();
        }
            
        [HttpGet]
        public async Task<IActionResult> SearchStudents(string search)
        {
            // Gọi API bất đồng bộ để tìm sinh viên
            var students = await StudentAPI.GetSearchStudent(search);
            return Ok(students);
        }
        public async Task<IActionResult> ExportToExcel(int id)
        {
            // Lấy dữ liệu sinh viên từ ClassDTO dựa trên classId
            var classDTO = await  ClassAPI.GetClassByIdAsync(id); // Giả sử bạn có service để lấy dữ liệu

            // Tạo một file Excel bằng cách sử dụng EPPlus
            using (var package = new ExcelPackage())
            {
                var worksheet = package.Workbook.Worksheets.Add("ClassStudents");

                // Thêm tiêu đề các cột
                worksheet.Cells[1, 1].Value = "INDEX";
                worksheet.Cells[1, 2].Value = "StudentId";
                worksheet.Cells[1, 3].Value = "CODE";
                worksheet.Cells[1, 4].Value = "EMAIL";
                worksheet.Cells[1, 5].Value = "FULLNAME";
                worksheet.Cells[1, 6].Value = "DEPARTMENT";

                // Thêm dữ liệu sinh viên vào các hàng
                int row = 2;
                int index = 1;
                foreach (var student in classDTO.StudentNames)
                {
                    worksheet.Cells[row, 1].Value = index;
                    worksheet.Cells[row, 2].Value = student.StudentId;
                    worksheet.Cells[row, 3].Value = student.StudentCode;
                    worksheet.Cells[row, 4].Value = student.Email;
                    worksheet.Cells[row, 5].Value = student.FullName;
                    worksheet.Cells[row, 6].Value = student.DepartmentName;

                    row++;
                    index++;
                }

                // Tạo MemoryStream để trả về file Excel
                var stream = new MemoryStream();
                package.SaveAs(stream);
                stream.Position = 0;

                // Trả về file Excel dưới dạng FileContentResult
                string excelFileName = $"Class_{classDTO.ClassCode}_Students.xlsx";
                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", excelFileName);
            }
        }

        [HttpPost]
        [HttpPost]
        public async Task<IActionResult> AddMember(int classId, List<int> studentIds)
        {
            if (classId <= 0)
            {
                return BadRequest("Invalid class ID.");
            }
            if (studentIds == null || !studentIds.Any())
            {
                return BadRequest("Student IDs cannot be null or empty.");
            }

            try
            {
                Console.WriteLine($"ClassId: {classId}");
                Console.WriteLine($"StudentIds: {string.Join(", ", studentIds)}");

                bool success = await EnrollmentAPI.AddStudentsToClassAsync(classId, studentIds);

                if (!success)
                {
                    return StatusCode(500, "Failed to add students to class.");
                }

                ViewBag.Message = "Students added successfully.";
                return View(); // or redirect as necessary
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                return StatusCode(500, "An error occurred while processing your request.");
            }
        }

    }
}
