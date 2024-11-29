using System;
using System.Collections.Generic;
using System.Text.Json.Serialization;

namespace BusinessObjects.Models
{
    public partial class Teacher
    {
        public Teacher()
        {
            Schedules = new HashSet<Schedule>();
        }

        public int TeacherId { get; set; }
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string? Avatar { get; set; }
        public string FullName { get; set; } = null!;
        public string? Email { get; set; }
        public string Role { get; set; } = null!;
        public DateTime? CreatedAt { get; set; }

        [JsonIgnore]
        public virtual ICollection<Schedule> Schedules { get; set; }
    }
}
