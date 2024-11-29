using System;
using System.Collections.Generic;

namespace BusinessObjects.Models
{
    public partial class Semester
    {
        public Semester()
        {
            Classes = new HashSet<Class>();
        }

        public int SemesterId { get; set; }
        public string SemesterName { get; set; } = null!;
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public DateTime? CreatedAt { get; set; }
        public string Status { get; set; }

        public virtual ICollection<Class> Classes { get; set; }
    }
}
