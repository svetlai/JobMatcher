namespace JobMatcher.Data.Contracts
{
    using JobMatcher.Data.Repositories;
    using JobMatcher.Models;

    public interface IJobMatcherData
    {
        IJobMatcherDbContext Db { get; }

        IRepository<User> Users { get; }

        void SaveChanges();
    }
}
