using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SocialPirates.Blackbeard.Data.Entities;
using StaticVoid.Core.Repository;

namespace SocialPirates.Blackbeard.Data.ReadStrategies
{
	public class ProjectFinder:IFindProjects
	{
		private readonly IRepository<Project> _projectRepository;
		public ProjectFinder(IRepository<Project> projectRepository)
		{
			_projectRepository = projectRepository;
		}

		public IEnumerable<Project> All()
		{
			return _projectRepository.GetAll().AsEnumerable();
		}

		public IEnumerable<Project> FindByUser(int userId)
		{
			return _projectRepository.GetAll()
				.Where(p => p.Conceivers.Any(c => c.Id == userId) || p.Contributors.Any(c => c.Id == userId))
				.AsEnumerable();
		}
	}
}
