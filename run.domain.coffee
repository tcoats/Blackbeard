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
	'odo/hub'
	'local/domain/feedbackcommands'
	'odo/domain/usercommands'
	# add more command handlers here
], (hub, handlers...) ->
	
	# construct classes
	handlers = handlers.map (handler) ->
		if typeof(handler) is 'function'
			return new handler
		handler
	
	# let handlers bind
	for handler in handlers
		if handler.handle?
			handler.handle hub