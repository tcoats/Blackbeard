using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Text;

namespace SocialPirates.Blackbeard.Data
{
	public class BlackbeardContext : DbContext
	{
		public BlackbeardContext() : base("SocialPirates.Blackbeard") { }

		public DbSet<User> Users { get; set; }
		public DbSet<Project> Projects { get; set; }
		public DbSet<Measure> Measures { get; set; }

		protected override void OnModelCreating(DbModelBuilder modelBuilder)
		{
			modelBuilder.Entity<Project>().HasMany(p => p.Conceivers).WithMany().Map(m=>{
				m.ToTable("ProjectConeivers");
				m.MapLeftKey("ProjectId");
				m.MapRightKey("UserId");
			});
			modelBuilder.Entity<Project>().HasMany(p => p.Contributors).WithMany().Map(m=>{
				m.ToTable("ProjectContributers");
				m.MapLeftKey("ProjectId");
				m.MapRightKey("UserId");
			});
		}
	}
}
