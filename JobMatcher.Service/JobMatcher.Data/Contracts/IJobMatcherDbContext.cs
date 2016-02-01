using System;
using JobMatcher.Models;

namespace JobMatcher.Data.Contracts
{
    using System.Data.Entity;

    public interface IJobMatcherDbContext : IDisposable
    {
        new IDbSet<T> Set<T>() where T : class;

        IDbSet<Education> Eductaion { get; set; }

        IDbSet<Experience> Experience { get; set; }

        IDbSet<JobOffer> JobOffers { get; set; }

        IDbSet<JobSeekerProfile> JobSeekerProfiles { get; set; }

        IDbSet<Location> Locations { get; set; }

        IDbSet<Organization> Organizations { get; set; }

        IDbSet<Project> Projects { get; set; }

        IDbSet<Skill> Skills { get; set; }

        IDbSet<RecruiterProfile> RecruiterProfiles { get; set; }

        IDbSet<Match> Matches { get; set; }

        IDbSet<Like> Likes { get; set; }

        IDbSet<Dislike> Dislikes { get; set; }


        int SaveChanges();
    }
}
