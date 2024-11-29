using System;
using System.Collections.Generic;

namespace BusinessObjects.Models
{
    public partial class Class
    {
        public Class()
        {
            Enrollments = new HashSet<Enrollment>();
            Schedules = new HashSet<Schedule>();
        }

        public int ClassId { get; set; }
        public string ClassCode { get; set; } = null!;
        public string ClassName { get; set; } = null!;
        public string? Note { get; set; }
        public int? SemesterId { get; set; }
        public virtual Semester? Semester { get; set; }
        public virtual ICollection<Enrollment> Enrollments { get; set; }
        public virtual ICollection<Schedule> Schedules { get; set; }
    }
}
