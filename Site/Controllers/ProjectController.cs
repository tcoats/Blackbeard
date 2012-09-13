using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SocialPirates.Blackbeard.Site.Security;

namespace SocialPirates.Blackbeard.Site.Controllers
{
    public class ProjectController : Controller
	{
		public ProjectController()
		{
		}

		[OpenIdAuthorize]
		public ActionResult Index()
		{
			return View();
		}

		[OpenIdAuthorize]
        public ActionResult MyProjects(int userId)
        {
            return View();
        }

		[OpenIdAuthorize]
		public ActionResult New()
		{
			return View();
		}

		[OpenIdAuthorize]
		public ActionResult Edit(int projectId)
		{
			return View();
		}

		[OpenIdAuthorize]
		public ActionResult Delete(int projectId)
		{
			return View();
		}
    }
}
