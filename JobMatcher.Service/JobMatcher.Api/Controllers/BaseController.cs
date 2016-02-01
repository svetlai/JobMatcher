namespace JobMatcher.Service.Controllers
{
    using System.Linq;
    using System.Web.Http;

    using JobMatcher.Data.Contracts;
    using JobMatcher.Models;

    [Authorize]
    public class BaseController : ApiController
    {
        protected IJobMatcherData data;
        private string currentUserId;

        public BaseController(IJobMatcherData data)
        {
            this.data = data;
            //this.CurrentUser = this.data.Users.All().FirstOrDefault(u => u.UserName == this.User.Identity.Name);
        }

        protected string CurrentUserId
        {
            get
            {
                if (string.IsNullOrEmpty(this.currentUserId))
                {
                    this.currentUserId = this.data.Users
                        .All()
                        .Where(x => x.UserName == this.User.Identity.Name)
                        .Select(x => x.Id)
                        .FirstOrDefault();
                }

                return this.currentUserId;
            }
        }

        //protected User CurrentUser { get; private set; }
    }
}