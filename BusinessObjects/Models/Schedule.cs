using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace BusinessObjects.Models
{
    public partial class Schedule
    {
        public Schedule()
        {
            Attendances = new HashSet<Attendance>();
        }

        public int ScheduleId { get; set; }
        public int ClassId { get; set; }
        public string? Room { get; set; }
        public int TimeSlotId { get; set; }
        public int? TeacherId { get; set; }
        public DateTime? Date { get; set; }
        public int? CourseId { get; set; }
        public int? SubstituteTeacherId { get; set;}
        public string? Status { get; set; }

        public virtual Class Class { get; set; } = null!;

        public virtual Course? Course { get; set; }
        public virtual Teacher? Teacher { get; set; }

        public virtual TimeSlot TimeSlot { get; set; } = null!;
        public virtual ICollection<Attendance> Attendances { get; set; }
        public virtual Teacher? SubstituteTeacher { get; set; }

      
    }
}
