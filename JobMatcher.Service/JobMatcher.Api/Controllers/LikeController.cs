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
                .Where(x => !x.IsDeleted)
                .ToList();

            return this.Ok(likes);
        }

        [HttpPost]
        public IHttpActionResult Add(AddLikeViewModel model)
        {
            if (model.JobSeekerProfileId == 0 && model.LikeInitiatorType == ProfileType.JobSeeker)
            {
                model.JobSeekerProfileId =
                    this.data.JobSeekerProfiles.All().Where(x => !x.IsDeleted)
                        .FirstOrDefault(x => x.UserId == this.CurrentUserId)
                        .JobSeekerProfileId;
            }

            if (model.RecruiterProfileId == 0 && model.LikeInitiatorType == ProfileType.Recruiter)
            {
                model.RecruiterProfileId =
                    this.data.RecruiterProfiles.All().Where(x => !x.IsDeleted)
                        .FirstOrDefault(x => x.UserId == this.CurrentUserId)
                        .RecruiterProfileId;
            }

            if (model.RecruiterProfileId == 0 || model.JobSeekerProfileId == 0)
            {
                return this.BadRequest("Id can't be 0.");
            }

            var existingLike =
                this.data.Likes.All().Where(x => !x.IsDeleted)
                    .FirstOrDefault(
                        x =>
                            x.RecruiterProfileId == model.RecruiterProfileId &&
                            x.JobSeekerProfileId == model.JobSeekerProfileId &&
                            ((model.JobOfferId != 0 && x.JobOfferId == model.JobOfferId) || model.JobOfferId == 0));

            if (existingLike != null)
            {
                if (existingLike.LikeInitiatorType == model.LikeInitiatorType)
                {
                    return this.BadRequest("You've already liked that one.");
                }

                var existingMatch =
                this.data.Matches.All().Where(x => !x.IsDeleted)
                    .FirstOrDefault(
                        x =>
                            x.RecruiterProfileId == model.RecruiterProfileId &&
                            x.JobSeekerProfileId == model.JobSeekerProfileId
                            ); //x.JobOfferId == model.JobOfferId

                if (existingMatch == null)
                {
                    var match = new Match()
                    {
                        JobSeekerProfileId = model.JobSeekerProfileId,
                        RecruiterProfileId = model.RecruiterProfileId,
                    };

                    if (model.JobOfferId == 0)
                    {
                        model.JobOfferId =
                        this.data.Likes.All().Where(x => !x.IsDeleted)
                            .FirstOrDefault(x => x.JobSeekerProfileId == model.JobSeekerProfileId 
                                && x.RecruiterProfileId == model.RecruiterProfileId)
                            .JobOfferId;
                    }

                    if (model.JobOfferId == null)
                    {
                        return this.BadRequest("Job offer id cannot be null");
                    }

                    var jobSeeker = this.data.JobSeekerProfiles.All().Where(x => !x.IsDeleted)
                        .FirstOrDefault(x => x.JobSeekerProfileId == model.JobSeekerProfileId);

                    var jobOffer = this.data.JobOffers.All().Where(x => !x.IsDeleted)
                        .FirstOrDefault(x => x.Id == model.JobOfferId);

                    var recruiter =
                        this.data.RecruiterProfiles.All().Where(x => !x.IsDeleted)
                            .FirstOrDefault(x => x.RecruiterProfileId == model.RecruiterProfileId);
                    
                    jobSeeker.SelectedJobOffers.Add(jobOffer);
                    jobOffer.InterestedJobSeekers.Add(jobSeeker);
                    recruiter.MatchedJobSeekers.Add(jobSeeker);

                    //match.JobOfferId = (int) model.JobOfferId;

                    this.data.Matches.Add(match);
                    this.data.SaveChanges();

                    //return Ok("Match added.");
                }
            }

            var like = AutoMapper.Mapper.Map<Like>(model);
            like.JobOfferId = like.JobOfferId == 0 ? null : like.JobOfferId;
            like.CreatedOn = DateTime.Now;

            var existingDislike =
            this.data.Dislikes.All().Where(x => !x.IsDeleted)
                .FirstOrDefault(
                    x =>
                        x.RecruiterProfileId == model.RecruiterProfileId &&
                        x.JobSeekerProfileId == model.JobSeekerProfileId &&
                        x.DislikeInitiatorType == model.LikeInitiatorType && 
                        ((model.JobOfferId != 0 && x.JobOfferId == model.JobOfferId) || model.JobOfferId == 0));

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