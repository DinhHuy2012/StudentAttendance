using BusinessObjects.Models;
using DataAccess.DAO;
using Repositories.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories.Repository
{
    public class ScheduleRepository : IScheduleRepository
    {
        private readonly ScheduleDao _scheduleDao;
        public ScheduleRepository(ScheduleDao scheduleDao)
        {
            _scheduleDao = scheduleDao;
        }


        public async Task<IEnumerable<Schedule>> GetAllSchedulesAsync()
        {
            return await _scheduleDao.GetAllSchedulesAsync();
        }

        public async Task<Schedule> GetScheduleByIdAsync(int scheduleId)
        {
            return await _scheduleDao.GetScheduleByIdAsync(scheduleId);
        }
        public async Task<Schedule> AddScheduleByClassIdAsync(int classId)
        {
            return await _scheduleDao.AddScheduleByClassIdAsync(classId);
        }
        public async Task AddScheduleAsync(Schedule schedule)
        {
            await _scheduleDao.AddScheduleAsync(schedule);
        }

        public async Task<int> UpdateScheduleAsync(Schedule schedule)
        {
            return await _scheduleDao.UpdateScheduleAsync(schedule);

        }

        public async Task<int> DeleteScheduleAsync(int scheduleId)
        {
            var schedule = await GetScheduleByIdAsync(scheduleId);

            return await _scheduleDao.DeleteScheduleAsync(schedule.ScheduleId);

        }


        public async Task<IEnumerable<Schedule>> GetScheduleByClassIdAsync(int classId)
        {
            return await _scheduleDao.GetScheduleByClassIdAsync(classId);
        }
        public async Task<IEnumerable<Schedule>> GetScheduleByClassAndCourse(int classId, int courseId)
        {
            return await _scheduleDao.GetScheduleByClassAndCourse(classId, courseId);
        }
        public async Task<Schedule> GetScheduleByTeacherIdAsync(int teacherId)
        {
            return await _scheduleDao.GetScheduleByTeacherIdAsync(teacherId);
        }

        public async Task<bool> IsScheduleConflictAsync(int timeSlotId, string? room, DateTime date)
        {
            return await _scheduleDao.IsScheduleConflictAsync(timeSlotId, room, date);
        }
        public async Task<bool> IsScheduleConflictScheduleAsync(int timeSlotId, string? room, DateTime date, int schedule)
        {
            return await _scheduleDao.IsScheduleConflictScheduleAsync(timeSlotId, room, date, schedule);
        }

    }
}
