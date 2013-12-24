using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DotNetOpenAuth.OpenId.RelyingParty;
using SocialPirates.Blackbeard.Site.Models;

namespace SocialPirates.Blackbeard.Site.Security
{
    public interface IOpenIdMembershipService
    {
        IAuthenticationRequest ValidateAtOpenIdProvider(string openIdIdentifier);
        OpenIdUser GetUser();
    }
}