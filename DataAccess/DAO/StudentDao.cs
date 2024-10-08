using BusinessObjects.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DAO
{
	public class StudentDao
	{
		private readonly StudentAttendanceDBContext _context;

		public StudentDao(StudentAttendanceDBContext context)
		{
			_context = context;
		}

		public  async Task<List<Student>> GetProducts()
		{
			try
			{
				var listProducts = await _context.Students.Include(x => x.Department).ToListAsync();
				return listProducts;
			}
			catch (Exception ex)
			{
				throw new Exception(ex.Message);
			}
		}

		public async Task<Student?> GetStudentById(int id)
		{
			try
			{
				return await _context.Students.Include(x => x.Department)
											   .FirstOrDefaultAsync(s => s.StudentId == id);
			}
			catch (Exception ex)
			{
				throw new Exception($"Error fetching student by ID: {ex.Message}");
			}
		}
        public async Task AddStudent(Student student)
        {
            try
            {
                await _context.Students.AddAsync(student);
                await _context.SaveChangesAsync();
            }
            catch (Exception ex)
            {
                throw new Exception($"Error adding student: {ex.Message}");
            }
        }


        public async Task UpdateStudent(Student student)
		{
			try
			{
				_context.Students.Update(student);
				await _context.SaveChangesAsync();
			}
			catch (Exception ex)
			{
				throw new Exception($"Error updating student: {ex.Message}");
			}
		}

		public async Task DeleteStudent(int id)
		{
			try
			{
				var student = await _context.Students.FindAsync(id);
				if (student != null)
				{
					_context.Students.Remove(student);
					await _context.SaveChangesAsync();
				}
				else
				{
					throw new Exception("Student not found.");
				}
			}
			catch (Exception ex)
			{
				throw new Exception($"Error deleting student: {ex.Message}");
			}
		}
        public async Task<Student> GetStudentByCodeAsync(int studentCode)
        {
            return await _context.Students
                .FirstOrDefaultAsync(s => s.StudentCode == studentCode);
        }

        public async Task<Student> GetStudentByEmailAsync(string email)
        {
            return await _context.Students
                .FirstOrDefaultAsync(s => s.Email == email);
        }

        public async Task<Department?> GetDepartmentByIdAsync(int id)
        {
            try
            {
                return await _context.Departments
                                               .FirstOrDefaultAsync(s => s.DepartmentId == id);
            }
            catch (Exception ex)
            {
                throw new Exception($"Error fetching DepartmentId by ID: {ex.Message}");
            }
        }

        public async Task<int> GetMaxStudentCodeAsync()
        {
            return await _context.Students
                .OrderByDescending(s => s.StudentCode) // Sắp xếp theo StudentCode giảm dần
                .Select(s => s.StudentCode) // Chọn mã sinh viên
                .FirstOrDefaultAsync(); // Lấy mã lớn nhất
        }
    }
}
