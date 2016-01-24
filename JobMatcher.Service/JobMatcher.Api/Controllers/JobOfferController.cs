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
    public class JobOfferController : BaseController
    {
        public JobOfferController(IJobMatcherData data)
            : base(data)
        {
        }

        [HttpGet]
        public IHttpActionResult Get()
        {
            var jobOffers = this.data.JobOffers.All()
                .ProjectTo<JobOfferViewModel>()
                .ToList();

            return this.Ok(jobOffers);
        }

        [HttpGet]
        public IHttpActionResult Details(int? id)
        {
            var jobOffer = this.data.JobOffers.All()
                .Where(x => x.Id == id)
                .ProjectTo<JobOfferViewModel>()
                .FirstOrDefault();

            return this.Ok(jobOffer);
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

        //TODO edit offer
        //TODO filter by location - range

        [HttpGet]
        public IHttpActionResult FilterByIndustry(int industryId)
        {
            var jobOffers = this.data.JobOffers.All()
                .Where(x => (int)x.Industry == industryId)
                .ProjectTo<JobOfferViewModel>()
                .ToList();

            return this.Ok(jobOffers);
        }

        private Location GetLocation(AddJobOfferViewModel model)
        {
            var location = new Location()
            {
                Longtitude = model.Longtitude,
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