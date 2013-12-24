using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SocialPirates.Blackbeard.Data
{
    public class Project
    {
        public int Id { get; set; }
		public string Name { get; set; }
        public string Description { get; set; }
        public string DescriptionMarkdown { get; set; }
        public DateTime Conception { get; set; }
		public ICollection<User> Conceivers { get; set; }
        public ICollection<User> Contributors { get; set; }
    }
}
