using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SocialPirates.Blackbeard.Site.Models
{
	public class ProjectEditModel
	{
		public int Id { get; set; }
		[Required]
        public String Name { get; set; }
        [Required, Display(Name="Description")]
        public String DescriptionMarkdown { get; set; }
	}

    public class ProjectDisplayModel
    {
        public int Id { get; set; }
        public DateTime Conception { get; set; }
        public String Name { get; set; }
        public String Description { get; set; }
        public List<UserFlairModel> Conceivers { get; set; }
    }
}