using BusinessObjects.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DAO
{
   public  class EnrollmentDao
    {
        private readonly StudentAttendanceDBContext _context;

        public EnrollmentDao(StudentAttendanceDBContext context)
        {
            _context = context;
        }

        public async Task AddEnrollmentsAsync(List<Enrollment> enrollments)
        {
            _context.Enrollments.AddRange(enrollments);
            await _context.SaveChangesAsync();
        }

        public async Task<Enrollment?> GetEnrollmentByClassAndStudentAsync(int classId, int studentId)
        {
            return await _context.Enrollments
                .FirstOrDefaultAsync(e => e.ClassId == classId && e.StudentId == studentId);
        }
        public async Task SaveChangesAsync()
        {
            await _context.SaveChangesAsync();
        }

    }
}
