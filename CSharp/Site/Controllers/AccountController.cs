﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using SocialPirates.Blackbeard.Site.Models;
using SocialPirates.Blackbeard.Site.Security;
using DotNetOpenAuth.Messaging;
using SocialPirates.Blackbeard.Data;
using StaticVoid.Core.Repository;

namespace SocialPirates.Blackbeard.Site.Controllers
{

    [Authorize]
    public class AccountController : Controller
    {
        private readonly OpenIdMembershipService _openIdMembership;
		private readonly IRepository<User> _userRepository;

        public AccountController(OpenIdMembershipService membershipService, IRepository<User> userRepository)
        {
            _openIdMembership = membershipService;
			_userRepository = userRepository;
        }

        [AllowAnonymous]
        public ActionResult Login()
        {
            var user = _openIdMembership.GetUser();
            if (user != null)
            {
				_userRepository.EnsureUser(new User
				{
					ClaimedIdentifier = user.ClaimedIdentifier,
					Email = user.Email,
					FirstName = user.FullName.Split(' ').First(),
					LastName = user.FullName.Split(' ').Last(),
				});

                var cookie = _openIdMembership.CreateFormsAuthenticationCookie(user);
                HttpContext.Response.Cookies.Add(cookie);

                return new RedirectResult(Request.Params["ReturnUrl"] ?? "/");
            }
            return View();
        }

        [AllowAnonymous]
        [HttpPost]
        public ActionResult Login(string openid_identifier)
        {
            var response = _openIdMembership.ValidateAtOpenIdProvider(openid_identifier);

            if (response != null)
            {
                return response.RedirectingResponse.AsActionResult();
            }

            return View();
        }

        public ActionResult LogOff()
        {
            FormsAuthentication.SignOut();

            return RedirectToAction("Index", "Home");
        }
    }
}
