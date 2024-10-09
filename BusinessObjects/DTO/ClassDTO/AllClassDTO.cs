using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.DTO.ClassDTO.ClassDTO
{

    public class AllClassDTO
    {
        public int ClassId { get; set; }
        public string ClassCode { get; set; } = null!;
        public string ClassName { get; set; } = null!;
        public string? Note { get; set; }
    }
}
