using BusinessObjects.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repositories.Interface
{
    public interface IEnrollmentRepository
    {
        Task AddEnrollmentsAsync(List<Enrollment> enrollments);
        Task<Enrollment?> GetEnrollmentByClassAndStudentAsync(int classId, int studentId);
        Task SaveChangesAsync();

    }
}
