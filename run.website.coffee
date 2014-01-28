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
	'odo/plugins'
	'odo/express/plugin'
	'odo/bower/plugin'
	'odo/durandal/plugin'
	'odo/auth/plugin'
	'odo/auth/twitter'
	'odo/auth/facebook'
	'odo/auth/google'
	'odo/auth/local'
	'odo/messaging/plugin'
	'odo/public/plugin'
	'local/welcome/plugin'
	'local/auth/plugin'
	'local/email/plugin'
	'local/user/plugin'
	'local/feedback/plugin'
	'local/lunchboxslab/plugin'
], (Plugins, Express, plugins...) ->
	
	new Plugins(plugins).web()
	new Express().start()