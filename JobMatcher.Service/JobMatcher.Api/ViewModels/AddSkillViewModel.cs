using JobMatcher.Models;
using JobMatcher.Service.Mapping;

namespace JobMatcher.Service.ViewModels
{
    public class AddSkillViewModel : IMapFrom<Skill>, IHaveCustomMappings
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public int Level { get; set; }

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<Skill, AddSkillViewModel>()
                .ForMember(m => m.Level, opt => opt.MapFrom(x => (int)x.Level))
                .ReverseMap();
        }
    }
}