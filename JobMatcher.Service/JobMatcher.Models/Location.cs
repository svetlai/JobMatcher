namespace JobMatcher.Models
{
    using System.ComponentModel.DataAnnotations;

    // TODO remove city/country?
    public class Location
    {
        [Key]
        public int Id { get; set; }

        public string Latitude { get; set; }

        public string Longtitude { get; set; }

        [StringLength(50)]
        public string Country { get; set; }

        [StringLength(50)]
        public string City { get; set; }

        [StringLength(10)]
        public string PostCode { get; set; }
    }
}
