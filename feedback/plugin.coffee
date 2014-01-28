define [
	'module'
	'odo/express/configure'
	'odo/durandal/plugin'
	'odo/plugins'
	'local/feedback/feedback-opportunity-commands'
	'local/feedback/user-feedback-widget'
	'local/feedback/view-feedback-opportunity'
], (module, configure, durandal, Plugins, plugins...) ->
	class FeedbackPlugin
		web: =>
			configure.route '/views/feedback', configure.modulepath(module.uri) + '/views'
			durandal.register 'views/feedback/bindings'
			
			new Plugins(plugins).web()
			
		domain: =>
			new Plugins(plugins).domain()
			
		projection: =>
			new Plugins(plugins).projection()