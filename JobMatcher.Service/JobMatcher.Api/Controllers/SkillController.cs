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
    public class SkillController : BaseController
    {
        public SkillController(IJobMatcherData data)
            : base(data)
        {
        }

        [HttpGet]
        public IHttpActionResult GetByUser()
        {
            var skills = this.data.Skills.All()
                .Where(x => !x.IsDeleted)
                //.Where(x => x.JosSeekerProfile.UserId == this.CurrentUser.Id)
                .ProjectTo<SkillViewModel>()
                .ToList();

            return this.Ok(skills);
        }

        [HttpPost]
        public IHttpActionResult Add(AddSkillViewModel model)
        {
            var jobSeeker = this.data.JobSeekerProfiles.All()
                .FirstOrDefault(x => x.UserId == this.CurrentUserId);

            if (jobSeeker == null)
            {
                return this.BadRequest("You must be a job seeker to add a skill");
            }

            if (model != null && ModelState.IsValid)
            {
                var skill = AutoMapper.Mapper.Map<Skill>(model);

                this.data.Skills.Add(skill);
                this.data.SaveChanges();

                model.Id = skill.Id;
                jobSeeker.Skills.Add(skill);

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

            if (jobSeeker == null)
            {
                return this.BadRequest("You must be a job seeker to delete a skill");
            }

            var skill = this.data.Skills.Find(id);

            if (skill != null)
            {
                jobSeeker.Skills.Remove(skill);
                this.data.Skills.Delete(skill);
                this.data.SaveChanges();

                return this.Ok(skill);
            }

            return this.BadRequest("The project couldn't be found.");
        }

        //TODO edit & delete
    }
}