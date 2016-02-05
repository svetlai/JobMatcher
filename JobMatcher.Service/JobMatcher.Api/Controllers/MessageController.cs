using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using AutoMapper.QueryableExtensions;
using JobMatcher.Data.Contracts;
using JobMatcher.Models;
using JobMatcher.Service.ViewModels;

namespace JobMatcher.Service.Controllers
{
    public class MessageController : BaseController
    {
        public MessageController(IJobMatcherData data)
            : base(data)
        {
        }

        [HttpPost]
        public IHttpActionResult Add(AddMessageViewModel model)
        {
            if (model != null && ModelState.IsValid)
            {
                var message = AutoMapper.Mapper.Map<Message>(model);

                this.data.Messages.Add(message);
                this.data.SaveChanges();

                var jobSeeker =
                    this.data.JobSeekerProfiles.All()
                        .FirstOrDefault(x => x.JobSeekerProfileId == model.JobSeekerProfileId);

                var recruiter =
                    this.data.RecruiterProfiles.All()
                        .FirstOrDefault(x => x.RecruiterProfileId == model.RecruiterProfileId);

                if (jobSeeker == null || recruiter == null)
                {
                    return this.BadRequest("A message can only be sent between job seekers and recruiters.");
                }

                jobSeeker.Messages.Add(message);
                recruiter.Messages.Add(message);

                model.Id = message.Id;

                this.data.SaveChanges();

                return this.Ok(model);
            }

            return this.BadRequest();
        }

        //[HttpGet]
        //public IHttpActionResult Get(int recruiterProfileId)
        //{
        //    var jobSeeker = this.data.JobSeekerProfiles.All()
        //        .FirstOrDefault(x => x.UserId == this.CurrentUserId);

        //    var messages = jobSeeker.Messages.Where(x => x.RecruiterProfileId == recruiterProfileId); //TODO check

        //        .ProjectTo<JobSeekerProfileViewModel>()
        //        .ToList();

        //    return this.Ok(jobSeekers);
        //}
    
    }
}