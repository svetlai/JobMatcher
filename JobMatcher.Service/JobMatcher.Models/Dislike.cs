using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace JobMatcher.Models
{
    public class Dislike
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("RecruiterProfile")]
        public int RecruiterProfileId { get; set; }

        public virtual RecruiterProfile RecruiterProfile { get; set; }

        [ForeignKey("JobSeekerProfile")]
        public int JobSeekerProfileId { get; set; }

        public virtual JobSeekerProfile JobSeekerProfile { get; set; }

        public ProfileType DislikeInitiatorType { get; set; }

        public DateTime CreatedOn { get; set; }
    }
}
