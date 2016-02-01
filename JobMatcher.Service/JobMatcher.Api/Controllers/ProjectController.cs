using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;

using AutoMapper;
using AutoMapper.QueryableExtensions;

using JobMatcher.Data.Contracts;
using JobMatcher.Models;
using JobMatcher.Service.ViewModels;

namespace JobMatcher.Service.Controllers
{
    public class ProjectController : BaseController
    {
        public ProjectController(IJobMatcherData data)
            : base(data)
        {
        }

        [HttpGet]
        public IHttpActionResult GetByUser()
        {
            var projects = this.data.Projects.All()
                .Where(x => x.JosSeekerProfile.UserId == this.CurrentUserId)
                .ProjectTo<ProjectViewModel>()
                .ToList();

            return this.Ok(projects);
        }

        [HttpPost]
        public IHttpActionResult Add(AddProjectViewModel model)
        {
            if (model != null && ModelState.IsValid)
            {
                var project = AutoMapper.Mapper.Map<Project>(model);

                project.JosSeekerProfile =
                                  this.data.JobSeekerProfiles.All().FirstOrDefault(x => x.UserId == this.CurrentUserId);

                this.data.Projects.Add(project);
                this.data.SaveChanges();

                model.Id = project.Id;

                this.data.SaveChanges();

                return this.Ok(model);
            }

            return this.BadRequest();
        }

        //TODO edit & delete
    }
}