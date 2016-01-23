using JobMatcher.Models;

namespace JobMatcher.Data
{
    using System;
    using System.Collections.Generic;

    using JobMatcher.Data.Contracts;
    using JobMatcher.Data.Repositories;

    public class JobMatcherData : IJobMatcherData
    {
        private IJobMatcherDbContext db;
        private IDictionary<Type, object> repositories;

        public JobMatcherData(IJobMatcherDbContext db)
        {
            this.db = db;
            this.repositories = new Dictionary<Type, object>();
        }

        public IJobMatcherDbContext Db
        {
            get
            {
                return this.db;
            }
        }

        public IRepository<User> Users
        {
            get
            {
                return this.GetRepository<User>();
            }
        }

        public void SaveChanges()
        {
            this.db.SaveChanges();
        }

        private IRepository<T> GetRepository<T>() where T : class
        {
            var typeOfRepository = typeof(T);
            if (!this.repositories.ContainsKey(typeOfRepository))
            {
                var type = typeof(GenericRepository<T>);
                var newRepository = Activator.CreateInstance(type, this.db);

                this.repositories.Add(typeOfRepository, newRepository);
            }

            return (IRepository<T>)this.repositories[typeOfRepository];
        }
    }
}
