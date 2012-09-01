using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;
using SocialPirates.Blackbeard.Data.Entities;

namespace SocialPirates.Blackbeard.Data
{
	public class BlackbeardContext : DbContext
	{
		public BlackbeardContext() : base("SocialPirates.Blackbeard") { }

		public DbSet<User> Users { get; set; }

		protected override void OnModelCreating(DbModelBuilder modelBuilder)
		{
			modelBuilder.Entity<User>().HasKey(u => u.ClaimedIdentifier);
		}
	}
}
