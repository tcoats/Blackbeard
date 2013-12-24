requirejs = require 'requirejs'

# requirejs
requirejs.config {
		# Pass the top-level main.js/index.js require
		# function to requirejs so that node modules
		# are loaded relative to the top-level JS file.
		nodeRequire: require
		paths: {
			odo: './bower_components/odo'
			'blackbeard': './'
		}
}

requirejs ['odo/express'], (express) ->
	
	process.env.PORT = 80
	
	app = express [
		requirejs './odo/plugins/peek'
		requirejs './odo/plugins/bower'
		requirejs './odo/plugins/durandal'
		requirejs './odo/plugins/handlebars'
		requirejs './odo/plugins/twitterauth'
		requirejs './odo/plugins/sendcommand'
		requirejs './blackbeard/plugins/public'
		#requirejs './blackbeard/projections/articlecontent'
		#requirejs './blackbeard/projections/articleownership'
		#requirejs './blackbeard/projections/publicarticles'
	]