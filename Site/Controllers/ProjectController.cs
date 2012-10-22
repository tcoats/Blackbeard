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
            return View(_projectRepository.GetAll().Select(p => new ProjectDisplayModel { Id = p.Id, Name = p.Name }));
        }

        [OpenIdAuthorize]
        public ActionResult Display(int id)
        {
            var proj = _projectRepository.GetById(id,p=>p.Conceivers);

            if (proj == null)
            {
                return new HttpNotFoundResult();
            }

            return View(new ProjectDisplayModel
            {
                Id = proj.Id,
                Name = proj.Name,
                Description = proj.Description,
                Conception = proj.Conception,
                Conceivers = proj.Conceivers.Select(u => new UserFlairModel(u)).ToList()
            });
        }

        [OpenIdAuthorize]
        public ActionResult MyProjects(int userId)
        {
            return View(_projectRepository.GetByUser(userId).Select(p => new ProjectDisplayModel { Id = p.Id, Name = p.Name }));
        }

        [OpenIdAuthorize]
        public ActionResult Create()
        {
            return PartialView("EditModal");
        }

        [HttpPost, ValidateInput(false)]
        [OpenIdAuthorize]
        public ActionResult Create(ProjectEditModel project)
        {
            if (ModelState.IsValid)
            {
                var md = new MarkdownSharp.Markdown();
                var proj = new Project
                {
                    Name = project.Name,
                    Description = md.Transform(project.DescriptionMarkdown),//TODO sanitise, see jeff atwoods sanitizer http://refactormycode.com/codes/333-sanitize-html (its currently offline)
                    DescriptionMarkdown = project.DescriptionMarkdown,
                    Conception = DateTime.Now,
                    Conceivers = new List<User> { }
                };
                _projectRepository.Create(proj);
                return Json(new { success = true });
            }
            return PartialView("EditModal", project);
        }

        [OpenIdAuthorize]
        public ActionResult Edit(int id)
        {
            var proj = _projectRepository.GetById(id);

            if (proj == null)
            {
                return new HttpNotFoundResult();
            }

            return PartialView("EditModal", new ProjectEditModel
            {
                Id = proj.Id,
                Name = proj.Name,
                DescriptionMarkdown = proj.DescriptionMarkdown,
            });
        }

        [HttpPost, ValidateInput(false)]
        [OpenIdAuthorize]
        public ActionResult Edit(ProjectEditModel model)
        {
            var md = new MarkdownSharp.Markdown();
            if (ModelState.IsValid)
            {
                var proj = _projectRepository.GetById(model.Id);
                proj.Name = model.Name;
                //TODO sanitise, see Jeff Atwoods sanitizer http://refactormycode.com/codes/333-sanitize-html (its currently offline)
                proj.Description = md.Transform(model.DescriptionMarkdown);
                proj.DescriptionMarkdown = model.DescriptionMarkdown;
                _projectRepository.Update(proj);
                return Json(new { success = true });
            }
            return PartialView("EditModal", model);
        }

        [OpenIdAuthorize]
        public ActionResult Delete(int id)
        {
            return View();
        }
    }
}
