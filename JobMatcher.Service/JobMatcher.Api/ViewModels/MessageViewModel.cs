using JobMatcher.Service.Mapping;
using JobMatcher.Models;

namespace JobMatcher.Service.ViewModels
{
    public class MessageViewModel : IMapFrom<Message>, IHaveCustomMappings
    {
        public int Id { get; set; }

        public string Subject { get; set; }

        public string Content { get; set; }

        public int JobSeekerProfileId { get; set; }

        public int RecruiterProfileId { get; set; }

        public int SenderId { get; set; }

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<Message, MessageViewModel>()
               .ReverseMap();
        }
    }
}