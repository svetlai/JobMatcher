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
                .ProjectTo<RecruiterProfileViewModel>()
                .ToList();

            return this.Ok(recruiters);
        }

        [HttpGet]
        public IHttpActionResult Details(int? id)
        {
            var recruiter = this.data.RecruiterProfiles.All()
                .Where(x => x.RecruiterProfileId == id)
                .ProjectTo<RecruiterProfileViewModel>()
                .FirstOrDefault();

            return this.Ok(recruiter);
        }
    }
}