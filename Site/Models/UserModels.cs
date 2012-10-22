using SocialPirates.Blackbeard.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SocialPirates.Blackbeard.Site.Gravitar;

namespace SocialPirates.Blackbeard.Site.Models
{
    public class UserFlairModel
    {
        public UserFlairModel() { }
        public UserFlairModel(User user)
        {
            Id = user.Id;
            GravatarUrl = user.Email.GravitarUrlFromEmail();
            Name = String.Format("{0} {1}", user.FirstName, user.LastName);
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string GravatarUrl { get; set; }
    }
}