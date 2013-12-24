using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;

namespace SocialPirates.Blackbeard.Site.App_Start.BundleTransforms
{
	public class LessBundle : Bundle
	{
		public LessBundle(string virtualPath)
			: base(virtualPath)
		{
			this.Transforms.Add(new LessTransform());
			//this.Transforms.Add(new CssMinify());
		}
	}
}