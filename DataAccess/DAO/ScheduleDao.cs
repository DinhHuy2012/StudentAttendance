using BusinessObjects.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DAO
{
    public class ScheduleDao
    {
        private readonly StudentAttendanceDBContext _context;

        public ScheduleDao(StudentAttendanceDBContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Schedule>> GetAllSchedulesAsync()
        {
            return await _context.Schedules
                .Include(s => s.Class)
                .Include(s => s.Teacher)
                .Include(s => s.Course)
                .Include(s => s.TimeSlot)
                .ToListAsync();
        }
        public async Task<IEnumerable<Schedule>> GetScheduleByClassIdAsync(int classId)
        {
            return await _context.Schedules
                 .Include(s => s.Class)
                .Include(s => s.Teacher)
                .Include (s => s.SubstituteTeacher)
                .Include(s => s.Course)
                .Include(s => s.TimeSlot)
                .Where(s => s.ClassId == classId)

                .ToListAsync();
        }
        public async Task<IEnumerable<Schedule>> GetScheduleByClassAndCourse(int classId, int courseId)
        {
            return await _context.Schedules
                 .Include(s => s.Class)
                .Include(s => s.Teacher)
                .Include(s => s.SubstituteTeacher)
                .Include(s => s.Course)
                .Include(s => s.TimeSlot)
                .Where(s => s.ClassId == classId && s.CourseId == courseId)
                .OrderBy(s => s.Date)

                .ToListAsync();
        }

        public async Task<bool> IsScheduleConflictAsync( int timeSlotId, string room, DateTime date)
        {
            return await _context.Schedules.AnyAsync(s =>
                s.TimeSlotId == timeSlotId &&
                s.Room == room &&
                s.Date == date);
        }

        public async Task<bool> IsScheduleConflictScheduleAsync(int timeSlotId, string room, DateTime date,int schedule)
        {
            return await _context.Schedules.AnyAsync(s =>
                s.TimeSlotId == timeSlotId &&
                s.Room == room &&
                s.Date == date &&
                s.ScheduleId == schedule);
        }

        public async Task<Schedule> AddScheduleByClassIdAsync(int classId)
        {
            return await _context.Schedules
                .Include(s => s.Class)
                .Include(s => s.Teacher)
                .Include(s => s.Course)
                .Include(s => s.TimeSlot)
                .FirstOrDefaultAsync(s => s.ClassId == classId);
        }
        public async Task<Schedule> GetScheduleByIdAsync(int scheduleId)
        {
            return await _context.Schedules
                .Include(s => s.Class)
                .Include(s => s.Teacher)
                .Include(s => s.Course)
                .Include(s => s.TimeSlot)
                .FirstOrDefaultAsync(s => s.ScheduleId == scheduleId);
        }
  

        public async Task<Schedule> GetScheduleByTeacherIdAsync(int teacherId)
        {
            return await _context.Schedules
                .Include(s => s.Class)
                .Include(s => s.Teacher)
                .Include(s => s.Course)
                .Include(s => s.TimeSlot)
                .FirstOrDefaultAsync(s => s.TeacherId == teacherId);
        }

        public async Task AddScheduleAsync(Schedule schedule)
        {
            await _context.Schedules.AddAsync(schedule);
            await _context.SaveChangesAsync();
        }

        public async Task<int> UpdateScheduleAsync(Schedule schedule)
        {
            _context.Schedules.Update(schedule);
            return await _context.SaveChangesAsync(); // Returns the number of affected rows
        }
        public async Task<int> DeleteScheduleAsync(int scheduleId)
        {
            var schedule = await GetScheduleByIdAsync(scheduleId);
            if (schedule != null)
            {
                 _context.Schedules.Remove(schedule);

            }
            return await _context.SaveChangesAsync();

        }
    }
}
