using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using JobMatcher.Common.Contracts;

namespace JobMatcher.Models
{
using System.Collections.Generic;

    public class RecruiterProfile : IDeletable
    {
        public RecruiterProfile()
        {
            this.JobOffers = new HashSet<JobOffer>();
            this.Matches = new HashSet<Match>();
            this.Messages = new HashSet<Message>();
            this.DislikedJobSeekers = new HashSet<Dislike>();
            this.LikedJobSeekers = new HashSet<Like>();
            this.MatchedJobSeekers = new HashSet<JobSeekerProfile>();
        }

        [Key]
        public int RecruiterProfileId { get; set; }

        public string UserId { get; set; }

        public virtual User User { get; set; }

        public virtual ICollection<JobOffer> JobOffers { get; set; }

        public virtual ICollection<Match> Matches { get; set; }

        public virtual ICollection<JobSeekerProfile> MatchedJobSeekers { get; set; }

        public virtual ICollection<Message> Messages { get; set; }

        public ICollection<Dislike> DislikedJobSeekers { get; set; }

        public ICollection<Like> LikedJobSeekers { get; set; }

        public bool IsDeleted { get; set; }
    }
}
