using BusinessObjects.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories.Interface
{
	public interface IClassRepository
	{
		Task<Class?> GetClassByIdAsync(int id);
		Task<List<Class>> GetAllClassesAsync();

		Task AddClassAsync(Class newClass);
		Task UpdateClassAsync(Class updatedClass);
		Task DeleteClassAsync(int id);
	}
}
