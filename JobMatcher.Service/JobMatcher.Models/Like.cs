using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using JobMatcher.Common.Contracts;

namespace JobMatcher.Models
{
    public class Like : IDeletable
    {
        [Key]
        public int Id { get; set; }

        [ForeignKey("RecruiterProfile")]
        public int RecruiterProfileId { get; set; }

        public virtual RecruiterProfile RecruiterProfile { get; set; }

        [ForeignKey("JobSeekerProfile")]
        public int JobSeekerProfileId { get; set; }

        public virtual JobSeekerProfile JobSeekerProfile { get; set; }

        [ForeignKey("JobOffer")]
        public int? JobOfferId { get; set; }

        public virtual JobOffer JobOffer { get; set; }

        public ProfileType LikeInitiatorType { get; set; }

        public DateTime CreatedOn { get; set; }

        public bool IsDeleted { get; set; }
    }
}