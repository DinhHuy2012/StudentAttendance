using BusinessObjects.DTO;
using BusinessObjects.DTO.StudentDTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories.Interface
{
    public interface IAuthService
	{
		Task<string> LoginAsync(UserLoginDTO loginDTO);
		Task<string> LoginByStudentAsync(StudentLoginDTO loginStudentDTO);
	}

}
