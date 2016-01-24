using System;
using JobMatcher.Models;
using JobMatcher.Service.Mapping;

namespace JobMatcher.Service.ViewModels
{
    public class EducationViewModel : IMapFrom<Education>, IHaveCustomMappings
    {
        public Degree Degree { get; set; }

        public string OrganizationName { get; set; }

        public Industry Industry { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime? EndDate { get; set; }

        public string Description { get; set; }

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<Education, EducationViewModel>()
                .ForMember(m => m.OrganizationName, opt => opt.MapFrom(x => x.Organization.Name))
                .ReverseMap();
        }
    }
}