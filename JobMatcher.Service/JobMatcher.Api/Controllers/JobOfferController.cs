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

        //[HttpGet]
        //public IHttpActionResult Details(int? id)
        //{
        //    var jobOffer = this.data.JobOffers.All()
        //        .Where(x => x.Id == id)
        //        .ProjectTo<JobOfferViewModel>()
        //        .FirstOrDefault();

        //    return this.Ok(jobOffer);
        //}

        [HttpPost]
        public IHttpActionResult Create(AddJobOfferViewModel model)
        {
            if (model != null && ModelState.IsValid)
            {
                var page = AutoMapper.Mapper.Map<JobOffer>(model);

                this.data.JobOffers.Add(page);
                this.data.SaveChanges();

                model.Id = page.Id;

                this.data.SaveChanges();
            }

            return this.Ok(model);
        }

        //TODO Edit Offer

        [HttpGet]
        public IHttpActionResult FilterByIndustry(int industryId)
        {
            var jobOffers = this.data.JobOffers.All()
                .Where(x => (int)x.Industry == industryId)
                .ProjectTo<JobOfferViewModel>()
                .ToList();

            return this.Ok(jobOffers);
        }
    }
}