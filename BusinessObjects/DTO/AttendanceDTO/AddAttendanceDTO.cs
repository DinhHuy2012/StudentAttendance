using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.DTO.AttendanceDTO
{
    public class AddAttendanceDTO
    {
        public int AttendanceId { get; set; }
        public int? EnrollmentId { get; set; }
        public int? ScheduleId { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? Status { get; set; }
        public DateTime CreatedAt { get; set; }
        public string? Note { get; set; }

    }
}
