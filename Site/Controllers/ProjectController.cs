using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SocialPirates.Blackbeard.Data;
using SocialPirates.Blackbeard.Site.Models;
using SocialPirates.Blackbeard.Site.Security;
using StaticVoid.Core.Repository;

namespace SocialPirates.Blackbeard.Site.Controllers
{
	public class ProjectController : Controller
	{
		private readonly IRepository<Project> _projectRepository;
		public ProjectController(IRepository<Project> projectRepository)
		{
			_projectRepository = projectRepository;
		}

		[OpenIdAuthorize]
		public ActionResult Index()
		{
			return View(new ProjectsModel
			{
				Projects = _projectRepository.GetAll().Select(p => new ProjectModel { Id = p.Id, Name = p.Name })
			});
		}

		[OpenIdAuthorize]
		public ActionResult Display(int id)
		{
			var proj = _projectRepository.GetById(id);

			if (proj == null)
			{
				return new HttpNotFoundResult();
			}

			return View(new ProjectModel { Id = proj.Id, Name = proj.Name });
		}

		[OpenIdAuthorize]
		public ActionResult MyProjects(int userId)
		{
			return View(new ProjectsModel
			{
				Projects = _projectRepository.GetByUser(userId).Select(p => new ProjectModel { Id = p.Id, Name = p.Name })
			});
		}

		[OpenIdAuthorize]
		public ActionResult Create()
		{
            return PartialView();
		}

		[HttpPost]
		[OpenIdAuthorize]
		public ActionResult Create(ProjectModel project)
		{
			if (ModelState.IsValid)
			{
				var proj = new Project { Name = project.Name, Conception = DateTime.Now, Conceivers = new List<User> { } };
				_projectRepository.Create(proj);
                return Json(new { success = true });
			}
            return PartialView(project);
		}

		[OpenIdAuthorize]
		public ActionResult Edit(int id)
		{
			var proj = _projectRepository.GetById(id);

			if (proj == null)
			{
				return new HttpNotFoundResult();
			}

			return View(new ProjectModel { Id = proj.Id, Name = proj.Name });
		}

		[HttpPost]
		[OpenIdAuthorize]
		public ActionResult Edit(ProjectModel model)
		{
			if (ModelState.IsValid)
			{
				var proj = _projectRepository.GetById(model.Id);
				proj.Name = model.Name;
				_projectRepository.Update(proj);
				return RedirectToAction("Display", new { id = proj.Id });
			}
			return View(model);
		}

		[OpenIdAuthorize]
		public ActionResult Delete(int id)
		{
			return View();
		}
	}
}
