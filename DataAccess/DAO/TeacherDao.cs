using BusinessObjects.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DAO
{
    public class TeacherDao
    {
        private readonly StudentAttendanceDBContext _context;

        public TeacherDao(StudentAttendanceDBContext context)
        {
            _context = context;
        }
        public async Task<Teacher> GetTeacherByEmailAsync(string email)
        {
            return await _context.Teachers
                .FirstOrDefaultAsync(s => s.Email == email);
        }

    }
}
