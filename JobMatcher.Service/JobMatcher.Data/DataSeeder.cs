using System;
using System.Collections.Generic;
using System.Data.Entity.Migrations;
using System.Linq;
using JobMatcher.Models;
using JobMatcher.Models.Enums;

namespace JobMatcher.Data
{
    using System.Data.Entity;

    using JobMatcher.Common;

    using Microsoft.AspNet.Identity;
    using Microsoft.AspNet.Identity.EntityFramework;

    internal class DataSeeder
    {
        public void SeedLocations(JobMatcherDbContext context)
        {
            var locations = new List<Location>
            {
                new Location()
                {
                    Country = "Bulgaria",
                    City = "Sofia",
                    PostCode = "1234"
                },
                new Location()
                {
                    Country = "Bulgaria",
                    City = "Burgas",
                    PostCode = "4321"
                }
            };

            context.Locations.AddOrUpdate(locations.ToArray());
            context.SaveChanges();
        }

        public void SeedUsers(JobMatcherDbContext context)
        {
            var userManager = new UserManager<User>(new UserStore<User>(context));

            var emails = new List<string>
            {
                string.Format("{0}@{1}.com", "pesho", "recruiter"),
                string.Format("{0}@{1}.com", "mariq", "recruiter"),
                string.Format("{0}@{1}.com", "gosho", "jobseeker"),
                string.Format("{0}@{1}.com", "pepa", "jobseeker"),
            };

            for (int i = 0; i < emails.Count; i++)
            {
                var user = new User
                {
                    Email = emails[i],
                    UserName = emails[i].Split('@')[0],

                };

                user.ProfileType = i < 2 ? ProfileType.Recruiter : ProfileType.JobSeeker;

                userManager.Create(user, "123456");
            }

            context.SaveChanges();
        }

        public void SeedJobOffers(JobMatcherDbContext context, IList<RecruiterProfile> recruiters)
        {
            var jobOffers = new List<JobOffer>
            {
                new JobOffer()
                {
                    WorkHours = WorkHours.FullTime,
                    Industry = Industry.InformationTechnology,
                    LocationId = 1,
                    Description = "We need you!",
                    Title = "C# Developer",
                    Salary = 2000,
                    RecruiterProfileId = recruiters[0].RecruiterProfileId
                },
                    new JobOffer()
                {
                    WorkHours = WorkHours.PartTime,
                    Industry = Industry.InformationTechnology,
                    LocationId = 2,
                    Description = "Join our awesome team!",
                    Title = "iOS Developer",
                    Salary = 2100,
                    RecruiterProfileId = recruiters[1].RecruiterProfileId
                }
            };

            context.JobOffers.AddOrUpdate(jobOffers.ToArray());
            context.SaveChanges();
        }

        public void SeedOrganizations(JobMatcherDbContext context)
        {
            var organizations = new List<Organization>
            {
                new Organization()
                {
                    Name = "SBTech",
                   // LocationId = 0,
                    Industry = Industry.InformationTechnology,                 
                },
                new Organization()
                {
                    Name = "Progress",
                   // LocationId = 0,
                    Industry = Industry.InformationTechnology,                 
                },
                new Organization()
                {
                    Name = "FMI",
                    //LocationId = 0,
                    Industry = Industry.InformationTechnology,                 
                }
            };

            context.Organizations.AddOrUpdate(organizations.ToArray());
            context.SaveChanges();
        }

        public void SeedEducation(JobMatcherDbContext context)
        {
            var educations = new List<Education>
            {
                new Education()
                {
                    Degree = Degree.Bachelor,
                    Industry = Industry.InformationTechnology,
                    OrganizationId = 2,
                    Description = "None",
                    StartDate = new DateTime(2011, 9, 15),
                    EndDate = new DateTime(2015, 5, 28),
                    Specialty = "Engineer"
                },
                new Education()
                {
                    Degree = Degree.Master,
                    Industry = Industry.InformationTechnology,
                    OrganizationId = 2,
                    Description = "None",
                    StartDate = new DateTime(2011, 9, 15),
                    EndDate = new DateTime(2015, 5, 28),
                    Specialty = "Software Developer"
                }
            };

            context.Eductaion.AddOrUpdate(educations.ToArray());
            context.SaveChanges();
        }

        public void SeedExperience(JobMatcherDbContext context)
        {
            var experience = new List<Experience>
            {
                new Experience()
                {
                    Position = "Awesome Dev",
                    Industry = Industry.InformationTechnology,
                    OrganizationId = 1,
                    Description = "Did some things.",
                    StartDate = new DateTime(2015, 9, 15),
                    EndDate = new DateTime(2016, 5, 28)                    
                },
                new Experience()
                {
                    Position = "Cool Dev",
                    Industry = Industry.InformationTechnology,
                    OrganizationId = 2,
                    Description = "None",
                    StartDate = new DateTime(2011, 9, 15),
                    EndDate = new DateTime(2016, 5, 28)        
                }
            };

            context.Experience.AddOrUpdate(experience.ToArray());
            context.SaveChanges();
        }

        public void SeedProjects(JobMatcherDbContext context)
        {
            var projects = new List<Project>
            {
                new Project()
                {
                    Title = "My Project",
                    Description = "Cool stuff",
                    Url = "https://github.com/svetlai/JobMatcher"              
                },
                new Project()
                {
                    Title = "Cool Project",
                    Description = "Cooler stuff",
                    Url = "https://github.com/svetlai/JobMatcher"              
                },
            };

            context.Projects.AddOrUpdate(projects.ToArray());
            context.SaveChanges();
        }

        public void SeedSkills(JobMatcherDbContext context)
        {
            var skills = new List<Skill>
            {
                new Skill()
                {
                    Name = "C#",
                    Level = Level.Advanced
                },
                new Skill()
                {
                    Name = "JavaScript",
                    Level = Level.Novice
                },
                new Skill()
                {
                    Name = "English",
                    Level = Level.Expert
                }
            };

            context.Skills.AddOrUpdate(skills.ToArray());
            context.SaveChanges();
        }

        public void SeedRecruiterProfiles(JobMatcherDbContext context, IList<User> users)
        {
            var recruiterProfiles = new List<RecruiterProfile>
            {
                new RecruiterProfile()
                {
                   UserId = users[0].Id
                },
                new RecruiterProfile()
                {
                   UserId = users[1].Id
                }
            };

            context.RecruiterProfiles.AddOrUpdate(recruiterProfiles.ToArray());
            context.SaveChanges();
        }

        public void SeedJobSeekerProfiles(JobMatcherDbContext context, IList<User> users, IList<Education> education, IList<Experience> experience, 
            IList<Project> projects, IList<Skill> skills, IList<JobOffer> offers)
        {
            var jobSeekerProfiles = new List<JobSeekerProfile>
            {
                new JobSeekerProfile()
                {
                   UserId = users[2].Id,
                   Summary = "This is me.",
                   Education = education.Take(1).ToList(),
                   Experience = experience.Take(1).ToList(),
                   Projects = projects,
                   Skills = skills.Take(1).ToList(),
                   SelectedJobOffers = offers
                },
                new JobSeekerProfile()
                {
                   UserId = users[3].Id,
                   Summary = "Like me or leave!",
                   Education = education.Skip(1).Take(1).ToList(),
                   Experience = experience.Skip(1).Take(1).ToList(),
                   Skills = skills.Take(1).ToList(),
                }
            };

            context.JobSeekerProfiles.AddOrUpdate(jobSeekerProfiles.ToArray());
            context.SaveChanges();
        }
    }
}
