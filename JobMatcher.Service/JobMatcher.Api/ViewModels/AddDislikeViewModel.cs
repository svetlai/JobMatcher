using JobMatcher.Service.Mapping;

namespace JobMatcher.Service.ViewModels
{
    using JobMatcher.Models;

    public class AddDislikeViewModel : IMapFrom<Dislike>, IHaveCustomMappings
    {
        public int Id { get; set; }

        public int RecruiterProfileId { get; set; }

        public int JobSeekerProfileId { get; set; }

        public int? JobOfferId { get; set; }

        public ProfileType DislikeInitiatorType { get; set; }

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<Dislike, AddDislikeViewModel>()
                .ReverseMap();
        }
    }
}