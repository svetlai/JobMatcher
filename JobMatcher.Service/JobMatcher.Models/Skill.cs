using System.Collections.Generic;

namespace JobMatcher.Models
{
    using JobMatcher.Models.Enums;

    public class Skill
    {
        public Skill()
        {
            this.JosSeekerProfiles = new HashSet<JobSeekerProfile>();
        }

        public int Id { get; set; }

        public string Name { get; set; }

        public Level Level { get; set; }

        public virtual ICollection<JobSeekerProfile> JosSeekerProfiles { get; set; }
    }
}
