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
    public class JobSeekerProfileController : BaseController
    {
        public JobSeekerProfileController(IJobMatcherData data)
            : base(data)
        {
        }

        [HttpGet]
        public IHttpActionResult Get()
        {
            var jobSeekers = this.data.JobSeekerProfiles.All()
                .ProjectTo<JobSeekerProfileViewModel>()
                .ToList();

            return this.Ok(jobSeekers);
        }

        [HttpGet]
        public IHttpActionResult Details(int? id)
        {
            var jobSeeker = this.data.JobSeekerProfiles.All()
                .Where(x => x.JobSeekerProfileId == id)
                .ProjectTo<JobSeekerProfileViewModel>()
                .FirstOrDefault();

            return this.Ok(jobSeeker);
        }
    }
}