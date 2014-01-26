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
	'odo/messaging/hub'
	'odo/user/usercommands'
	'local/feedback/feedbackcommands'
	# add more command handlers here
], (hub, plugins...) ->
	
	# construct classes
	plugins = plugins.map (plugin) ->
		if typeof(plugin) is 'function'
			return new plugin
		plugin
	
	for plugin in plugins
		if plugin.domain?
			plugin.domain()