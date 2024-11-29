using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using OfficeOpenXml;
using StudentAttendanceClient.APIFunction;
using System.Net.Http.Headers;
using OfficeOpenXml; // Đảm bảo bạn đã thêm thư viện này vào phần đầu của tệp

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


    
        public async Task<IActionResult> ExportToExcel(int id)
        {
            // Lấy dữ liệu sinh viên từ ClassDTO dựa trên classId
            var classDTO = await ClassAPI.GetClassByIdAsync(id); // Giả sử bạn có service để lấy dữ liệu

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
                worksheet.Cells[1, 6].Value = "ClassId";

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
                    worksheet.Cells[row, 6].Value = classDTO.ClassId;
                    

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
        public async Task<IActionResult> AddMember(int classId, List<int> studentIds)
        {
          
        
            try
            {    Console.WriteLine($"Received Class ID: {classId}, Student IDs Count: {studentIds?.Count ?? 0}");  


                // Gọi API để thêm sinh viên vào lớp
                bool success = await EnrollmentAPI.AddStudentsToClassAsync(classId, studentIds);

                if (success)
                {  
                    await AttendanceAPI.AddAttendanceAsync(classId);

                    ViewBag.Message = "Students added successfully.";
                    ViewBag.MessageType = "success"; // hoặc "error" cho lỗi
                    return RedirectToAction("Details", "Class", new { id = classId }); // Điều hướng đến trang chi tiết lớp học
                }
                else
                {   
                    // Nếu thất bại, thêm thông báo lỗi
                    ViewBag.Message = "Failed to add students. Please try again.";
                    ViewBag.MessageType = "success"; // hoặc "error" cho lỗi

                    return RedirectToAction("Details", "Class", new { id = classId }); // Điều hướng đến trang chi tiết lớp học
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error: {ex.Message}");
                return StatusCode(500, "An error occurred while processing your request.");
            }
        }

        [HttpPost]
        public async Task<IActionResult> ImportFile(IFormFile file, int classId)
        {
            if (file == null || file.Length == 0)
            {
                return BadRequest("No file provided.");
            }

            // Validate the file type (optional)
            if (Path.GetExtension(file.FileName).ToLower() != ".xlsx")
            {
                return BadRequest("Invalid file type. Please upload an Excel (.xlsx) file.");
            }

            try
            {
                ExcelPackage.LicenseContext = LicenseContext.NonCommercial; // Hoặc LicenseContext.Commercial nếu bạn có giấy phép

                // Call the ImportFile method from EnrollmentAPI
                var result = await EnrollmentAPI.ImportFile(file, classId);

                if (result)
                {

                    return RedirectToAction("Details", "Class", new { id = classId });
                }
                else
                {
                    return BadRequest("Failed to import students from the file.");
                }
            }
            catch (Exception ex)
            {
                // Log the exception (use your preferred logging framework)
                return StatusCode(500, $"Internal server error: {ex.Message}");
            }
        }



    }
}
