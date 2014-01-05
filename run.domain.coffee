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
	'odo/hub'
	'blackbeard/domain/feedbackcommands'
	'odo/domain/usercommands'
	# add more command handlers here
], (hub, handlers...) ->
		
	handlers = handlers.map (handler) ->
		if typeof(handler) is 'function'
			return new handler
		handler
	
	bindCommands = (handler) ->
		for name, method of handler
			hub.handle name, method
		
	for handler in handlers
		bindCommands handler