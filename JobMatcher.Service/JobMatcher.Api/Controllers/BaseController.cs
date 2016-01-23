namespace JobMatcher.Service.Controllers
{
    using System.Linq;
    using System.Web.Http;

    using JobMatcher.Data.Contracts;
    using JobMatcher.Models;

    //[Authorize]
    public class BaseController : ApiController
    {
        protected IJobMatcherData data;

        public BaseController(IJobMatcherData data)
        {
            this.data = data;
            this.CurrentUser = this.data.Users.All().FirstOrDefault(u => u.UserName == this.User.Identity.Name);
        }

        protected User CurrentUser { get; private set; }
    }
}