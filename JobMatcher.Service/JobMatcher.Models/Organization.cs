using System.ComponentModel.DataAnnotations;
using JobMatcher.Common.Contracts;

namespace JobMatcher.Models
{
    public class Organization : IDeletable
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(150)]
        public string Name { get; set; }

        public Industry Industry { get; set; }

        public bool IsDeleted { get; set; }

        //public int LocationId { get; set; }

        //public virtual Location Location { get; set; }
    }
}