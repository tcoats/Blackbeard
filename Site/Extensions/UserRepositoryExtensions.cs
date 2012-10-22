using SocialPirates.Blackbeard.Data;
using StaticVoid.Core.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SocialPirates.Blackbeard.Site
{
    public static class UserRepositoryExtensions
    {
        public static User GetCurrentUser(this IRepository<User> repo)
        {
            var currentUser = SecurityHelper.CurrentUser;

            if (currentUser != null && !String.IsNullOrWhiteSpace(currentUser.Email))
            {
                return repo.GetBy(u => u.Email == currentUser.Email);
            }

            return null;
        }
    }
}