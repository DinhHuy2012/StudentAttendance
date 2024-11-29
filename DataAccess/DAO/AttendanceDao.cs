using BusinessObjects.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DAO
{
    public class AttendanceDao
    {
        private readonly StudentAttendanceDBContext _context;

        public AttendanceDao(StudentAttendanceDBContext context)
        {
            _context = context;
        }
        public async Task<IEnumerable<Attendance>> GetAllAsync()
        {
            return await _context.Attendances.ToListAsync();
        }

        public async Task AddAttendancesAsync(int classId)
        {
            // Kiểm tra xem có Enrollment hoặc Schedule nào thỏa mãn điều kiện không
            var enrollmentExists = _context.Enrollments.Any(e => e.ClassId == classId);
            var scheduleExists = _context.Schedules.Any(s => s.ClassId == classId);

            if (!enrollmentExists || !scheduleExists)
            {
                // Ghi log hoặc thực hiện hành động khác để biết lý do cụ thể
                throw new Exception("Không có Enrollment hoặc Schedule nào thỏa mãn điều kiện.");
            }

            // Lấy danh sách các Attendance chưa tồn tại
            var attendanceList = (from e in _context.Enrollments
                                  join s in _context.Schedules on e.ClassId equals s.ClassId
                                  where s.ClassId == classId
                                  && !_context.Attendances.Any(a => a.EnrollmentId == e.EnrollmentId && a.ScheduleId == s.ScheduleId)
                                  select new Attendance
                                  {
                                      EnrollmentId = e.EnrollmentId,
                                      ScheduleId = s.ScheduleId,
                                      Status = "Future",
                                      CreatedAt = DateTime.Now
                                  }).ToList();

            if (attendanceList.Count > 0)
            {
                // Thêm các Attendance chưa tồn tại vào cơ sở dữ liệu
                await _context.Attendances.AddRangeAsync(attendanceList);
                await _context.SaveChangesAsync();
            }
            else
            {
                // Ghi log nếu tất cả các bản ghi đã tồn tại và không có bản ghi nào cần thêm
                throw new Exception("Không có bản ghi nào cần thêm mới. Có thể tất cả các bản ghi đã tồn tại trong hệ thống.");
            }
        }
    }
    }
