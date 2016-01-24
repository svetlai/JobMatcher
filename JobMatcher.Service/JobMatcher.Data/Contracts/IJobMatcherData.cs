namespace JobMatcher.Data.Contracts
{
    using JobMatcher.Data.Repositories;
    using JobMatcher.Models;

    public interface IJobMatcherData
    {
        IJobMatcherDbContext Db { get; }

        IRepository<User> Users { get; }

        IRepository<Education> Eductaion { get; }

        IRepository<Experience> Experience { get; }

        IRepository<JobOffer> JobOffers { get; }

        IRepository<JobSeekerProfile> JobSeekerProfiles { get; }

        IRepository<Location> Locations { get; }

        IRepository<Organization> Organizations { get; }

        IRepository<Project> Projects { get; }

        IRepository<Skill> Skills { get; }

        IRepository<RecruiterProfile> RecruiterProfiles { get; }

        IRepository<Match> Matches { get; }

        void SaveChanges();
    }
}
