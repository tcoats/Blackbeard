using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using Ninject.Modules;
using StaticVoid.Core.Repository;

namespace SocialPirates.Blackbeard.Data
{
	public class PersistanceModule : NinjectModule
	{
		public override void Load()
		{
			Bind<DbContext>().To<BlackbeardContext>();
			Bind(typeof(IRepositoryDataSource<>)).To(typeof(DbContextRepositoryDataSource<>));
			Bind(typeof(IRepository<>)).To(typeof(SimpleRepository<>));
		}
	}
}
