using BusinessObjects.Models;
using DataAccess.DAO;
using Microsoft.EntityFrameworkCore;
using Repositories.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories.Repository
{
	public class StudentRepository : IStudentRepository
	{
		private readonly StudentDao _studentDao;
		public StudentRepository(StudentDao studentDao)
		{
			_studentDao = studentDao;
		}



		public async Task<List<Student>> GetAllStudentsAsync() // Khớp với giao diện
		{
			return await _studentDao.GetProducts(); // Giả sử phương thức này đã được triển khai trong StudentDao
		}

		public async Task<Student?> GetStudentByIdAsync(int id) // Khớp với giao diện
		{
			return await _studentDao.GetStudentById(id); // Giả sử phương thức này đã được triển khai trong StudentDao
		}
		public async Task AddStudentAsync(Student student) // Khớp với giao diện
		{
			await _studentDao.AddStudent(student); // Giả sử phương thức này đã được triển khai trong StudentDao
		}

		public async Task UpdateStudentAsync(Student student) // Khớp với giao diện
		{
			await _studentDao.UpdateStudent(student); // Giả sử phương thức này đã được triển khai trong StudentDao
		}

		public async Task DeleteStudentAsync(int id) // Khớp với giao diện
		{
			await _studentDao.DeleteStudent(id); // Giả sử phương thức này đã được triển khai trong StudentDao
		}

        public async Task<Student> GetStudentByCodeAsync(int studentCode)
        {
            return await _studentDao.GetStudentByCodeAsync(studentCode);
        }

        public async Task<Student> GetStudentByEmailAsync(string email)
        {
            return await _studentDao.GetStudentByEmailAsync(email);

        }
        public async Task<Department?> GetDepartmentByIdAsync(int id) // Khớp với giao diện
        {
            return await _studentDao.GetDepartmentByIdAsync(id); // Giả sử phương thức này đã được triển khai trong StudentDao
        }
        public async Task<int> GetMaxStudentCodeAsync()
        {
			return await _studentDao.GetMaxStudentCodeAsync();
        }

      
    }
}
