using System.ComponentModel.DataAnnotations;

namespace JobMatcher.Models
{
    using System.Collections.Generic;

    public class JobSeekerProfile
    {
        public JobSeekerProfile()
        {
            this.SelectedJobOffers = new HashSet<JobOffer>();
            this.Experience = new HashSet<Experience>();
            this.Education = new HashSet<Education>();
            this.Projects = new HashSet<Project>();
            this.Skills = new HashSet<Skill>();
            this.Messages = new HashSet<Message>();
            this.Matches = new HashSet<Match>();
            this.DislikedJobOffers = new HashSet<Dislike>();
            this.LikedJobOffers = new HashSet<Like>();
        }

        [Key]
        public int JobSeekerProfileId { get; set; }

        public string UserId { get; set; }

        public virtual User User { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string CurrentPosition { get; set; }

        public string Summary { get; set; }

        public virtual Image Image { get; set; }

        public virtual ICollection<Experience> Experience { get; set; }

        public virtual ICollection<Education> Education { get; set; }

        public virtual ICollection<Project> Projects { get; set; }

        public virtual ICollection<Skill> Skills { get; set; }

        public virtual ICollection<JobOffer> SelectedJobOffers { get; set; }

        public virtual ICollection<Match> Matches { get; set; }

        public virtual ICollection<Message> Messages { get; set; }

        public ICollection<Dislike> DislikedJobOffers { get; set; }

        public ICollection<Like> LikedJobOffers { get; set; }
    }
}
