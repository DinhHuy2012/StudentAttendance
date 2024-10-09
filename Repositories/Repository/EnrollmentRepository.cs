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
    public class EnrollmentRepository : IEnrollmentRepository
    {
        private readonly EnrollmentDao _enrollmentDao;
        public EnrollmentRepository(EnrollmentDao enrollmentDao)
        {
            _enrollmentDao = enrollmentDao;
        }
        public async Task SaveChangesAsync()
        {
            await _enrollmentDao.SaveChangesAsync();
        }


        public async Task AddEnrollmentsAsync(List<Enrollment> enrollments)
        {
             await _enrollmentDao.AddEnrollmentsAsync(enrollments);
        }

        public async Task<Enrollment?> GetEnrollmentByClassAndStudentAsync(int classId, int studentId)
        {
            return await _enrollmentDao.GetEnrollmentByClassAndStudentAsync(classId, studentId);
        }

    }
}
