using BusinessObjects.DTO;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DAO
{
    public class AuthDao
	{
		private readonly StudentAttendanceDBContext _context;

		public AuthDao(StudentAttendanceDBContext context)
		{
			_context = context;
		}
		public async Task<string> LoginAsync(TeacherLoginDTO loginDTO)
		{
			var user = await _context.Teachers.FirstOrDefaultAsync(u => u.Email == loginDTO.Email);
			if (user == null || !VerifyPasswordHash(loginDTO.Password, user.Password))
			{
				throw new UnauthorizedAccessException("Invalid Email or password.");
			}

			return "Token or user information : " + user.Email; // Trả về token hoặc thông tin người dùng
		}
		public async Task<string> LoginByStudentAsync(StudentLoginDTO loginStudentDTO)
		{
			var user = await _context.Students.FirstOrDefaultAsync(u => u.Email == loginStudentDTO.Email);
			if (user == null || !VerifyPasswordHash(loginStudentDTO.Password, user.Password))
			{
				throw new UnauthorizedAccessException("Invalid username or password.");
			}

			// Tạo JWT hoặc cookie nếu cần
			return "Token or user information : " + user.Email; // Trả về token hoặc thông tin người dùng
		}

		private bool VerifyPasswordHash(string password, string passwordHash)
		{
			// Logic để xác thực mật khẩu (bạn có thể sử dụng BCrypt, PBKDF2, v.v.)
			return passwordHash == password; // Chỉ là ví dụ, thay bằng logic xác thực thực tế
		}

	}
}
