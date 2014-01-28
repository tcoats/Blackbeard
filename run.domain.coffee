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
	'odo/plugins'
	'odo/user/plugin'
	'local/feedback/plugin'
	# add more command handlers here
], (Plugins, plugins...) ->
	
	new Plugins(plugins).domain()