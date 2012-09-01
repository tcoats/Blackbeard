using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocialPirates.Blackbeard.Data.Entities
{
	public class User
	{
		//PK
		public string ClaimedIdentifier { get; set; }
		public string FirstName { get; set; }
		public string LastName { get; set; }
		public string Email { get; set; }
	}
}
