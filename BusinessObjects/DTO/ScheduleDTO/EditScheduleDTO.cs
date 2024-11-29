using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.DTO.ScheduleDTO
{
    public class EditScheduleDTO
    {
        public int ScheduleId { get; set; }
        public int ClassId { get; set; }
        public string? Room { get; set; }
        public int TimeSlotId { get; set; }
        public int? TeacherId { get; set; }
        public DateTime Date { get; set; }
        public int? CourseId { get; set; }
        public int? SubstituteTeacherId { get; set; }
        public string? Status { get; set; }

    }
}
