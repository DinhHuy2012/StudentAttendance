using System;
using System.Collections.Generic;

namespace BusinessObjects.Models
{
    public partial class Student
    {
        public Student()
        {
            Enrollments = new HashSet<Enrollment>();
        }

        public int StudentId { get; set; }
        public int StudentCode { get; set; } 
        public string FullName { get; set; } = null!;
        public DateTime? DateOfBirth { get; set; }
        public string Gender { get; set; } = null!;
        public string? Email { get; set; }
        public string? Password { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Address { get; set; }
        public int? DepartmentId { get; set; }
        public string? Avatar { get; set; }
        public DateTime? CreatedAt { get; set; }

        public virtual Department? Department { get; set; }
        public virtual ICollection<Enrollment> Enrollments { get; set; }
    }
}
