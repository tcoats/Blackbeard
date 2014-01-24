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

process.env.PORT = 4834

requirejs [
	'odo/express/plugin'
	'odo/bower/plugin'
	'odo/durandal/plugin'
	'odo/auth/plugin'
	'odo/auth/twitter'
	'odo/auth/facebook'
	'odo/auth/google'
	'odo/auth/local'
	'odo/sendcommand/plugin'
	'odo/public/plugin'
	'local/welcome/plugin'
	'local/auth/plugin'
	'local/email/plugin'
	'local/user/plugin'
	'local/feedback/plugin'
], (Express, plugins...) ->
	
	# construct plugins
	plugins = plugins.map (plugin) ->
		if typeof(plugin) is 'function'
			return new plugin
		plugin
	
	for plugin in plugins
		if plugin.web?
			plugin.web()
	
	new Express().start()