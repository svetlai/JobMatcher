using System.ComponentModel.DataAnnotations.Schema;
using JobMatcher.Common.Contracts;

namespace JobMatcher.Models
{
    public class Project : IDeletable
    {
        public int Id { get; set; }

        public string Title { get; set; }

        public string Description { get; set; }

        public string Url { get; set; }

        public virtual JobSeekerProfile JosSeekerProfile { get; set; }

        public bool IsDeleted { get; set; }
    }
}
