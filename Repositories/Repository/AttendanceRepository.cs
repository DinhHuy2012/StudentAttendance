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
    public class AttendanceRepository : IAttendanceRepository
    {
        private readonly AttendanceDao _attendanceDao;
        public AttendanceRepository(AttendanceDao attendanceDao)
        {
            _attendanceDao = attendanceDao;
        }

        public async Task AddAttendancesAsync(int classId)
        {
            await _attendanceDao.AddAttendancesAsync(classId);
        }

        public async Task<IEnumerable<Attendance>> GetAllAttendancesAsync()
        {
            return await _attendanceDao.GetAllAsync(); 
        }
    }
}
