using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.DTO.ReportDTO
{
    public class ClassSchedule
    {
        public int ClassID { get; set; }
        public string ClassCode { get; set; }
        public int SemesterID { get; set; }
        public string SemesterName { get; set; }
        public string Status { get; set; }
        public int CourseID { get; set; }
        public string CourseCode { get; set; }
        public string CourseName { get; set; }


        public int ScheduleID { get; set; }
        public string Room { get; set; }
        public DateTime Date { get; set; }
        public int TimeSlotID { get; set; }
        public int TeacherID { get; set; }
        public string AttendanceStatus { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
        public string? Note { get; set; }
        public string TeacherName { get; set; }
    }
    }

