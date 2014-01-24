requirejs = require 'requirejs'

# requirejs
requirejs.config {
		# Pass the top-level main.js/index.js require
		# function to requirejs so that node modules
		# are loaded relative to the top-level JS file.
		nodeRequire: require
		paths: {
			odo: './node_modules/odo'
			local: './'
		}
}

requirejs [
	'odo/infra/hub'
	'odo/user/userprofile'
	'odo/auth/plugin'
	'odo/auth/twitter'
	'odo/auth/facebook'
	'odo/auth/google'
	'odo/auth/local'
	'local/email/plugin'
	'local/user/plugin'
	'local/feedback/plugin'
	# add more event listeners here
], (hub, plugins...) ->
	
	# construct classes
	plugins = plugins.map (plugin) ->
		if typeof(plugin) is 'function'
			return new plugin
		plugin
	
	for plugin in plugins
		if plugin.projection?
			plugin.projection()