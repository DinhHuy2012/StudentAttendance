using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.Extensions.Configuration;

namespace BusinessObjects.Models
{
    public partial class StudentAttendanceDBContext : DbContext
    {
        public StudentAttendanceDBContext()
        {
        }

        public StudentAttendanceDBContext(DbContextOptions<StudentAttendanceDBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Attendance> Attendances { get; set; } = null!;
        public virtual DbSet<Class> Classes { get; set; } = null!;
        public virtual DbSet<Course> Courses { get; set; } = null!;
        public virtual DbSet<Department> Departments { get; set; } = null!;
        public virtual DbSet<Enrollment> Enrollments { get; set; } = null!;
        public virtual DbSet<Schedule> Schedules { get; set; } = null!;
        public virtual DbSet<Semester> Semesters { get; set; } = null!;
        public virtual DbSet<Student> Students { get; set; } = null!;
        public virtual DbSet<Teacher> Teachers { get; set; } = null!;
        public virtual DbSet<TimeSlot> TimeSlots { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                var config = new ConfigurationBuilder().AddJsonFile("appsettings.json").Build();
                string ConnectionStr = config.GetConnectionString("DB");
                optionsBuilder.UseSqlServer(ConnectionStr);
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Attendance>(entity =>
            {
                entity.ToTable("Attendance");

                entity.HasIndex(e => new { e.EnrollmentId, e.ScheduleId, e.UpdatedAt }, "UQ_Attendance")
                    .IsUnique();

                entity.Property(e => e.AttendanceId).HasColumnName("AttendanceID");

                entity.Property(e => e.UpdatedAt).HasColumnType("datetime");

                entity.Property(e => e.EnrollmentId).HasColumnName("EnrollmentID");

                entity.Property(e => e.Note).HasMaxLength(50);

                entity.Property(e => e.CreatedAt)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.ScheduleId).HasColumnName("ScheduleID");

                entity.Property(e => e.Status)
                    .HasMaxLength(10)
                    .HasDefaultValueSql("(N'Future')");

                entity.HasOne(d => d.Enrollment)
                    .WithMany(p => p.Attendances)
                    .HasForeignKey(d => d.EnrollmentId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("FK__Attendanc__Enrol__1332DBDC");

                entity.HasOne(d => d.Schedule)
                    .WithMany(p => p.Attendances)
                    .HasForeignKey(d => d.ScheduleId)
                    .HasConstraintName("FK__Attendanc__Sched__14270015");
            });

       
            modelBuilder.Entity<Class>(entity =>
            {
                entity.Property(e => e.ClassId).HasColumnName("ClassID");

                entity.Property(e => e.ClassCode).HasMaxLength(20);

                entity.Property(e => e.ClassName).HasMaxLength(100);

                entity.Property(e => e.Note)
                    .HasMaxLength(50)
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.SemesterId).HasColumnName("SemesterID");

                entity.HasOne(d => d.Semester)
                    .WithMany(p => p.Classes)
                    .HasForeignKey(d => d.SemesterId)
                    .HasConstraintName("FK_Classes_Semesters");
            });

            modelBuilder.Entity<Course>(entity =>
            {
                entity.HasIndex(e => e.CourseCode, "UQ__Courses__FC00E000D16F3CA2")
                    .IsUnique();

                entity.HasIndex(e => e.DepartmentId, "idx_courses_departmentid");

                entity.Property(e => e.CourseId).HasColumnName("CourseID");

                entity.Property(e => e.CourseCode).HasMaxLength(20);

                entity.Property(e => e.CourseName).HasMaxLength(100);

                entity.Property(e => e.CreatedAt)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.DepartmentId).HasColumnName("DepartmentID");

                entity.HasOne(d => d.Department)
                    .WithMany(p => p.Courses)
                    .HasForeignKey(d => d.DepartmentId)
                    .OnDelete(DeleteBehavior.SetNull)
                    .HasConstraintName("FK__Courses__Departm__47DBAE45");
            });

            modelBuilder.Entity<Department>(entity =>
            {
                entity.HasIndex(e => e.DepartmentName, "UQ__Departme__D949CC345BE9D018")
                    .IsUnique();

                entity.Property(e => e.DepartmentId).HasColumnName("DepartmentID");

                entity.Property(e => e.CreatedAt)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.DepartmentName).HasMaxLength(100);
            });

            modelBuilder.Entity<Enrollment>(entity =>
            {
                entity.HasIndex(e => new { e.ClassId, e.StudentId }, "UQ_Enrollment")
                    .IsUnique();

                entity.HasIndex(e => e.ClassId, "idx_enrollments_classid");


                entity.HasIndex(e => e.StudentId, "idx_enrollments_studentid");

                entity.Property(e => e.EnrollmentId).HasColumnName("EnrollmentID");

                entity.Property(e => e.ClassId).HasColumnName("ClassID");

                entity.Property(e => e.CreatedAt)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.EnrolledAt)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");


                entity.Property(e => e.Status).HasMaxLength(50);

                entity.Property(e => e.StudentId).HasColumnName("StudentID");

                entity.HasOne(d => d.Class)
                    .WithMany(p => p.Enrollments)
                    .HasForeignKey(d => d.ClassId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("FK__Enrollmen__Class__5DCAEF64");

      

                entity.HasOne(d => d.Student)
                    .WithMany(p => p.Enrollments)
                    .HasForeignKey(d => d.StudentId)
                    .OnDelete(DeleteBehavior.Cascade)
                    .HasConstraintName("FK__Enrollmen__Stude__5EBF139D");
            });

            modelBuilder.Entity<Schedule>(entity =>
            {
                entity.HasIndex(e => e.ClassId, "idx_schedules_classid");

                entity.Property(e => e.ScheduleId).HasColumnName("ScheduleID");

                entity.Property(e => e.ClassId).HasColumnName("ClassID");

                entity.Property(e => e.CourseId).HasColumnName("CourseID");

                entity.Property(e => e.Date).HasColumnType("datetime");


                entity.Property(e => e.Room).HasMaxLength(50);
                entity.Property(e => e.Status).HasMaxLength(50);

                entity.Property(e => e.TeacherId).HasColumnName("TeacherID");

                entity.Property(e => e.TimeSlotId).HasColumnName("TimeSlotID");

                entity.HasOne(d => d.Class)
                    .WithMany(p => p.Schedules)
                    .HasForeignKey(d => d.ClassId)
                    .HasConstraintName("FK__Schedules__Class__5812160E");

                entity.HasOne(d => d.Course)
                    .WithMany(p => p.Schedules)
                    .HasForeignKey(d => d.CourseId)
                    .HasConstraintName("FK_Schedules_Courses");
                entity.HasOne(d => d.Teacher)
                    .WithMany(p => p.Schedules) // Giáo viên chính
                    .HasForeignKey(d => d.TeacherId)
                    .HasConstraintName("FK_Schedules_Teachers");

                entity.HasOne(d => d.SubstituteTeacher)
                    .WithMany() // Không cần navigation property trong Teacher cho giáo viên dạy thay
                    .HasForeignKey(d => d.SubstituteTeacherId)
                    .HasConstraintName("FK_Schedules_SubstituteTeachers");

                entity.HasOne(d => d.TimeSlot)
                    .WithMany(p => p.Schedules)
                    .HasForeignKey(d => d.TimeSlotId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Schedules_TimeSlots");
            });

            modelBuilder.Entity<Semester>(entity =>
            {
                entity.HasIndex(e => e.SemesterName, "UQ__Semester__7B4EBE0F9312E74C")
                    .IsUnique();

                entity.Property(e => e.SemesterId).HasColumnName("SemesterID");

                entity.Property(e => e.CreatedAt)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.EndDate).HasColumnType("date");

                entity.Property(e => e.SemesterName).HasMaxLength(50);

                entity.Property(e => e.StartDate).HasColumnType("date");
                entity.Property(e => e.Status).HasMaxLength(50);

            });

            modelBuilder.Entity<Student>(entity =>
            {
                entity.HasIndex(e => e.StudentCode, "UQ__Students__1FC886040E94B7BF")
                    .IsUnique();

                entity.HasIndex(e => e.Email, "UQ__Students__A9D10534612CEFAB")
                    .IsUnique();

                entity.HasIndex(e => e.DepartmentId, "idx_students_departmentid");

                entity.Property(e => e.StudentId).HasColumnName("StudentID");

                entity.Property(e => e.Address).HasMaxLength(255);

                entity.Property(e => e.Avatar)
                    .HasMaxLength(100)
                    .IsFixedLength();

                entity.Property(e => e.CreatedAt)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.DateOfBirth).HasColumnType("date");

                entity.Property(e => e.DepartmentId).HasColumnName("DepartmentID");

                entity.Property(e => e.Email).HasMaxLength(100);

                entity.Property(e => e.FullName).HasMaxLength(100);

                entity.Property(e => e.Gender).HasMaxLength(10);

                entity.Property(e => e.Password).HasMaxLength(32);

                entity.Property(e => e.PhoneNumber).HasMaxLength(20);

                entity.Property(e => e.StudentCode).HasMaxLength(20);

                entity.HasOne(d => d.Department)
                    .WithMany(p => p.Students)
                    .HasForeignKey(d => d.DepartmentId)
                    .OnDelete(DeleteBehavior.SetNull)
                    .HasConstraintName("FK__Students__Depart__4316F928");
            });

            modelBuilder.Entity<Teacher>(entity =>
            {
                entity.HasIndex(e => e.Username, "UQ__Users__536C85E4856C1F7A")
                    .IsUnique();

                entity.Property(e => e.TeacherId).HasColumnName("TeacherID");

                entity.Property(e => e.Avatar)
                    .HasMaxLength(10)
                    .IsFixedLength();

                entity.Property(e => e.CreatedAt)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Email)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.FullName).HasMaxLength(100);

                entity.Property(e => e.Password).HasMaxLength(255);

                entity.Property(e => e.Role).HasMaxLength(10);

                entity.Property(e => e.Username).HasMaxLength(50);
            });

            modelBuilder.Entity<TimeSlot>(entity =>
            {
                entity.Property(e => e.TimeSlotId)
                    .ValueGeneratedNever()
                    .HasColumnName("TimeSlotID");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
