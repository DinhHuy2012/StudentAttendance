using System;
using System.Collections.Generic;

namespace BusinessObjects.Models
{
    public partial class Course
    {
        public Course()
        {
            Schedules = new HashSet<Schedule>();
        }

        public int CourseId { get; set; }
        public string CourseCode { get; set; } = null!;
        public string CourseName { get; set; } = null!; 
        public string? Description { get; set; }
        public int? DepartmentId { get; set; }
        public DateTime? CreatedAt { get; set; }

        public virtual Department? Department { get; set; }
        public virtual ICollection<Schedule> Schedules { get; set; }
    }
}
