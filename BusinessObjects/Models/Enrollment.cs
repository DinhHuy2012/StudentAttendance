using System;
using System.Collections.Generic;

namespace BusinessObjects.Models
{
    public partial class Enrollment
    {
        public Enrollment()
        {
            Attendances = new HashSet<Attendance>();
        }

        public int EnrollmentId { get; set; }
        public int? ClassId { get; set; }
        public int? StudentId { get; set; }
        public string? Status { get; set; }
        public int? SemesterId { get; set; }
        public DateTime? EnrolledAt { get; set; }
        public DateTime? CreatedAt { get; set; }

        public virtual Class? Class { get; set; }
        public virtual Semester? Semester { get; set; }
        public virtual Student? Student { get; set; }
        public virtual ICollection<Attendance> Attendances { get; set; }
    }
}
