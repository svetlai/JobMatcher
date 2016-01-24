using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using AutoMapper.QueryableExtensions;
using JobMatcher.Data.Contracts;
using JobMatcher.Models;
using JobMatcher.Service.ViewModels;

namespace JobMatcher.Service.Controllers
{
    public class ExperienceController : BaseController
    {
        public ExperienceController(IJobMatcherData data)
            : base(data)
        {
        }

        [HttpGet]
        public IHttpActionResult GetByUser()
        {
             var experience = this.data.Experience.All()
                //.Where(x => x.JosSeekerProfile.UserId == this.CurrentUser.Id)
                .ProjectTo<ExperienceViewModel>()
                .ToList();

             return this.Ok(experience);
        }

        [HttpPost]
        public IHttpActionResult Add(AddExperienceViewModel model)
        {
            if (model != null && ModelState.IsValid)
            {
                var experience = AutoMapper.Mapper.Map<Experience>(model);
                var organization = this.GetOrganization(model);

                experience.Organization = organization;
                experience.OrganizationId = organization.Id;

                //experience.JosSeekerProfile =
                //    this.data.JobSeekerProfiles.All().FirstOrDefault(x => x.UserId == this.CurrentUser.Id);

                this.data.Experience.Add(experience);
                this.data.SaveChanges();

                model.Id = experience.Id;

                this.data.SaveChanges();

                return this.Ok(model);
            }

            return this.BadRequest();
        }

        private Organization GetOrganization(AddExperienceViewModel model)
        {
            var organization = this.data.Organizations.All()
                .FirstOrDefault(x => x.Name == model.OrganizationName);

            if (organization == null)
            {
                organization = new Organization()
                {
                    Name = model.OrganizationName,
                    Industry = (Industry)model.Industry
                };
            }

            this.data.Organizations.Add(organization);
            this.data.SaveChanges();

            return organization;
        }
    }
}