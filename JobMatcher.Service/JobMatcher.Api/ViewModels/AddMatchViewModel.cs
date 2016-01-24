using JobMatcher.Service.Mapping;

namespace JobMatcher.Service.ViewModels
{
    using JobMatcher.Models;

    public class AddMatchViewModel : IMapFrom<Match>, IHaveCustomMappings
    {
        public int RecruiterProfileId { get; set; }

        public int JobSeekerProfileId { get; set; }

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<Match, AddMatchViewModel>()
                .ReverseMap();
        }
    }
}