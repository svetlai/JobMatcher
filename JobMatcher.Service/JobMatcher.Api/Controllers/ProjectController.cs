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
                .Where(x => !x.IsDeleted)
                .Where(x => x.JosSeekerProfile.UserId == this.CurrentUserId)
                .ProjectTo<ProjectViewModel>()
                .ToList();

            return this.Ok(projects);
        }

        [HttpPost]
        public IHttpActionResult Add(AddProjectViewModel model)
        {
            var jobSeeker = this.data.JobSeekerProfiles.All()
                .FirstOrDefault(x => x.UserId == this.CurrentUserId);

            if (jobSeeker == null)
            {
                return this.BadRequest("You must be a job seeker to delete a project");
            }

            if (model != null && ModelState.IsValid)
            {
                var project = AutoMapper.Mapper.Map<Project>(model);

                this.data.Projects.Add(project);
                this.data.SaveChanges();

                model.Id = project.Id;

                jobSeeker.Projects.Add(project);
                this.data.SaveChanges();

                return this.Ok(model);
            }

            return this.BadRequest();
        }

        [HttpPost]
        public IHttpActionResult Delete(int id)
        {
            var jobSeeker = this.data.JobSeekerProfiles.All()
                .FirstOrDefault(x => x.UserId == this.CurrentUserId);

            var project = this.data.Projects.Find(id);

            if (project != null)
            {
                if (!project.JosSeekerProfile.UserId.Equals(this.CurrentUserId))
                {
                    return this.BadRequest("This project isn't yours to delete.");
                }

                jobSeeker.Projects.Remove(project);
                this.data.Projects.Delete(project);
                this.data.SaveChanges();

                return this.Ok(project);
            }

            return this.BadRequest("The project couldn't be found.");
        }

        //TODO edit & delete
    }
}