using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity.ModelConfiguration.Conventions;

namespace JobMatcher.Models
{
    using System;
    using System.ComponentModel.DataAnnotations;

    public class Image
    {
        public Image()
        {
            this.Id = Guid.NewGuid();
        }

        [Key]
        public Guid Id { get; set; }

        public byte[] Content { get; set; }

        public string FileExtension { get; set; }

        public string Path { get; set; }

        public int JobSeekerProfileId { get; set; }
    }
}
