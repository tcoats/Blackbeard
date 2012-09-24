using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SocialPirates.Blackbeard.Site.Models
{
	public class ProjectModel
	{
		public int Id { get; set; }
		public String Name { get; set; }
	}

	public class ProjectsModel
	{
		public IEnumerable<ProjectModel> Projects { get; set; }
	}
}