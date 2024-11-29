using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.DTO.AttendanceDTO
{
    public class AttendanceUpdateDTO
    {
        public int StudentId { get; set; }
        public string Status { get; set; } // "Present" or "Absent"
        public string? Note { get; set; }
    }

}
