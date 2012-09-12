[assembly: WebActivator.PreApplicationStartMethod(typeof(SocialPirates.Blackbeard.Site.App_Start.EntityFrameworkConfiguration), "Start")]

namespace SocialPirates.Blackbeard.Site.App_Start
{
	using System;
	using System.Collections.Generic;
	using System.Data.Entity;
	using System.Linq;
	using System.Web;
	using SocialPirates.Blackbeard.Data;
	using SocialPirates.Blackbeard.Data.Migrations;

	public class EntityFrameworkConfiguration
	{
		/// <summary>
		/// Starts the application
		/// </summary>
		public static void Start()
		{
			Database.SetInitializer(new MigrateDatabaseToLatestVersion<BlackbeardContext, Configuration>());
		}

	}
}