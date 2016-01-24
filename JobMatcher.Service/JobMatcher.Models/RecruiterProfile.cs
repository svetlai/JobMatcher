namespace JobMatcher.Models
{
using System.Collections.Generic;

    public class RecruiterProfile
    {
        public RecruiterProfile()
        {
            this.JobOffers = new HashSet<JobOffer>();
            this.SelectedJobSeekers = new HashSet<JobSeekerProfile>();
            this.Messages = new HashSet<Message>();
        }

        public int Id { get; set; }

        public string UserId { get; set; }

        public virtual User User { get; set; }

        public virtual ICollection<JobOffer> JobOffers { get; set; }

        public virtual ICollection<JobSeekerProfile> SelectedJobSeekers { get; set; }

        public virtual ICollection<Message> Messages { get; set; } 
    }
}
