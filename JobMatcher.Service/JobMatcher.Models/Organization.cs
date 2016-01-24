using System.ComponentModel.DataAnnotations;

namespace JobMatcher.Models
{
    public class Organization
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [StringLength(150)]
        public string Name { get; set; }

        public Industry Industry { get; set; }

        //public int LocationId { get; set; }

        //public virtual Location Location { get; set; }
    }
}