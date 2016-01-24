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
    public class MatchController : BaseController
    {
        public MatchController(IJobMatcherData data)
            : base(data)
        {
        }

        [HttpGet]
        public IHttpActionResult Get()
        {
            var matches = this.data.Matches.All()
                .ToList();

            return this.Ok(matches);
        }

        [HttpPost]
        public IHttpActionResult Add(AddMatchViewModel model)
        {
            var match =
                this.data.Matches.All()
                    .FirstOrDefault(
                        x =>
                            x.JobSeekerProfileId == model.JobSeekerProfileId &&
                            x.RecruiterProfileId == model.RecruiterProfileId);

            if (match == null)
            {
                match = new Match()
                {
                    JobSeekerProfileId = model.JobSeekerProfileId,
                    RecruiterProfileId = model.RecruiterProfileId
                };
            }

            this.data.Matches.Add(match);
            this.data.SaveChanges();

            return this.Ok(match);
        }
    }
}