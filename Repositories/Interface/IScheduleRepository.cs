using BusinessObjects.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories.Interface
{
    public interface IScheduleRepository
    {
        Task<IEnumerable<Schedule>> GetAllSchedulesAsync(); // Lấy tất cả lịch học
        Task<Schedule> GetScheduleByIdAsync(int scheduleId); // Lấy lịch học theo ID
        Task<Schedule> AddScheduleByClassIdAsync(int classId); // Lấy lịch học theo ID

        Task<IEnumerable<Schedule>> GetScheduleByClassIdAsync(int classId); // Lấy lịch học theo ID
        Task<IEnumerable<Schedule>> GetScheduleByClassAndCourse(int classId, int courseId); // Lấy lịch học theo ID
        Task<Schedule> GetScheduleByTeacherIdAsync(int teacherId); // Lấy lịch học theo ID
        Task AddScheduleAsync(Schedule schedule); // Thêm lịch học
        Task<int> UpdateScheduleAsync(Schedule schedule); // Cập nhật lịch học
        Task <int> DeleteScheduleAsync(int scheduleId); // Xóa lịch học
        Task<bool> IsScheduleConflictAsync(int timeSlotId,string? room, DateTime date);
        Task<bool> IsScheduleConflictScheduleAsync(int timeSlotId, string? room, DateTime date, int schedule);
    }

}
