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
