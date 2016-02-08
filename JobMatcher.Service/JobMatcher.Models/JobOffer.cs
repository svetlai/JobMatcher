using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using JobMatcher.Common.Contracts;

namespace JobMatcher.Models
{
    using System.ComponentModel.DataAnnotations;

    public class JobOffer : IDeletable
    {
        public JobOffer()
        {
            this.InterestedJobSeekers = new HashSet<JobSeekerProfile>();
            //this.Likes = new HashSet<Like>();
            //this.DisLikes = new HashSet<Dislike>();
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

        public bool IsDeleted { get; set; }

        //public virtual ICollection<Like> Likes { get; set; }

        //public virtual ICollection<Dislike> DisLikes { get; set; }
    }
}
