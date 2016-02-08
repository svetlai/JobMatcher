using JobMatcher.Common.Contracts;

namespace JobMatcher.Models
{
    using System.ComponentModel.DataAnnotations;

    // TODO remove city/country?
    public class Location : IDeletable
    {
        [Key]
        public int Id { get; set; }

        public string Latitude { get; set; }

        public string Longitude { get; set; }

        [StringLength(50)]
        public string Country { get; set; }

        [StringLength(50)]
        public string City { get; set; }

        [StringLength(10)]
        public string PostCode { get; set; }

        public bool IsDeleted { get; set; }
    }
}
