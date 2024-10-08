using System;
using System.Collections.Generic;

namespace BusinessObjects.Models
{
    public partial class Semester
    {
        public Semester()
        {
            Enrollments = new HashSet<Enrollment>();
        }

        public int SemesterId { get; set; }
        public string SemesterName { get; set; } = null!;
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public DateTime? CreatedAt { get; set; }

        public virtual ICollection<Enrollment> Enrollments { get; set; }
    }
}
