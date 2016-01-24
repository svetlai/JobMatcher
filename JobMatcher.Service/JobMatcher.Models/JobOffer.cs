using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace JobMatcher.Models
{
    using System.ComponentModel.DataAnnotations;

    public class JobOffer
    {
        public JobOffer()
        {
            this.InterestedJobSeekers = new HashSet<JobSeekerProfile>();
        }

        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(150)]
        public string Title { get; set; }

        [Required]
        [StringLength(5000)]
        public string Description { get; set; }
        
        [Required]
        public Industry Industry { get; set; }

        public int LocationId { get; set; }

        public virtual Location Location { get; set; }

        public WorkHours WorkHours { get; set; }

        public double Salary { get; set; }

        public int RecruiterProfileId { get; set; }

        public virtual RecruiterProfile RecruiterProfile { get; set; }

        public virtual ICollection<JobSeekerProfile> InterestedJobSeekers { get; set; }
    }
}
