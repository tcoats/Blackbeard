using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SocialPirates.Blackbeard.Data.ReadStrategies;
using SocialPirates.Blackbeard.Site.Models;
using SocialPirates.Blackbeard.Site.Security;

namespace SocialPirates.Blackbeard.Site.Controllers
{
    public class ProjectController : Controller
	{
		private readonly IFindProjects _projectFinder;
		public ProjectController(IFindProjects projectFinder)
		{
			_projectFinder = projectFinder;
		}

		[OpenIdAuthorize]
		public ActionResult Index()
		{
			return View();
		}

		[OpenIdAuthorize]
        public ActionResult MyProjects(int userId)
        {
			return View(new ProjectsModel
			{
				 Projects = _projectFinder.FindByUser(userId).Select(p=> new ProjectModel{ Id= p.Id, Name = p.Name})
			});
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
