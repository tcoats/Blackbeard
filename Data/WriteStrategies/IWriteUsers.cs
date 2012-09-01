using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SocialPirates.Blackbeard.Data.Entities;

namespace SocialPirates.Blackbeard.Data.WriteStrategies
{
	public interface IWriteUsers
	{
		void EnsureUser(User user);
	}
}
