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
    public class RecruiterProfileController : BaseController
    {
        public RecruiterProfileController(IJobMatcherData data)
            : base(data)
        {
        }

        [HttpGet]
        public IHttpActionResult Get()
        {
            var recruiters = this.data.RecruiterProfiles.All()
                .Where(x => !x.IsDeleted)
                .ProjectTo<RecruiterProfileViewModel>()
                .ToList();

            return this.Ok(recruiters);
        }

        [HttpGet]
        public IHttpActionResult Details(int? id)
        {
            var recruiter = this.data.RecruiterProfiles.All()
                .Where(x => !x.IsDeleted)
                .Where(x => x.RecruiterProfileId == id)
                .ProjectTo<RecruiterProfileViewModel>()
                .FirstOrDefault();

            return this.Ok(recruiter);
        }

        [HttpGet]
        public IHttpActionResult Details()
        {
            var recruiter = this.data.RecruiterProfiles.All()
                .Where(x => !x.IsDeleted)
                .Where(x => x.UserId == this.CurrentUserId)
                .ProjectTo<RecruiterProfileViewModel>()
                .FirstOrDefault();

            return this.Ok(recruiter);
        }

        [HttpGet]
        public IHttpActionResult GetMessagesWithJobSeeker(int jobSeekerProfileId)
        {
            var recruiter = this.data.RecruiterProfiles.All()
                .Where(x => !x.IsDeleted)
                .FirstOrDefault(x => x.UserId == this.CurrentUserId);

            if (recruiter == null)
            {
                return this.BadRequest("You must be a job seeker to do that.");
            }

            var messages = recruiter.Messages
                .Where(x => !x.IsDeleted)
                .Where(x => x.JobSeekerProfileId == jobSeekerProfileId)
                .AsQueryable()
                .OrderBy(x => x.Id) //TODO add date
                .ProjectTo<MessageViewModel>()
                .ToList(); //TODO check

            return this.Ok(messages);
        }
    }
}