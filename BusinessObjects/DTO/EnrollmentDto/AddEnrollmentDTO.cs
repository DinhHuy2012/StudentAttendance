using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.DTO.EnrollmentDto
{
    public class AddEnrollmentDTO
    {
        public int ClassId { get; set; }
        public List<int> StudentIds { get; set; } = new List<int>();
        public string? Status { get; set; }
    }
}

