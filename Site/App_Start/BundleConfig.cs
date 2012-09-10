using System.Web;
using System.Web.Optimization;

namespace SocialPirates.Blackbeard.Site
{
	public class BundleConfig
	{
		public static void RegisterBundles(BundleCollection bundles)
		{
			bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
						"~/Scripts/jquery-1.*"));

			bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
						"~/Scripts/jquery-ui*"));

			bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
						"~/Scripts/jquery.unobtrusive*",
						"~/Scripts/jquery.validate*"));

			bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
						"~/Scripts/modernizr-*"));

			bundles.Add(new ScriptBundle("~/bundles/openid").Include(
						"~/Scripts/openid-jquery.js",
						"~/Scripts/openid-en.js"));

			bundles.Add(new ScriptBundle("~/bundles/less").Include(
						"~/Scripts/less-1.*"));

			bundles.Add(new ScriptBundle("~/bundles/coffeescript").Include(
						"~/Scripts/coffee-script.js"));

			bundles.Add(new ScriptBundle("~/bundles/underscore").Include(
						"~/Scripts/underscore-min.js"));

			bundles.Add(new ScriptBundle("~/bundles/knockout").Include(
						"~/Scripts/knockout-2.*"));

			bundles.Add(new ScriptBundle("~/bundles/backbone").Include(
						"~/Scripts/backbone-*"));

			bundles.Add(new ScriptBundle("~/bundles/knockback").Include(
						"~/Scripts/knockback.min.js"));

			bundles.Add(new ScriptBundle("~/bundles/gridster").Include(
						"~/Scripts/jquery.gridster.min.js"));

			bundles.Add(new ScriptBundle("~/bundles/dragdealer").Include(
						"~/Scripts/dragdealer.js"));

			bundles.Add(new ScriptBundle("~/bundles/pminject").Include(
						"~/Scripts/pminject.coffee"));

			bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
						"~/Scripts/bootstrap.min.js"));

			bundles.Add(new StyleBundle("~/Content/css/openid").Include(
						"~/Content/openid-shadow.css",
						"~/Content/openid.css"));

			bundles.Add(new StyleBundle("~/Content/sliders").Include(
						"~/Content/jquery.gridster.min.css",
						"~/Content/dragdealer.less"));

			bundles.Add(new StyleBundle("~/Content/style").Include(
						"~/Content/blackbeard.less",
						"~/Content/bootstrap.min.css",
						"~/Content/bootstrap-responsive.min.css"));

			bundles.Add(new StyleBundle("~/Content/style").Include("~/Content/blackbeard.less"));

			bundles.Add(new StyleBundle("~/Content/themes/base/css").Include(
						"~/Content/themes/base/jquery.ui.core.css",
						"~/Content/themes/base/jquery.ui.resizable.css",
						"~/Content/themes/base/jquery.ui.selectable.css",
						"~/Content/themes/base/jquery.ui.accordion.css",
						"~/Content/themes/base/jquery.ui.autocomplete.css",
						"~/Content/themes/base/jquery.ui.button.css",
						"~/Content/themes/base/jquery.ui.dialog.css",
						"~/Content/themes/base/jquery.ui.slider.css",
						"~/Content/themes/base/jquery.ui.tabs.css",
						"~/Content/themes/base/jquery.ui.datepicker.css",
						"~/Content/themes/base/jquery.ui.progressbar.css",
						"~/Content/themes/base/jquery.ui.theme.css"));
		}
	}
}