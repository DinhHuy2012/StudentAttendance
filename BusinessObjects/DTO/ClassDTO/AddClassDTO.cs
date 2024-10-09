using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessObjects.DTO.ClassDTO
{
    public class AddClassDTO
    {
        public string ClassCode { get; set; } = null!;
        public string ClassName { get; set; } = null!;
        public string? Note { get; set; }
    }
}
