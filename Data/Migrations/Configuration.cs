namespace SocialPirates.Blackbeard.Data.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;

    public class Configuration : DbMigrationsConfiguration<SocialPirates.Blackbeard.Data.BlackbeardContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = true;
        }

        protected override void Seed(SocialPirates.Blackbeard.Data.BlackbeardContext context)
        {
        }
    }
}
