using System;
using System.Collections.Generic;

namespace BusinessObjects.Models
{
    public partial class Department
    {
        public Department()
        {
            Courses = new HashSet<Course>();
            Students = new HashSet<Student>();
        }

        public int DepartmentId { get; set; }
        public string DepartmentName { get; set; } = null!;
        public string? Description { get; set; }
        public DateTime? CreatedAt { get; set; }

        public virtual ICollection<Course> Courses { get; set; }
        public virtual ICollection<Student> Students { get; set; }
    }
}
