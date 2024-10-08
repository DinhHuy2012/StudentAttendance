using BusinessObjects.DTO;
using BusinessObjects.DTO.StudentDTO;
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
    public class AuthService : IAuthService
	{
		private readonly AuthDao _authDao;
		public AuthService(AuthDao authDao)
		{
			_authDao = authDao;
		}

		public async Task<string> LoginAsync(UserLoginDTO loginDTO)
		{
			// Gọi phương thức LoginAsync từ AuthDao và chờ kết quả
			return await _authDao.LoginAsync(loginDTO);
		}
		public async Task<string> LoginByStudentAsync(StudentLoginDTO loginStudentDTO)
		{
			// Gọi phương thức LoginAsync từ AuthDao và chờ kết quả
			return await _authDao.LoginByStudentAsync(loginStudentDTO);
		}

	}
}
