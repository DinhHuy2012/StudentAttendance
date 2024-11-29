using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.DTO.AttendanceDTO
{
    public class ViewAllAttendanceStudentDTO
    {
      
            public int StudentCode { get; set; }
            public string FullName { get; set; }
            public string DepartmentName { get; set; }
            public string Status { get; set; }
            public int? StudentId { get; set; }
            public int TotalSessions { get; set; }
            public int RowNumber { get; set; }
            public int  AbsentSessions { get; set; }
            public double AbsentPercentage { get; set; }
            public DateTime? Date { get; set; }


       
    }
}
