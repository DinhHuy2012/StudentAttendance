using BusinessObjects.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BusinessObjects.DTO.StudentDTO;

namespace BusinessObjects.DTO.ClassDTO
{
    public class ClassesDTO
    {
        public int ClassId { get; set; }
        public string ClassCode { get; set; } = null!;
        public string ClassName { get; set; } = null!;
        public string? Note { get; set; }
        public List<StudentsDTO> StudentNames { get; set; } = new List<StudentsDTO>();


    }
}