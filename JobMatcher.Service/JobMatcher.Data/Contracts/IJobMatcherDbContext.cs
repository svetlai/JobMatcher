namespace JobMatcher.Data.Contracts
{
    using System.Data.Entity;

    public interface IJobMatcherDbContext
    {
        new IDbSet<T> Set<T>() where T : class;

        int SaveChanges();
    }
}
