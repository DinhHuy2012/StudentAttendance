using System;
using System.Collections.Generic;

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
        public string DayOfWeek { get; set; } = null!;
        public string? Room { get; set; }
        public int TimeSlotId { get; set; }
        public int? TeacherId { get; set; }
        public DateTime? Date { get; set; }
        public int? CourseId { get; set; }

        public virtual Class Class { get; set; } = null!;
        public virtual Course? Course { get; set; }
        public virtual Teacher? Teacher { get; set; }
        public virtual TimeSlot TimeSlot { get; set; } = null!;
        public virtual ICollection<Attendance> Attendances { get; set; }
    }
}
