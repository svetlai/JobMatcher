namespace JobMatcher.Models
{
    public class Message
    {
        public int Id { get; set; }

        public string Sunject { get; set; }

        public string Content { get; set; }

        public int JobSeekerProfileId { get; set; }

        public virtual JobSeekerProfile FirstParticipant { get; set; }

        public int RecruiterProfileId { get; set; }

        public virtual RecruiterProfile SecondParticipant { get; set; }
    }
}
