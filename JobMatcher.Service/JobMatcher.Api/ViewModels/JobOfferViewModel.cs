using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using JobMatcher.Models;
using LikeIt.Web.Infrastructure.Mapping;

namespace JobMatcher.Service.ViewModels
{
    public class JobOfferViewModel : IMapFrom<JobOffer>, IHaveCustomMappings
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
        public Industry Industry { get; set; }

        public string Location { get; set; }

        public WorkHours WorkHours { get; set; }

        public double Salary { get; set; }

        public int RecruiterProfileId { get; set; }

       // public virtual ICollection<int> InterestedJobSeekersIds { get; set; }

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<JobOffer, JobOfferViewModel>()
                .ForMember(m => m.Location, opt => opt.MapFrom(x => x.Location.Country + " / " + x.Location.City))
                .ReverseMap();
        }
    }
}