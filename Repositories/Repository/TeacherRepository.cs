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
    public class TeacherRepository : ITeacherRepository
    {
        private readonly TeacherDao _teacherDao;
        public TeacherRepository(TeacherDao teacherDao)
        {
            _teacherDao = teacherDao;
        }
        public async Task<Teacher?> GetTeacherByEmailAsync(string email)
        {
            return await _teacherDao.GetTeacherByEmailAsync(email);
        }
    }
}
