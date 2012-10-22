using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StaticVoid.Core.Repository;
using System.Linq.Expressions;

namespace SocialPirates.Blackbeard.Data
{
	public static class ProjectRepositoryExtensions
	{
		public static IEnumerable<Project> GetByUser(this IRepository<Project> repository, int userId)
		{
			return repository.GetAll()
				.Where(p => p.Conceivers.Any(c => c.Id == userId) || p.Contributors.Any(c => c.Id == userId))
				.AsEnumerable();
		}

        public static Project GetById(this IRepository<Project> repository, int id, params Expression<Func<Project, object>>[] includes)
		{
            return repository.GetBy(p => p.Id == id, includes);
		}
	}
}
