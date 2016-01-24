using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace JobMatcher.Models
{
    public class Match
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("RecruiterProfile")]
        public int RecruiterProfileId { get; set; }

        public virtual RecruiterProfile RecruiterProfile { get; set; }

        [ForeignKey("JobSeekerProfile")]
        public int JobSeekerProfileId { get; set; }

        public virtual JobSeekerProfile JobSeekerProfile { get; set; }
    }
}
