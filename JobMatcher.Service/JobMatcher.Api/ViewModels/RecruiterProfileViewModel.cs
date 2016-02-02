using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using JobMatcher.Models;
using JobMatcher.Service.Mapping;

namespace JobMatcher.Service.ViewModels
{
    public class RecruiterProfileViewModel : IMapFrom<RecruiterProfile>, IHaveCustomMappings
    {
        public int RecruiterProfileId { get; set; }

        public string Username { get; set; }

        public string Email { get; set; }

        public ProfileType ProfileType { get; set; }

        public virtual ICollection<JobOfferViewModel> JobOffers { get; set; }

        public virtual ICollection<Match> Matches { get; set; }

        public virtual ICollection<Message> Messages { get; set; } 

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<RecruiterProfile, RecruiterProfileViewModel>()
                .ForMember(m => m.Username, opt => opt.MapFrom(x => x.User.UserName))
                .ForMember(m => m.Email, opt => opt.MapFrom(x => x.User.Email))
                .ForMember(m => m.ProfileType, opt => opt.MapFrom(x => x.User.ProfileType))
                .ReverseMap();
        }
    }
}