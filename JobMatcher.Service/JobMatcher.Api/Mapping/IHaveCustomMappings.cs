using AutoMapper;

namespace JobMatcher.Service.Mapping
{
    public interface IHaveCustomMappings
    {
        void CreateMappings(IConfiguration configuration);
    }
}
