using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using JobMatcher.Models;
using JobMatcher.Service.Mapping;

namespace JobMatcher.Service.ViewModels
{
    public class EditJobSeekerProfileViewModel : IMapFrom<JobSeekerProfile>, IHaveCustomMappings
    {
        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string PhoneNumber { get; set; }

        public string CurrentPosition { get; set; }

        public string Summary { get; set; }

        public virtual Image Image { get; set; }

        public void CreateMappings(AutoMapper.IConfiguration configuration)
        {
            configuration.CreateMap<JobSeekerProfile, EditJobSeekerProfileViewModel>()
                .ReverseMap();
        }
    }
}