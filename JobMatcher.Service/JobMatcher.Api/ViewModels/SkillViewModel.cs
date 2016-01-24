using JobMatcher.Models;
using JobMatcher.Models.Enums;
using JobMatcher.Service.Mapping;

namespace JobMatcher.Service.ViewModels
{
    public class SkillViewModel : IMapFrom<Skill>, IHaveCustomMappings
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public Level Level { get; set; }

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<Skill, SkillViewModel>()
                .ReverseMap();
        }
    }
}