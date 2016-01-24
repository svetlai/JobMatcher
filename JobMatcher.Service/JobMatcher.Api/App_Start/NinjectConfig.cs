namespace JobMatcher.Service.App_Start
{
    using System;
    using System.Data.Entity;
    using System.Reflection;

    using Ninject;
    using Ninject.Web.Common;

    using JobMatcher.Data;
    using JobMatcher.Data.Contracts;
    using JobMatcher.Data.Repositories;

    public class NinjectConfig
    {
        public static Lazy<IKernel> CreateKernel = new Lazy<IKernel>(() =>
        {
            var kernel = new StandardKernel();
            kernel.Load(Assembly.GetExecutingAssembly());

            RegisterServices(kernel);

            return kernel;
        });

        /// <summary>
        /// Load your modules or register your services here!
        /// </summary>
        /// <param name="kernel">The kernel.</param>
        private static void RegisterServices(IKernel kernel)
        {
            kernel.Bind(typeof(IRepository<>)).To(typeof(GenericRepository<>));
            kernel.Bind<DbContext>().To<JobMatcherDbContext>().InRequestScope();
            kernel.Bind<IJobMatcherDbContext>().To<JobMatcherDbContext>();
            kernel.Bind<IJobMatcherData>().To<JobMatcherData>().WithConstructorArgument("db", context => new JobMatcherDbContext()); ;
        }   
    }
}