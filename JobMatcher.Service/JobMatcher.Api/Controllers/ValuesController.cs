using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using JobMatcher.Data.Contracts;

namespace JobMatcher.Service.Controllers
{
    public class ValuesController : BaseController
    {
        static List<string> data = new List<string> { "value1", "value2" };

        public ValuesController(IJobMatcherData data)
            : base(data)
        {
        }

        // GET api/values
        public IEnumerable<string> Get()
        {
            return data;
        }

        // GET api/values/5
        public string Get(int id)
        {
            return "value";
        }

        // POST api/values
        public void Post([FromBody]string value)
        {
            data.Add(value);
        }

        // PUT api/values/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/values/5
        public void Delete(int id)
        {
        }
    }
}
