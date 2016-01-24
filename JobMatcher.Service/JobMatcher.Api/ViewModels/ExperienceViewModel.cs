using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using JobMatcher.Models;
using JobMatcher.Service.Mapping;

namespace JobMatcher.Service.ViewModels
{
    public class ExperienceViewModel : IMapFrom<Experience>, IHaveCustomMappings
    {
        public string Position { get; set; }

        public string OrganizationName { get; set; }

        public Industry Industry { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime? EndDate { get; set; }

        public string Description { get; set; }

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<Experience, ExperienceViewModel>()
                .ForMember(m => m.OrganizationName, opt => opt.MapFrom(x => x.Organization.Name))
                .ReverseMap();
        }
    }
}