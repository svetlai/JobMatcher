﻿using System.ComponentModel.DataAnnotations.Schema;
using JobMatcher.Common.Contracts;

namespace JobMatcher.Models
{
    using System;

    public class Education : IDeletable
    {
        public int Id { get; set; }

        public Degree Degree { get; set; }

        public string Specialty { get; set; }

        public int OrganizationId { get; set; }

        public virtual Organization Organization { get; set; }

        public Industry Industry { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime? EndDate { get; set; }

        public string Description { get; set; }

        public virtual JobSeekerProfile JosSeekerProfile { get; set; }

        public bool IsDeleted { get; set; }
    }
}
