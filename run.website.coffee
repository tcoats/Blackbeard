requirejs = require 'requirejs'

# requirejs
requirejs.config {
		# Pass the top-level main.js/index.js require
		# function to requirejs so that node modules
		# are loaded relative to the top-level JS file.
		nodeRequire: require
		paths: {
			odo: './bower_components/odo'
			blackbeard: './'
		}
}

requirejs [
	'odo/express'
	'odo/plugins/peek'
	'odo/plugins/bower'
	'odo/plugins/durandal'
	'odo/plugins/handlebars'
	'odo/plugins/auth'
	'odo/plugins/auth/twitter'
	'odo/plugins/auth/facebook'
	'odo/plugins/auth/google'
	'odo/plugins/auth/local'
	'odo/plugins/sendcommand'
	'odo/plugins/public'
	'blackbeard/projections/feedbackforreviewer'
	'blackbeard/plugins/user'
], (express, plugins...) ->
	
	process.env.PORT = 4834
	
	app = express plugins