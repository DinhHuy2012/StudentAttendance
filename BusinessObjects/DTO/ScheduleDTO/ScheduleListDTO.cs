using BusinessObjects.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.DTO.ScheduleDTO
{
    public class ScheduleListDTO
    {
        public int ScheduleId { get; set; }
        public int ClassId { get; set; }
        public string ClassCode { get; set; }
        public string? Room { get; set; }
        public int TimeSlotId { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
        public int? TeacherId { get; set; }
        public string FullName { get; set; }
        public DateTime? Date { get; set; }
        public int? CourseId { get; set; }
        public string CourseCode { get; set; }
        public string CourseName { get; set; }
        public int? SubstituteTeacherId { get; set; }
        public string? Status { get; set; } 
        public string? SubstituteTeacherFullName { get; set; }



    }
}
