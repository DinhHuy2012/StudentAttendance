using AutoMapper;
using BusinessObjects.DTO.ClassDTO;
using BusinessObjects.DTO.ClassDTO.ClassDTO;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Repositories.Interface;

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ClassController : ControllerBase
    {
        private readonly IMapper _mapper;

        public IClassRepository _classRepository;
        public ClassController(IClassRepository classRepository, IMapper mapper)
        {
            _classRepository = classRepository;
            _mapper = mapper;

        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetClassById(int id)
        {
            var classData = await _classRepository.GetClassByIdAsync(id);
            if (classData == null) return NotFound();
            var classDTO = _mapper.Map<ClassesDTO>(classData);

            return Ok(classDTO);
        }
        [HttpGet("GetAllClass")]
        public async Task<IActionResult> GetAllClass()
        {
            try
            {
                var classes = await _classRepository.GetAllClassesAsync();
                var result = _mapper.Map<List<AllClassDTO>>(classes);

                return Ok(result);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        [HttpPost("AddClass")]
        public async Task<IActionResult> AddClass([FromBody] AddClassDTO classDto)
        {
            if (classDto == null)
            {
                return BadRequest(new { message = "Invalid student data." });
            }

            try
            {

                // Kiểm tra trùng ClassCode
                var existingClassByClassCode = await _classRepository.GetClassByClassCodeAsync(classDto.ClassCode);
                if (existingClassByClassCode != null)
                {
                    return Conflict(new { message = "ClassCode already exists." });
                }
                // Map từ DTO sang entity
                Class s = _mapper.Map<Class>(classDto);

                // Thêm class mới vào repository
                await _classRepository.AddClassAsync(s);

                // Trả về phản hồi thành công với mã HTTP 201 (Created)
                return Ok(s);
            }
            catch (Exception ex)
            {
                return BadRequest(new { message = ex.Message, details = ex.StackTrace });
            }
        }
        [HttpPut("UpdateClass")]
        public async Task<IActionResult> UpdateClass(AllClassDTO p)
        {
            // Lấy class từ repository
            Class classes = await _classRepository.GetClassByIdAsync(p.ClassId);

            if (classes == null)
            {
                return NotFound(); // Nếu không tìm thấy sinh viên, trả về 404
            }
            // Kiểm tra xem classcode đã tồn tại chưa
            var existingClassByClassCode = await _classRepository.GetClassByClassCodeAsync(p.ClassCode);
            if (existingClassByClassCode != null && existingClassByClassCode.ClassId != p.ClassId)
            {
                return BadRequest("ClassCode đã tồn tại."); // Trả về lỗi nếu classcode đã được dùng bởi sinh viên khác
            }
            classes.ClassCode = p.ClassCode;
            classes.ClassName = p.ClassName;
            classes.Note = p.Note;

            // Gọi repository để cập nhật sinh viên
            await _classRepository.UpdateClassAsync(classes);

            // Trả về NoContent để chỉ báo cập nhật thành công nhưng không có dữ liệu trả về
            return NoContent();
        }
        [HttpDelete("DeleteClass/{id}")]
        public async Task<IActionResult> DeleteClass(int id)
        {
            // Kiểm tra xem sinh viên có tồn tại không
            var student = await _classRepository.GetClassByIdAsync(id);
            if (student == null)
            {
                return NotFound(); // Nếu không tìm thấy class, trả về 404
            }

            // Gọi repository để xóa sinh viên
            await _classRepository.DeleteClassAsync(id);

            // Trả về NoContent để chỉ báo xóa thành công
            return NoContent();
        }
    }
}
