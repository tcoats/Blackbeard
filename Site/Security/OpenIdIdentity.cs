using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Security.Principal;
using System.Text;
using System.Web;
using SocialPirates.Blackbeard.Site.Models;

namespace SocialPirates.Blackbeard.Site.Security
{
    public class OpenIdIdentity : IIdentity
    {
        private readonly OpenIdUser _user;
		private readonly string _gravatarUrl;

        public OpenIdIdentity(OpenIdUser user)
        {
            _user = user;

			var md5 = MD5.Create();
			var hashedEmail = BitConverter.ToString(md5.ComputeHash(new UTF8Encoding().GetBytes(user.Email.Trim().ToLower()))).Replace("-","").ToLower();

			_gravatarUrl = String.Format("http://www.gravatar.com/avatar/{0}", hashedEmail);
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