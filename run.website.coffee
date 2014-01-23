requirejs = require 'requirejs'

# requirejs
requirejs.config {
		# Pass the top-level main.js/index.js require
		# function to requirejs so that node modules
		# are loaded relative to the top-level JS file.
		nodeRequire: require
		paths: {
			odo: './bower_components/odo'
			local: './'
		}
}

requirejs [
	'odo/infra/express'
	'odo/peek/plugin'
	'odo/bower/plugin'
	'odo/durandal/plugin'
	'odo/handlebars/plugin'
	'odo/auth/plugin'
	'odo/auth/twitter'
	'odo/auth/facebook'
	'odo/auth/google'
	'odo/auth/local'
	'odo/sendcommand/plugin'
	'odo/public/plugin'
	'local/plugins/welcome'
	'local/plugins/auth'
	'local/plugins/email'
	'local/plugins/user'
	'local/plugins/feedback'
], (express, plugins...) ->
	
	process.env.PORT = 4834
	
	app = express plugins