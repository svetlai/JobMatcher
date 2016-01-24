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
                //.Where(x => x.JosSeekerProfile.UserId == this.CurrentUser.Id)
                .ProjectTo<SkillViewModel>()
                .ToList();

            return this.Ok(skills);
        }

        [HttpPost]
        public IHttpActionResult Add(AddSkillViewModel model)
        {
            if (model != null && ModelState.IsValid)
            {
                var skill = AutoMapper.Mapper.Map<Skill>(model);

                //skill.JosSeekerProfile =
                //                  this.data.JobSeekerProfiles.All().FirstOrDefault(x => x.UserId == this.CurrentUser.Id);

                this.data.Skills.Add(skill);
                this.data.SaveChanges();

                model.Id = skill.Id;

                this.data.SaveChanges();

                return this.Ok(model);
            }

            return this.BadRequest();
        }

        //TODO edit & delete
    }
}