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
    public class EducationController : BaseController
    {
        public EducationController(IJobMatcherData data)
            : base(data)
        {
        }

        [HttpGet]
        public IHttpActionResult GetByUser()
        {
            var experience = this.data.Eductaion.All()
                .Where(x => !x.IsDeleted)
                //.Where(x => x.JosSeekerProfile.UserId == this.CurrentUser.Id)
                .ProjectTo<EducationViewModel>()
                .ToList();

             return this.Ok(experience);
        }

        [HttpPost]
        public IHttpActionResult Add(AddEducationViewModel model)
        {
            if (model != null && ModelState.IsValid)
            {
                var experience = AutoMapper.Mapper.Map<Education>(model);
                var organization = this.GetOrganization(model);

                experience.Organization = organization;
                experience.OrganizationId = organization.Id;

                //experience.JosSeekerProfile =
                //    this.data.JobSeekerProfiles.All().FirstOrDefault(x => x.UserId == this.CurrentUser.Id);

                this.data.Eductaion.Add(experience);
                this.data.SaveChanges();

                model.Id = experience.Id;

                this.data.SaveChanges();

                return this.Ok(model);
            }

            return this.BadRequest();
        }

        private Organization GetOrganization(AddEducationViewModel model)
        {
            var organization = this.data.Organizations.All().Where(x => !x.IsDeleted)
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