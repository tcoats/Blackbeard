using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SocialPirates.Blackbeard.Data.Entities;
using StaticVoid.Core.Repository;

namespace SocialPirates.Blackbeard.Data.WriteStrategies
{
	public class UserPersister : IPersistUsers
	{
		private readonly IRepository<User>  _userRepository;
		public UserPersister(IRepository<User> userRepository)
		{
			_userRepository = userRepository;
		}

		public void EnsureUser(User user)
		{
			var existingUser = _userRepository.GetBy(u => u.ClaimedIdentifier == user.ClaimedIdentifier);
			if (existingUser == null)
			{
				_userRepository.Create(user);
			}
			else//update existing deets
			{
				existingUser.Email = user.Email;
				existingUser.FirstName = user.FirstName;
				existingUser.LastName = user.LastName;
				_userRepository.Update(existingUser);
			}
		}
	}
}
