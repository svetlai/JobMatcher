using System.ComponentModel.DataAnnotations.Schema;

namespace JobMatcher.Models
{
    using System;

    public class Experience
    {
        public int Id { get; set; }

        public string Position { get; set; }

        public int OrganizationId { get; set; }

        public virtual Organization Organization { get; set; }

        public Industry Industry { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime? EndDate { get; set; }

        public string Description { get; set; }

        public virtual JobSeekerProfile JosSeekerProfile { get; set; }
    }
}
