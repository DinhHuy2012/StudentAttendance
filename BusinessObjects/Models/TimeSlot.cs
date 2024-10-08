using System;
using System.Collections.Generic;

namespace BusinessObjects.Models
{
    public partial class TimeSlot
    {
        public TimeSlot()
        {
            Schedules = new HashSet<Schedule>();
        }

        public int TimeSlotId { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan Endtime { get; set; }

        public virtual ICollection<Schedule> Schedules { get; set; }
    }
}
