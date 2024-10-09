using AutoMapper;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;
using DataAccess.DAO;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Repositories.Interface;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class StudentController : ControllerBase
    {
        public IStudentRepository _studentRepository;
        private readonly IMapper _mapper;

        public StudentController(IStudentRepository studentRepository, IMapper mapper)
        {
            _studentRepository = studentRepository;
            _mapper = mapper;

        }
        [HttpGet("GetAllStudent")]
        public async Task<IActionResult> GetAllStudent()
        {
            try
            {
                var students = await _studentRepository.GetAllStudentsAsync();
                var result = _mapper.Map<List<StudentsDTO>>(students);

                return Ok(result);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        [HttpGet("GetStudentByID/{id}")]
        public async Task<IActionResult> GetStudentByID(int id)
        {
            try
            {
                var students = await _studentRepository.GetStudentByIdAsync(id);
                var result = _mapper.Map<StudentsDTO>(students);

                return Ok(result);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        [HttpPost("AddStudent")]
        public async Task<IActionResult> AddStudent([FromBody] AddStudentDTO studentDto)
        {
            if (studentDto == null)
            {
                return BadRequest(new { message = "Invalid student data." });
            }

            try
            {
                // Kiểm tra tính hợp lệ của email
                if (!IsValidEmail(studentDto.Email))
                {
                    return BadRequest("Email không hợp lệ."); // Trả về lỗi nếu email không hợp lệ
                }

                // Kiểm tra trùng Email
                var existingStudentByEmail = await _studentRepository.GetStudentByEmailAsync(studentDto.Email);
                if (existingStudentByEmail != null)
                {
                    return Conflict(new { message = "Email already exists." });
                }
                var department = await _studentRepository.GetDepartmentByIdAsync(studentDto.DepartmentId);
                if (department == null)
                {
                    return BadRequest(new { message = "Invalid DepartmentId." });
                }

                // Lấy tên khoa dựa trên DepartmentId


                // Map từ DTO sang entity
                Student s = _mapper.Map<Student>(studentDto);
             
                // Thêm sinh viên mới vào repository
                await _studentRepository.AddStudentAsync(s);

                // Trả về phản hồi thành công với mã HTTP 201 (Created)
                return CreatedAtAction(nameof(GetStudentByID), new { id = s.StudentId }, studentDto);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message, details = ex.StackTrace });
            }
        }

        // Hàm phụ để lấy ký tự đầu tiên của từ thứ hai trong tên khoa
        private string GetSecondCharacter(string departmentName)
        {
            int firstSpaceIndex = departmentName.IndexOf(" ");
            if (firstSpaceIndex != -1 && firstSpaceIndex + 1 < departmentName.Length)
            {
                return departmentName.Substring(firstSpaceIndex + 1, 1).ToUpper(); // Lấy chữ cái đầu tiên của từ thứ hai
            }
            return "X"; // Hoặc một ký tự mặc định nếu không có từ thứ hai
        }


        [HttpPut("UpdateStudent")]
        public async Task<IActionResult> UpdateStudent( UpdateStudentDTO p)
        {
            // Lấy sinh viên từ repository
            Student student = await _studentRepository.GetStudentByIdAsync(p.StudentId);

            if (student == null)
            {
                return NotFound(); // Nếu không tìm thấy sinh viên, trả về 404
            }
            // Kiểm tra xem email đã tồn tại chưa
            var existingStudentByEmail = await _studentRepository.GetStudentByEmailAsync(p.Email);
            if (existingStudentByEmail != null && existingStudentByEmail.StudentId != p.StudentId)
            {
                return BadRequest("Email đã tồn tại."); // Trả về lỗi nếu email đã được dùng bởi sinh viên khác
            }

            // Kiểm tra tính hợp lệ của email
            if (!IsValidEmail(p.Email))
            {
                return BadRequest("Email không hợp lệ."); // Trả về lỗi nếu email không hợp lệ
            }

            // Kiểm tra xem email đã tồn tại chưa
          
            // Kiểm tra tính hợp lệ của StudentCode
            if (p.StudentCode == 0)
            {
                return BadRequest("StudentCode không được để trống."); // Trả về lỗi nếu StudentCode để trống
            }

            // Kiểm tra xem StudentCode đã tồn tại chưa
            

            // Cập nhật các thuộc tính của sinh viên từ UpdateStudentDTO
            student.StudentCode = p.StudentCode;
            student.FullName = p.FullName;
            student.DateOfBirth = p.DateOfBirth;
            student.Gender = p.Gender;
            student.Email = p.Email;
            student.Password = p.Password;
            student.PhoneNumber = p.PhoneNumber;
            student.Address = p.Address;
            student.DepartmentId = p.DepartmentId;
            student.Avatar = p.Avatar;

            // Gọi repository để cập nhật sinh viên
            await _studentRepository.UpdateStudentAsync(student);

            // Trả về NoContent để chỉ báo cập nhật thành công nhưng không có dữ liệu trả về
            return NoContent();
        }

        // Phương thức kiểm tra tính hợp lệ của email
        private bool IsValidEmail(string email)
        {
            // Sử dụng Regex để kiểm tra định dạng email
            return Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$", RegexOptions.IgnoreCase);
        }
        [HttpDelete("DeleteStudent/{id}")]
        public async Task<IActionResult> DeleteStudent(int id)
        {
            // Kiểm tra xem sinh viên có tồn tại không
            var student = await _studentRepository.GetStudentByIdAsync(id);
            if (student == null)
            {
                return NotFound(); // Nếu không tìm thấy sinh viên, trả về 404
            }

            // Gọi repository để xóa sinh viên
            await _studentRepository.DeleteStudentAsync(id);

            // Trả về NoContent để chỉ báo xóa thành công
            return NoContent();
        }
        [HttpGet("GetMaxStudentCode")]
        public async Task<IActionResult> GetMaxStudentCode()
        {
            try
            {
                var maxStudentCode = await _studentRepository.GetMaxStudentCodeAsync();
                return Ok(maxStudentCode); // Trả về mã sinh viên lớn nhất
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }
        [HttpGet("search")]
        public async Task<IActionResult> SearchStudents(string searchString)
        {
          

            try
            {
                if (string.IsNullOrWhiteSpace(searchString))
                {
                    return BadRequest("Search query cannot be empty.");
                }
                var students = await _studentRepository.SearchStudents(searchString);

                return Ok(students);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }


        }

    }

}





