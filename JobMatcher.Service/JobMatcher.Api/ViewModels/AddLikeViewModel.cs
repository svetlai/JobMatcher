using JobMatcher.Service.Mapping;

namespace JobMatcher.Service.ViewModels
{
    using JobMatcher.Models;

    public class AddLikeViewModel : IMapFrom<Like>, IHaveCustomMappings
    {
        public int Id { get; set; }

        public int RecruiterProfileId { get; set; }

        public int JobSeekerProfileId { get; set; }

        public ProfileType LikeInitiatorType { get; set; }

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<Like, AddLikeViewModel>()
                .ReverseMap();
        }
    }
}