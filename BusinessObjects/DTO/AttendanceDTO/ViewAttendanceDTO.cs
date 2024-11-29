using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.DTO.AttendanceDTO
{
    public class ViewAttendanceDTO
    {

        public string ClassCode { get; set; }
        public int StudentCode { get; set; }
        public string FullName{ get; set; }
        public string Avatar{ get; set; }
        public string Status{ get; set; }
        public string Note { get; set; }
        public string DepartmentName { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public int? StudentId { get; set; }
        public string TeacherName { get; set; }
        public int TimeSlotId { get; set; }
        public int ClassId { get; set; }
        public DateTime? Date { get; set; }
        public string? Room { get; set; }
        public string TearcherName { get; set; }
        public string SubstituteTeacherName { get; set; }
    }
}
