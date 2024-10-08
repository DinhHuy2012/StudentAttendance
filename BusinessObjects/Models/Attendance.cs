using System;
using System.Collections.Generic;

namespace BusinessObjects.Models
{
    public partial class Attendance
    {
        public int AttendanceId { get; set; }
        public int? EnrollmentId { get; set; }
        public int? ScheduleId { get; set; }
        public DateTime Date { get; set; }
        public string? Status { get; set; }
        public DateTime RecordedAt { get; set; }
        public string? Note { get; set; }

        public virtual Enrollment? Enrollment { get; set; }
        public virtual Schedule? Schedule { get; set; }
    }
}
