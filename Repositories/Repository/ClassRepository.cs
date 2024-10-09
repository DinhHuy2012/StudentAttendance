using BusinessObjects.Models;
using DataAccess.DAO;
using Repositories.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories.Repository
{
    public class ClassRepository : IClassRepository
    {
        private readonly ClassDao _classDao;
        public ClassRepository(ClassDao classDao)
        {
            _classDao = classDao;
        }


        public async Task<Class?> GetClassByIdAsync(int id)
        {
            return await _classDao.GetClassByIdAsync(id);
        }

        public async Task<List<Class>> GetAllClassesAsync()
        {
            return await _classDao.GetAllClassesAsync();
        }



        public async Task AddClassAsync(Class newClass)
        {
            await _classDao.AddClassAsync(newClass);

        }

        public async Task UpdateClassAsync(Class updatedClass)
        {
            await _classDao.UpdateClassAsync(updatedClass);
        }

        public async Task DeleteClassAsync(int id)
        {
            await _classDao.DeleteClassAsync(id);

        }
        public async Task<Class> GetClassByClassCodeAsync(string ClassCode)
        {
            return await _classDao.GetClassByClassCodeAsync(ClassCode);
        }
    }
}
