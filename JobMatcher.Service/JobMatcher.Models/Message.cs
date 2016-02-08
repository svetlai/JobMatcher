using JobMatcher.Common.Contracts;

namespace JobMatcher.Models
{
    public class Message : IDeletable
    {
        public int Id { get; set; }

        public string Subject { get; set; }

        public string Content { get; set; }

        public int JobSeekerProfileId { get; set; }

        public virtual JobSeekerProfile JobSeekerProfile { get; set; }

        public int RecruiterProfileId { get; set; }

        public virtual RecruiterProfile RecruiterProfile { get; set; }

        public int SenderId { get; set; }

        public bool IsDeleted { get; set; }
    }
}
