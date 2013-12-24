using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Principal;
using System.Text;
using System.Web;
using SocialPirates.Blackbeard.Site.Models;
using SocialPirates.Blackbeard.Site.Gravitar;

namespace SocialPirates.Blackbeard.Site.Security
{
    public class OpenIdIdentity : IIdentity
    {
        private readonly OpenIdUser _user;
		private readonly string _gravatarUrl;

        public OpenIdIdentity(OpenIdUser user)
        {
            _user = user;
            _gravatarUrl = user.Email.GravitarUrlFromEmail();
        }

        public OpenIdUser OpenIdUser
        {
            get
            {
                return _user;
            }
        }

        public string AuthenticationType
        {
            get
            {
                return "OpenID Identity";
            }
        }

        public bool IsAuthenticated
        {
            get
            {
                return true;
            }
        }

        public string Name
        {
            get
            {
                return _user.Nickname ?? string.Empty;
            }
        }

		public string GravatarUrl
		{
			get
			{
				return _gravatarUrl;
			}
		}
    }
}