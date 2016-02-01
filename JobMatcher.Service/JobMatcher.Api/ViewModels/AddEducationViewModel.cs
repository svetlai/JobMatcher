using System;
using JobMatcher.Models;
using JobMatcher.Service.Mapping;

namespace JobMatcher.Service.ViewModels
{
    public class AddEducationViewModel : IMapFrom<Education>, IHaveCustomMappings
    {
        public int Id { get; set; }

        public int Degree { get; set; }

        public string Specialty { get; set; }

        public string OrganizationName { get; set; }

        public int Industry { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime? EndDate { get; set; }

        public string Description { get; set; }

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<Education, AddEducationViewModel>()
                .ForMember(m => m.OrganizationName, opt => opt.MapFrom(x => x.Organization.Name))
                .ForMember(m => m.Industry, opt => opt.MapFrom(x => (int)x.Industry))
                .ForMember(m => m.Degree, opt => opt.MapFrom(x => (int)x.Degree))
                .ReverseMap();
        }
    }
}