using AutoMapper;
using BusinessObjects.DTO.AttendanceDTO;
using BusinessObjects.DTO.ClassDTO;
using BusinessObjects.DTO.ClassDTO.ClassDTO;
using BusinessObjects.DTO.EnrollmentDto;
using BusinessObjects.DTO.ScheduleDTO;
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
                    FullName = e.Student.FullName,   // Tên sinh viên
                    Avatar = e.Student.Avatar,
                    Email = e.Student.Email,
                    DepartmentName = e.Student.Department.DepartmentName

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
            CreateMap<Schedule, ScheduleListDTO>()
               .ForMember(dest => dest.CourseCode, otp => otp.MapFrom(src => src.Course.CourseCode))
               .ForMember(dest => dest.ClassCode, otp => otp.MapFrom(src => src.Class.ClassCode))
               .ForMember(dest => dest.FullName, otp => otp.MapFrom(src => src.Teacher.FullName))
               .ForMember(dest => dest.SubstituteTeacherFullName, otp => otp.MapFrom(src => src.SubstituteTeacher.FullName))

               .ForMember(dest => dest.StartTime, otp => otp.MapFrom(src => src.TimeSlot.StartTime))
               .ForMember(dest => dest.EndTime, otp => otp.MapFrom(src => src.TimeSlot.EndTime))
               .ReverseMap();

            CreateMap<Schedule, AddScheduleDTO>()
          .ReverseMap();
            CreateMap<Schedule, EditScheduleDTO>()
      .ReverseMap();

            CreateMap<Attendance, ViewAttendanceDTO>()
    .ReverseMap();

            CreateMap<Attendance, AttendanceUpdateDTO>()
.ReverseMap();
        }
    }
}