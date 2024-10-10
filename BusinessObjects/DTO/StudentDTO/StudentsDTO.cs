using BusinessObjects.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.DTO.StudentDTO
{
    public class StudentsDTO
    {
       
        public int StudentId { get; set; }
        public int StudentCode { get; set; }
        public string DepartmentName { get; set; }
        public string FullName { get; set; } = null!;
        public DateTime? DateOfBirth { get; set; }
        public string Gender { get; set; } = null!;
        public string? Email { get; set; }
        public string? Password { get; set; }
        public string? PhoneNumber { get; set; }
        public string? Address { get; set; }
        public int? DepartmentId { get; set; }
        public string? Avatar { get; set; }
        public DateTime? CreatedAt { get; set; }


    }
}
