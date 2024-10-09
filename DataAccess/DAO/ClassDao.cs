using BusinessObjects.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DAO
{
    public class ClassDao
    {
        private readonly StudentAttendanceDBContext _context;

        public ClassDao(StudentAttendanceDBContext context)
        {
            _context = context;
        }
        public async Task<Class?> GetClassByIdAsync(int id)
        {
            return await _context.Classes
                .Include(x => x.Enrollments)  // Include Enrollments
                .ThenInclude(e => e.Student)  // Include Student through Enrollments
                .FirstOrDefaultAsync(x => x.ClassId == id);  // Lọc theo ClassId
        }
        public async Task<List<Class>> GetAllClassesAsync()
        {
            return await _context.Classes.ToListAsync();
        }

        public async Task AddClassAsync(Class newClass)
        {
            await _context.Classes.AddAsync(newClass);
            await _context.SaveChangesAsync();
        }

        public async Task UpdateClassAsync(Class updatedClass)
        {
            _context.Classes.Update(updatedClass);
            await _context.SaveChangesAsync();
        }

        public async Task DeleteClassAsync(int id)
        {
            var existingClass = await GetClassByIdAsync(id);
            if (existingClass != null)
            {
                _context.Classes.Remove(existingClass);
                await _context.SaveChangesAsync();
            }
        }


        public async Task AssignStudentAsync(int classId, int studentId)
        {
            var enrollment = new Enrollment
            {
                ClassId = classId,
                StudentId = studentId,
                EnrolledAt = DateTime.Now
            };

            _context.Enrollments.Add(enrollment);
            await _context.SaveChangesAsync();
        }
        public async Task<Class> GetClassByClassCodeAsync(string ClassCode)
        {
            return await _context.Classes
                .FirstOrDefaultAsync(s => s.ClassCode == ClassCode);
        }

    }
}
