using System.ComponentModel.DataAnnotations.Schema;

namespace JobMatcher.Models
{
    public class Project
    {
        public int Id { get; set; }

        public string Title { get; set; }

        public string Description { get; set; }

        public string Url { get; set; }

        public virtual JobSeekerProfile JosSeekerProfile { get; set; }
    }
}
