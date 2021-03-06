﻿using System;
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
    public class JobOfferController : BaseController
    {
        private static Random random;

        static JobOfferController()
        {
            random = new Random();
        }

        public JobOfferController(IJobMatcherData data)
            : base(data)
        {
        }

        [HttpGet]
        public IHttpActionResult Get()
        {
            var jobOffers = this.data.JobOffers.All()
                .Where(x => !x.IsDeleted)
                .ProjectTo<JobOfferViewModel>()
                .ToList();

            return this.Ok(jobOffers);
        }

        [HttpGet]
        public IHttpActionResult GetMatched()
        {
            var jobSeeker = this.data.JobSeekerProfiles.All()
                .Where(x => !x.IsDeleted)
                .FirstOrDefault(x => x.UserId == this.CurrentUserId);

            if (jobSeeker == null)
            {
                return this.BadRequest("You must be a job seeker to do that.");
            }

            //var matches = this.data.Matches.All()
            //    .Where(x => x.JobSeekerProfileId == jobSeeker.JobSeekerProfileId)
            //    .Select(x => x.Id).ToList();

            var jobOffers = jobSeeker
                .SelectedJobOffers.AsQueryable()
                .Where(x => !x.IsDeleted)
                .ProjectTo<JobOfferViewModel>()
                .ToList();

            return this.Ok(jobOffers);
        }

        [HttpGet]
        public IHttpActionResult Details(int? id)
        {
            var jobOffer = this.data.JobOffers.All()
                .Where(x => !x.IsDeleted)
                .Where(x => x.Id == id)
                .ProjectTo<JobOfferViewModel>()
                .FirstOrDefault();

            return this.Ok(jobOffer);
        }

        [HttpGet]
        public IHttpActionResult Random()
        {
            var jobSeeker = this.data.JobSeekerProfiles.All()
                .Where(x => !x.IsDeleted)
                .FirstOrDefault(x => x.UserId == this.CurrentUserId);

            if (jobSeeker == null)
            {
                return this.BadRequest("You must be a jobSeeker to do that.");
            }

            //var jobSeekerMatches = this.data.Matches.All()
            //    .Where(x => x.RecruiterProfileId == jobSeeker.JobSeekerProfileId)
            //    .Select(x => x.RecruiterProfileId).ToList();

            var jobSeekerLikes = this.data.Likes.All()
                .Where(x => !x.IsDeleted)
                .Where(x => x.JobSeekerProfileId == jobSeeker.JobSeekerProfileId && x.LikeInitiatorType == ProfileType.JobSeeker)
                .Select(x => x.JobOfferId).ToList();

            var jobSeekerDislikes = this.data.Dislikes.All()
                .Where(x => !x.IsDeleted)
                .Where(x => x.JobSeekerProfileId == jobSeeker.JobSeekerProfileId && x.DislikeInitiatorType == ProfileType.JobSeeker)
                .Select(x => x.JobOfferId).ToList();

            var allJobOffers = this.data.JobOffers.All()
               .Where(x => !x.IsDeleted)
               .Where(x => !jobSeekerLikes.Contains(x.Id)
                   || !jobSeekerDislikes.Contains(x.Id))
                   .Select(x => x)
                   .ToList();

            // TODO: improve
            if (allJobOffers.Count > 0)
            {
                int randomIndex = random.Next(0, allJobOffers.Count);

                int selectedId = allJobOffers[randomIndex].Id;

                var jobOffer = this.data.JobOffers.All()
                  .Where(x => !x.IsDeleted)
                  .Where(x => x.Id == selectedId)
                  .ProjectTo<JobOfferViewModel>()
                  .FirstOrDefault();

                return this.Ok(jobOffer);
            }

            return this.BadRequest("No more job offers to browse.");
        }

        [HttpPost]
        public IHttpActionResult Add(AddJobOfferViewModel model)
        {
            if (model != null && ModelState.IsValid)
            {
                var jobOffer = AutoMapper.Mapper.Map<JobOffer>(model);

                var location = this.GetLocation(model);
                jobOffer.Location = location;
                jobOffer.LocationId = location.Id;

                this.data.JobOffers.Add(jobOffer);
                this.data.SaveChanges();

                model.Id = jobOffer.Id;

                this.data.SaveChanges();

                return this.Ok(model);
            }

            return this.BadRequest();
        }

        [HttpPost]
        public IHttpActionResult Delete(int id)
        {
            var recruiter = this.data.RecruiterProfiles.All()
                .FirstOrDefault(x => x.UserId == this.CurrentUserId);

            var jobOffer = this.data.JobOffers.Find(id);

            if (jobOffer != null)
            {
                if (!jobOffer.RecruiterProfile.UserId.Equals(this.CurrentUserId))
                {
                    return this.BadRequest("This offer isn't yours to delete.");
                }

               // jobOffer.IsDeleted = true;
                //this.data.JobOffers.Update(jobOffer);
                recruiter.JobOffers.Remove(jobOffer);
                foreach (var jobSeeker in jobOffer.InterestedJobSeekers)
                {
                    jobSeeker.SelectedJobOffers.Remove(jobOffer);
                }

                this.data.JobOffers.Delete(jobOffer);
                this.data.SaveChanges();

                return this.Ok(jobOffer);
            }

            return this.BadRequest("The job offer couldn't be found.");
        }

        //TODO edit offer
        //TODO filter by location - range

        [HttpGet]
        public IHttpActionResult FilterByIndustry(int industryId)
        {
            var jobOffers = this.data.JobOffers.All()
                .Where(x => !x.IsDeleted)
                .Where(x => (int)x.Industry == industryId)
                .ProjectTo<JobOfferViewModel>()
                .ToList();

            return this.Ok(jobOffers);
        }

        private Location GetLocation(AddJobOfferViewModel model)
        {
            var location = new Location()
            {
                Longitude = model.Longitude,
                Latitude = model.Latitude,
                Country = model.Country,
                City = model.City,
                PostCode = model.PostCode
            };

            this.data.Locations.Add(location);
            this.data.SaveChanges();

            return location;
        }
    }
}