namespace JobMatcher.Data.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    internal sealed class Configuration : DbMigrationsConfiguration<JobMatcherDbContext>
    {
        private DataSeeder seeder;

        public Configuration()
        {
            AutomaticMigrationsEnabled = true;
            AutomaticMigrationDataLossAllowed = true;
            this.seeder = new DataSeeder();
        }

        protected override void Seed(JobMatcherDbContext context)
        {
            if (context.Users.Any())
            {
                return;
            }

            this.seeder.SeedUsers(context);
            this.seeder.SeedLocations(context);
            this.seeder.SeedOrganizations(context);
            this.seeder.SeedEducation(context);
            this.seeder.SeedExperience(context);
            this.seeder.SeedProjects(context);
            this.seeder.SeedSkills(context);

            var users = context.Users.Take(10).ToList();

            this.seeder.SeedRecruiterProfiles(context, users);
            var recruiters = context.RecruiterProfiles.Take(10).ToList();

            this.seeder.SeedJobOffers(context, recruiters);

            var education = context.Eductaion.Take(10).ToList();
            var experience = context.Experience.Take(10).ToList();
            var projects = context.Projects.Take(10).ToList();
            var skills = context.Skills.Take(10).ToList();
            var offers = context.JobOffers.Take(10).ToList();


            this.seeder.SeedJobSeekerProfiles(context, users, education, experience, projects, skills, offers);
        }
    }
}
