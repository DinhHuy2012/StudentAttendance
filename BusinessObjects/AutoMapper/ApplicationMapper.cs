using AutoMapper;
using BusinessObjects.DTO.ClassDTO;
using BusinessObjects.DTO.ClassDTO.ClassDTO;
using BusinessObjects.DTO.EnrollmentDto;
using BusinessObjects.DTO.StudentDTO;
using BusinessObjects.Models;


namespace StudentAttendance.AutoMapper
{
    public class ApplicationMapper : Profile
    {
        public ApplicationMapper()
        {
            CreateMap<Class, ClassesDTO>()

                .ForMember(dest => dest.StudentNames, otp => otp.MapFrom(src => src.Enrollments.Select(e => new StudentsDTO
                {
                    StudentId = e.Student.StudentId,  // Mã sinh viên
                    StudentCode = e.Student.StudentCode,  // Mã sinh viên
                    FullName = e.Student.FullName     // Tên sinh viên
                }).ToList())) // Lấy danh sách tên sinh viên

            .ReverseMap();
            CreateMap<Student, StudentsDTO>()
                .ForMember(dest => dest.DepartmentName, otp => otp.MapFrom(src => src.Department.DepartmentName))
                .ReverseMap();
            CreateMap<Student, AddStudentDTO>()
                .ReverseMap();
            CreateMap<Student, UpdateStudentDTO>()
               .ReverseMap();
            CreateMap<Enrollment, EnrollmentDTO>()
              .ReverseMap();

            CreateMap<Class, AllClassDTO>()
                .ReverseMap();
            CreateMap<Class, AddClassDTO>()
                .ReverseMap();
        }
    }
}