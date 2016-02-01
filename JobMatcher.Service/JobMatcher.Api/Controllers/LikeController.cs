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
    public class LikeController : BaseController
    {
        public LikeController(IJobMatcherData data)
            : base(data)
        {
        }

        [HttpGet]
        public IHttpActionResult Get()
        {
            var likes = this.data.Likes.All()
                .ToList();

            return this.Ok(likes);
        }

        [HttpPost]
        public IHttpActionResult Add(AddLikeViewModel model)
        {
            if (model.JobSeekerProfileId == 0 && model.LikeInitiatorType == ProfileType.JobSeeker)
            {
                model.JobSeekerProfileId =
                    this.data.JobSeekerProfiles.All()
                        .FirstOrDefault(x => x.UserId == this.CurrentUserId)
                        .JobSeekerProfileId;
            }

            if (model.RecruiterProfileId == 0 && model.LikeInitiatorType == ProfileType.Recruiter)
            {
                model.RecruiterProfileId =
                    this.data.RecruiterProfiles.All()
                        .FirstOrDefault(x => x.UserId == this.CurrentUserId)
                        .RecruiterProfileId;
            }

            if (model.RecruiterProfileId == 0 || model.JobSeekerProfileId == 0)
            {
                return this.BadRequest("Id can't be 0.");
            }

            var existingLike =
                this.data.Likes.All()
                    .FirstOrDefault(
                        x =>
                            x.RecruiterProfileId == model.RecruiterProfileId &&
                            x.JobSeekerProfileId == model.JobSeekerProfileId);

            if (existingLike != null)
            {
                if (existingLike.LikeInitiatorType == model.LikeInitiatorType)
                {
                    return this.BadRequest("You've already liked that one.");
                }

                var existingMatch =
                this.data.Matches.All()
                    .FirstOrDefault(
                        x =>
                            x.RecruiterProfileId == model.RecruiterProfileId &&
                            x.JobSeekerProfileId == model.JobSeekerProfileId);

                if (existingMatch != null)
                {
                    return this.BadRequest("It's already a match.");
                }

                var match = new Match()
                {
                    JobSeekerProfileId = model.JobSeekerProfileId,
                    RecruiterProfileId = model.RecruiterProfileId
                };

                this.data.Matches.Add(match);
                this.data.SaveChanges();

                return Ok("Match added.");
            }

            var like = AutoMapper.Mapper.Map<Like>(model);

            var existingDislike =
            this.data.Dislikes.All()
                .FirstOrDefault(
                    x =>
                        x.RecruiterProfileId == model.RecruiterProfileId &&
                        x.JobSeekerProfileId == model.JobSeekerProfileId && 
                        x.DislikeInitiatorType == model.LikeInitiatorType);

            if (existingDislike != null)
            {
                this.data.Dislikes.Delete(existingDislike);
            }

            this.data.Likes.Add(like);
            this.data.SaveChanges();

            model.Id = like.Id;

            this.data.SaveChanges();
            return Ok(like);
        }
    }
}