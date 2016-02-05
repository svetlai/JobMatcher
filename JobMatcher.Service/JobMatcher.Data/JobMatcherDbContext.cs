namespace JobMatcher.Data
{
    using System.Data.Entity;

    using Microsoft.AspNet.Identity.EntityFramework;

    using JobMatcher.Models;
    using JobMatcher.Data.Migrations;
    using JobMatcher.Data.Contracts;

    public class JobMatcherDbContext : IdentityDbContext<User>, IJobMatcherDbContext
    {
        public JobMatcherDbContext()
            : base("DefaultConnection", throwIfV1Schema: false)
        {
            Database.SetInitializer(new MigrateDatabaseToLatestVersion<JobMatcherDbContext, Configuration>());
        }

        public IDbSet<Education> Eductaion { get; set; }

        public IDbSet<Experience> Experience { get; set; }

        public IDbSet<JobOffer> JobOffers { get; set; }

        public IDbSet<JobSeekerProfile> JobSeekerProfiles { get; set; }

        public IDbSet<Location> Locations { get; set; }

        public IDbSet<Organization> Organizations { get; set; }

        public IDbSet<Project> Projects { get; set; }

        public IDbSet<Skill> Skills { get; set; }

        public IDbSet<RecruiterProfile> RecruiterProfiles { get; set; }
        
        public IDbSet<Match> Matches { get; set; }

        public IDbSet<Like> Likes { get; set; }

        public IDbSet<Dislike> Dislikes { get; set; }

        public IDbSet<Message> Messages { get; set; }

        public static JobMatcherDbContext Create()
        {
            return new JobMatcherDbContext();
        }

        IDbSet<T> IJobMatcherDbContext.Set<T>()
        {
            return base.Set<T>();
        }
    }
}
