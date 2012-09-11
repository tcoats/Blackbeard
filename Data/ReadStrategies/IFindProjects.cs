using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SocialPirates.Blackbeard.Data.Entities;

namespace SocialPirates.Blackbeard.Data.ReadStrategies
{
	public interface IFindProjects
	{
		IEnumerable<Project> All();
		IEnumerable<Project> FindByUser(int userId);
	}
}
