using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.DTO.ReportDTO
{
    public class CourseClass
    {
        public int ClassId { get; set; }    
        public string ClassCode { get; set; }
        public int? SemesterId { get; set; }
        public int? CourseId { get; set; }
        public string CourseCode { get;set; }
        public string CourseName { get; set; }

    }
}
