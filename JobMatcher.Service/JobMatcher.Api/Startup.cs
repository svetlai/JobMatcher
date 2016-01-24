using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Reflection;
using System.Web.Http;
using JobMatcher.Data;
using JobMatcher.Data.Contracts;
using JobMatcher.Data.Repositories;
using JobMatcher.Service.App_Start;
using Microsoft.Owin;
using Newtonsoft.Json;
using Ninject;
using Ninject.Web.Common;
using Ninject.Web.Common.OwinHost;
using Ninject.Web.WebApi.OwinHost;
using Owin;

[assembly: OwinStartup(typeof(JobMatcher.Service.Startup))]

namespace JobMatcher.Service
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);

            var config = new HttpConfiguration();
            WebApiConfig.Register(config);
            app.UseNinjectMiddleware(() => NinjectConfig.CreateKernel.Value);
            app.UseNinjectWebApi(config);

            config.Formatters.JsonFormatter.SerializerSettings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
        }
    }
}
