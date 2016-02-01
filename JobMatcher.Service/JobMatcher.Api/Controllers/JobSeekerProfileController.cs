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
        private static Random random;

        static JobSeekerProfileController()
        {
            random = new Random();
        }

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
        public IHttpActionResult Random()
        {
            var recruiter = this.data.RecruiterProfiles.All()
                .FirstOrDefault(x => x.UserId == this.CurrentUserId);

            if (recruiter == null)
            {
                return this.BadRequest("You must be a recruiter to do that.");
            }

            var recruiterMatches = this.data.Matches.All()
                .Where(x => x.RecruiterProfileId == recruiter.RecruiterProfileId)
                .Select(x => x.JobSeekerProfileId).ToList();

            var recruiterLikes = this.data.Likes.All()
                .Where(x => x.RecruiterProfileId == recruiter.RecruiterProfileId && x.LikeInitiatorType == ProfileType.Recruiter)
                .Select(x => x.JobSeekerProfileId).ToList();

            var recruiterDislikes = this.data.Dislikes.All()
                .Where(x => x.RecruiterProfileId == recruiter.RecruiterProfileId && x.DislikeInitiatorType == ProfileType.Recruiter)
                .Select(x => x.JobSeekerProfileId).ToList();

            var allJobSeekers = this.data.JobSeekerProfiles.All()
                .Where(x => !recruiterMatches.Contains(x.JobSeekerProfileId) 
                    && !recruiterLikes.Contains(x.JobSeekerProfileId) 
                    && !recruiterDislikes.Contains(x.JobSeekerProfileId))
                    .Select(x => x)
                    .ToList();
            
            // TODO: improve
            int randomIndex = random.Next(0, allJobSeekers.Count);

            int selectedId = allJobSeekers[randomIndex].JobSeekerProfileId;

            var jobSeeker = this.data.JobSeekerProfiles.All()
                .Where(x => x.JobSeekerProfileId == selectedId)
                .ProjectTo<JobSeekerProfileViewModel>()
                .FirstOrDefault();

            //var jobSeeker = this.data.JobSeekerProfiles.All()
            //    .Where(x => !recruiter.LikedJobSeekers.Contains(x.JobSeekerProfileId) && !recruiter.DislikedJobSeekers.Contains(x.JobSeekerProfileId))
            //    .ProjectTo<JobSeekerProfileViewModel>()
            //    .FirstOrDefault();

            return this.Ok(jobSeeker);
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

        [HttpGet]
        public IHttpActionResult Details(string email)
        {
            var jobSeeker = this.data.JobSeekerProfiles.All()
                .Where(x => x.User.Email == email)
                .ProjectTo<JobSeekerProfileViewModel>()
                .FirstOrDefault();

            return this.Ok(jobSeeker);
        }

        [HttpGet]
        public IHttpActionResult Details()
        {
            var jobSeeker = this.data.JobSeekerProfiles.All()
                .Where(x => x.UserId == this.CurrentUserId)
                .ProjectTo<JobSeekerProfileViewModel>()
                .FirstOrDefault();

            return this.Ok(jobSeeker);
        }
    }
}