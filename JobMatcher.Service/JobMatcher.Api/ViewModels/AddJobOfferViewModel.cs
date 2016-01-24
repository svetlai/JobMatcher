using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using JobMatcher.Models;

namespace JobMatcher.Service.ViewModels
{
    public class AddJobOfferViewModel
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(150)]
        public string Title { get; set; }

        [Required]
        [StringLength(5000)]
        public string Description { get; set; }

        [Required]
        public int Industry { get; set; }

        public string Location { get; set; }

        public int WorkHours { get; set; }

        public double Salary { get; set; }

        public int RecruiterProfileId { get; set; }

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<JobOffer, AddJobOfferViewModel>()
                .ForMember(m => m.Location, opt => opt.MapFrom(x => x.Location.Country + " / " + x.Location.City))
                .ForMember(m => m.Industry, opt => opt.MapFrom(x => (int)x.Industry))
                .ForMember(m => m.WorkHours, opt => opt.MapFrom(x => (int)x.WorkHours))
                .ReverseMap();
        }
    }
}