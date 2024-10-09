using BusinessObjects.Models;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Repositories.Interface
{
	public interface IStudentRepository
	{
		Task<List<Student>> GetAllStudentsAsync();
		Task<Student?> GetStudentByIdAsync(int id);
		Task AddStudentAsync(Student student);
		Task UpdateStudentAsync(Student student);
		Task DeleteStudentAsync(int id);
		Task<Student?> GetStudentByCodeAsync(int studentCode);
		Task<Student?> GetStudentByEmailAsync(string email);
		Task<Department?> GetDepartmentByIdAsync(int departmentId);
		Task<int> GetMaxStudentCodeAsync();
		Task<List<Student>> SearchStudents(string q);

    }
}
