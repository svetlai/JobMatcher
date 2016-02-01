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

        public IRepository<Education> Eductaion
        {
            get
            {
                return this.GetRepository<Education>();
            }
        }

        public IRepository<Experience> Experience
        {
            get
            {
                return this.GetRepository<Experience>();
            }
        }

        public IRepository<JobOffer> JobOffers
        {
            get
            {
                return this.GetRepository<JobOffer>();
            }
        }

        public IRepository<JobSeekerProfile> JobSeekerProfiles
        {
            get
            {
                return this.GetRepository<JobSeekerProfile>();
            }
        }

        public IRepository<Location> Locations
        {
            get
            {
                return this.GetRepository<Location>();
            }
        }

        public IRepository<Organization> Organizations
        {
            get
            {
                return this.GetRepository<Organization>();
            }
        }

        public IRepository<Project> Projects
        {
            get
            {
                return this.GetRepository<Project>();
            }
        }

        public IRepository<Skill> Skills
        {
            get
            {
                return this.GetRepository<Skill>();
            }
        }

        public IRepository<RecruiterProfile> RecruiterProfiles
        {
            get
            {
                return this.GetRepository<RecruiterProfile>();
            }
        }

        public IRepository<Like> Likes
        {
            get
            {
                return this.GetRepository<Like>();
            }
        }

        public IRepository<Dislike> Dislikes
        {
            get
            {
                return this.GetRepository<Dislike>();
            }
        }

        public IRepository<Match> Matches
        {
            get
            {
                return this.GetRepository<Match>();
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
