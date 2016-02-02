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
    public class DislikeController : BaseController
    {
        public DislikeController(IJobMatcherData data)
            : base(data)
        {
        }

        [HttpGet]
        public IHttpActionResult Get()
        {
            var dislikes = this.data.Dislikes.All()
                .ToList();

            return this.Ok(dislikes);
        }

        [HttpPost]
        public IHttpActionResult Add(AddDislikeViewModel model)
        {
            if (model.JobSeekerProfileId == 0 && model.DislikeInitiatorType == ProfileType.JobSeeker)
            {
                model.JobSeekerProfileId =
                    this.data.JobSeekerProfiles.All()
                        .First(x => x.UserId == this.CurrentUserId)
                        .JobSeekerProfileId;
            }

            if (model.RecruiterProfileId == 0 && model.DislikeInitiatorType == ProfileType.Recruiter)
            {
                model.RecruiterProfileId =
                    this.data.RecruiterProfiles.All()
                        .First(x => x.UserId == this.CurrentUserId)
                        .RecruiterProfileId;
            }

            if (model.RecruiterProfileId == 0 || model.JobSeekerProfileId == 0)
            {
                return this.BadRequest("Id can't be 0.");
            }

            var existingDislike =
                this.data.Dislikes.All()
                    .FirstOrDefault(
                        x =>
                            x.RecruiterProfileId == model.RecruiterProfileId &&
                            x.JobSeekerProfileId == model.JobSeekerProfileId &&
                            x.DislikeInitiatorType == model.DislikeInitiatorType);

            if (existingDislike == null)
            {
                var dislike = AutoMapper.Mapper.Map<Dislike>(model);
                dislike.JobOfferId = dislike.JobOfferId == 0 ? null : dislike.JobOfferId;
                dislike.CreatedOn = DateTime.Now;

                var existingLike =
                this.data.Likes.All()
                    .FirstOrDefault(
                        x =>
                            x.RecruiterProfileId == model.RecruiterProfileId &&
                            x.JobSeekerProfileId == model.JobSeekerProfileId &&
                            x.LikeInitiatorType == model.DislikeInitiatorType &&
                            ((model.JobOfferId != 0 && x.JobOfferId == model.JobOfferId) || model.JobOfferId == 0));

                if (existingLike != null)
                {
                    this.data.Likes.Delete(existingLike);
                }

                this.data.Dislikes.Add(dislike);
                this.data.SaveChanges();

                model.Id = dislike.Id;

                this.data.SaveChanges();
                return Ok(dislike);
            }

            return this.BadRequest("You've already disliked that one.");
        }
    }
}