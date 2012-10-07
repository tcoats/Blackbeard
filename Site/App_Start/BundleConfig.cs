using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using SocialPirates.Blackbeard.Site.App_Start.BundleTransforms;

namespace SocialPirates.Blackbeard.Site
{
	public class BundleConfig
	{
		public static void RegisterBundles(BundleCollection bundles)
		{
			bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
						"~/Scripts/jquery-1.8.1.js"));

			bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
						"~/Scripts/jquery-ui-1.8.11.js"));

			bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
						"~/Scripts/jquery.unobtrusive-ajax.js",
						"~/Scripts/jquery.validate.js",
						"~/Scripts/jquery.validate.unobtrusive.js"));

			bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
						"~/Scripts/modernizr-*"));

			bundles.Add(new ScriptBundle("~/bundles/openid").Include(
						"~/Scripts/openid-jquery.js",
						"~/Scripts/openid-en.js"));
			
			bundles.Add(new ScriptBundle("~/bundles/coffeescript").Include(
						"~/Scripts/coffee-script.js"));

			bundles.Add(new ScriptBundle("~/bundles/underscore").Include(
						"~/Scripts/underscore.js"));

			bundles.Add(new ScriptBundle("~/bundles/knockout").Include(
						"~/Scripts/knockout-2.1.0.js"));

			bundles.Add(new ScriptBundle("~/bundles/backbone").Include(
						"~/Scripts/backbone.js"));

			bundles.Add(new ScriptBundle("~/bundles/knockback").Include(
						"~/Scripts/knockback.js"));

			bundles.Add(new ScriptBundle("~/bundles/gridster").Include(
						"~/Scripts/jquery.gridster.js"));

			bundles.Add(new ScriptBundle("~/bundles/dragdealer").Include(
						"~/Scripts/dragdealer.js"));

			bundles.Add(new ScriptBundle("~/bundles/pminject").Include(
						"~/Scripts/pminject.coffee"));

			bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
						"~/Scripts/bootstrap.js"));

			bundles.Add(new StyleBundle("~/Content/css/openid").Include(
						"~/Content/openid-shadow.css",
						"~/Content/openid.css"));

			bundles.Add(new LessBundle("~/Content/sliders").Include(
						"~/Content/jquery.gridster.css",
						"~/Content/dragdealer.less"
						));

			bundles.Add(new LessBundle("~/Content/style").Include(		
						"~/Content/blackbeard.less",
						"~/Content/bootstrap.css",
						"~/Content/bootstrap-responsive.css"));

		}
	}
}