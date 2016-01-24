using System.ComponentModel.DataAnnotations;

namespace JobMatcher.Models
{
using System.Collections.Generic;

    public class RecruiterProfile
    {
        public RecruiterProfile()
        {
            this.JobOffers = new HashSet<JobOffer>();
            this.Matches = new HashSet<Match>();
            this.Messages = new HashSet<Message>();
        }

        [Key]
        public int RecruiterProfileId { get; set; }

        public string UserId { get; set; }

        public virtual User User { get; set; }

        public virtual ICollection<JobOffer> JobOffers { get; set; }

        public virtual ICollection<Match> Matches { get; set; }

        public virtual ICollection<Message> Messages { get; set; } 
    }
}
