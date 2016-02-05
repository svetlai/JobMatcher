using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using JobMatcher.Models;
using JobMatcher.Service.Mapping;

namespace JobMatcher.Service.ViewModels
{
    public class JobSeekerProfileViewModel : IMapFrom<JobSeekerProfile>, IHaveCustomMappings
    {
        [Key]
        public int JobSeekerProfileId { get; set; }

        public string Username { get; set; }

        public string Email { get; set; }

        public ProfileType ProfileType { get; set; }

        public string Summary { get; set; }

        public virtual Image Image { get; set; }

        public virtual ICollection<ExperienceViewModel> Experience { get; set; }

        public virtual ICollection<EducationViewModel> Education { get; set; }

        public virtual ICollection<ProjectViewModel> Projects { get; set; }

        public virtual ICollection<SkillViewModel> Skills { get; set; }

        public virtual ICollection<JobOfferViewModel> SelectedJobOffers { get; set; }

        public virtual ICollection<Match> Matches { get; set; }

        public virtual ICollection<MessageViewModel> Messages { get; set; } 

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<JobSeekerProfile, JobSeekerProfileViewModel>()
                .ForMember(m => m.Username, opt => opt.MapFrom(x => x.User.UserName))
                .ForMember(m => m.Email, opt => opt.MapFrom(x => x.User.Email))
                .ForMember(m => m.ProfileType, opt => opt.MapFrom(x => x.User.ProfileType))
                .ReverseMap();
        }
    }
}