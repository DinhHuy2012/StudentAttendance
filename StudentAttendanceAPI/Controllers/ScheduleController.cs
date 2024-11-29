using AutoMapper;
using BusinessObjects.DTO.ClassDTO.ClassDTO;
using BusinessObjects.DTO.ClassDTO;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Repositories.Interface;
using Repositories.Repository;
using BusinessObjects.DTO.ScheduleDTO;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;
using DataAccess.DAO;
using Microsoft.EntityFrameworkCore;

namespace StudentAttendanceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ScheduleController : ControllerBase
    {
        private readonly IMapper _mapper;

        public IScheduleRepository _scheduleRepository;
        public ScheduleController(IScheduleRepository scheduleRepository, IMapper mapper)
        {
            _scheduleRepository = scheduleRepository;
            _mapper = mapper;

        }


        [HttpGet("GetAllSchedule")]
        public async Task<IActionResult> GetAllSchedule()
        {
            try
            {
                var schedules = await _scheduleRepository.GetAllSchedulesAsync();
                var result = _mapper.Map<List<ScheduleListDTO>>(schedules);

                return Ok(result);

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        [HttpGet("GetScheduleByClassId/{classId}")]
        public async Task<IActionResult> GetScheduleByClassIdAsync(int classId)
        {
            try
            {
                var schedules = await _scheduleRepository.GetScheduleByClassIdAsync(classId);
                if (schedules == null) return NotFound();
                var dto = _mapper.Map<List<ScheduleListDTO>>(schedules);
                return Ok(dto);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        [HttpGet("GetScheduleByClassAndCourseAsync/{classId}/{courseId}")]
        public async Task<IActionResult> GetScheduleByClassAndCourseAsync(int classId, int courseId)
        {
            try
            {
                var schedules = await _scheduleRepository.GetScheduleByClassAndCourse(classId, courseId);
                if (schedules == null) return NotFound();
                var dto = _mapper.Map<List<ScheduleListDTO>>(schedules);
                return Ok(dto);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        [HttpGet("GetScheduleByScheduleId/{scheduleId}")]
        public async Task<IActionResult> GetScheduleByScheduleId(int scheduleId)
        {
            var data = await _scheduleRepository.GetScheduleByIdAsync(scheduleId);
            if (data == null) return NotFound();
            var dataDTO = _mapper.Map<ScheduleListDTO>(data);

            return Ok(dataDTO);
        }


        [HttpGet("AddScheduleByClassId/{classId}")]
        public async Task<IActionResult> GetClassById(int classId)
        {
            var classData = await _scheduleRepository.AddScheduleByClassIdAsync(classId);
            if (classData == null) return NotFound();
            var classDTO = _mapper.Map<AddScheduleDTO>(classData);

            return Ok(classDTO);
        }
        [HttpPost("AddSchedule")]
        public async Task<IActionResult> AddSchedule([FromBody] AddScheduleDTO scheduleDTO)
        {
            try
            {
                // Kiểm tra xung đột lịch
                var isScheduleConflict = await _scheduleRepository.IsScheduleConflictAsync(scheduleDTO.TimeSlotId, scheduleDTO.Room, scheduleDTO.Date);
                if (isScheduleConflict)
                {
                    return Conflict(new { message = "Schedule already exists." });
                }

                // Chuyển đổi từ DTO sang entity và gán trạng thái
                Schedule s = _mapper.Map<Schedule>(scheduleDTO);

                // Thêm lịch vào cơ sở dữ liệu
                await _scheduleRepository.AddScheduleAsync(s);

                // Trả về phản hồi thành công với mã HTTP 201 (Created)
                return Ok(s);
            }
            catch (Exception ex)
            {
                // Trả về phản hồi lỗi với mã HTTP 400 (Bad Request)
                return BadRequest(new { message = ex.Message, details = ex.StackTrace });
            }
        }
        [HttpPut("EditSchedule")]
        public async Task<IActionResult> EditSchedule([FromBody] EditScheduleDTO editSchedule)
        {


            // Fetch the existing schedule from the repository
            var existingSchedule = await _scheduleRepository.GetScheduleByIdAsync(editSchedule.ScheduleId);

            if (existingSchedule == null)
            {
                return NotFound(new { message = "Schedule not found." }); // Return 404 if the schedule doesn't exist
            }


            // Update the properties of the existing schedule
            existingSchedule.ClassId = editSchedule.ClassId;
            existingSchedule.TeacherId = editSchedule.TeacherId;
            existingSchedule.CourseId = editSchedule.CourseId;
            existingSchedule.SubstituteTeacherId = editSchedule.SubstituteTeacherId;
            existingSchedule.Status = editSchedule.Status;
            existingSchedule.Room = editSchedule.Room;
            existingSchedule.TimeSlotId = editSchedule.TimeSlotId;
            existingSchedule.Date = editSchedule.Date;

            try
            {
                // Update the schedule in the repository and check rows affected
                var rowsAffected = await _scheduleRepository.UpdateScheduleAsync(existingSchedule);
                if (rowsAffected == 0)
                {
                    return StatusCode(500, new { message = "No changes were saved to the database. Please check the data." });
                }

                // Return a successful response
                return Ok(new { message = "Schedule updated successfully.", data = editSchedule });
            }
            catch (Exception ex)
            {
                // Log the exception and return a server error response
                return StatusCode(500, new { message = $"An error occurred while updating the schedule: {ex.Message}" });
            }
        }

        [HttpDelete("DeleteSchedule/{scheduleId}")]
        public async Task<IActionResult> DeleteSchedule(int scheduleId)
        {
            try
            {
                // Kiểm tra xem lịch có tồn tại không
                var schedule = await _scheduleRepository.GetScheduleByIdAsync(scheduleId);
                if (schedule == null)
                {
                    return NotFound(new { message = "Schedule not found." }); // Nếu không tìm thấy lịch, trả về 404
                }

                // Gọi repository để xóa lịch
                var rowsAffected = await _scheduleRepository.DeleteScheduleAsync(scheduleId);
                if (rowsAffected == 0)
                {
                    return StatusCode(500, new { message = "Failed to delete the schedule. No rows were affected." });
                }

                // Trả về phản hồi thành công
                return Ok(new { message = "Schedule deleted successfully.", scheduleId = scheduleId });
            }
            catch (Exception ex)
            {
                // Ghi log ngoại lệ nếu cần thiết
                // Trả về lỗi máy chủ nội bộ
                return StatusCode(500, new { message = $"An error occurred while deleting the schedule: {ex.Message}" });
            }
        }
        [HttpGet("GetSchedulesAsync")]
        public async Task<IActionResult> GetSchedulesAsync(DateTime date, int teacherId)
        {
            try
            {
                using (var context = new StudentAttendanceDBContext())
                {
                    var schedules = await context.Schedules
                        .Where(s =>
            (s.TeacherId == teacherId && s.SubstituteTeacherId == null) ||
            (s.SubstituteTeacherId != null && s.TeacherId != s.SubstituteTeacherId)
        )
                        .Select(s => new ScheduleListDTO
                        {
                            ScheduleId = s.ScheduleId,
                            ClassId = s.ClassId,
                            Room = s.Room,
                            TeacherId = s.TeacherId,
                            Date = s.Date,
                            TimeSlotId = s.TimeSlotId,
                            CourseId = s.CourseId,
                            SubstituteTeacherId = s.SubstituteTeacherId,
                            StartTime = s.TimeSlot.StartTime,
                            EndTime = s.TimeSlot.EndTime,
                            CourseCode = s.Course.CourseCode,
                            CourseName = s.Course.CourseName,
                            ClassCode = s.Class.ClassCode,
                            FullName = s.Teacher.FullName,
                            SubstituteTeacherFullName = s.SubstituteTeacher.FullName,
                            Status = s.Status
                        })
                        .OrderBy(x => x.TimeSlotId)
                        .ToListAsync();

                    return Ok(schedules);
                }
            }
            catch (Exception ex)
            {
                // Log lỗi hoặc thông báo lỗi
                return StatusCode(500, "Đã xảy ra lỗi trong quá trình xử lý.");
            }
        }

    }
}
