using System.ComponentModel.DataAnnotations;
using JobMatcher.Models;
using JobMatcher.Service.Mapping;

namespace JobMatcher.Service.ViewModels
{
    public class AddJobOfferViewModel : IMapFrom<JobOffer>, IHaveCustomMappings
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

        public string Latitude { get; set; }

        public string Longitude { get; set; }

        public string Country { get; set; }

        public string City { get; set; }

        public string PostCode { get; set; }

        public int WorkHours { get; set; }

        public double Salary { get; set; }

        public int RecruiterProfileId { get; set; }

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<JobOffer, AddJobOfferViewModel>()
                .ForMember(m => m.Country, opt => opt.MapFrom(x => x.Location.Country))
                .ForMember(m => m.City, opt => opt.MapFrom(x => x.Location.City))
                .ForMember(m => m.PostCode, opt => opt.MapFrom(x => x.Location.PostCode))
                .ForMember(m => m.Latitude, opt => opt.MapFrom(x => x.Location.Latitude))
                .ForMember(m => m.Longitude, opt => opt.MapFrom(x => x.Location.Longitude))
                .ForMember(m => m.Industry, opt => opt.MapFrom(x => (int)x.Industry))
                .ForMember(m => m.WorkHours, opt => opt.MapFrom(x => (int)x.WorkHours))
                .ReverseMap();
        }
    }
}