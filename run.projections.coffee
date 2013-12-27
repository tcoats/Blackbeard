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

requirejs [
	'odo/hub'
	'blackbeard/projections/feedbackforreviewer'
	# add more event listeners here
], (hub, listeners...) ->
		
	listeners = listeners.map (listener) ->
		if typeof(listener) is 'function'
			return new listener
		listener
	
	bindEvents = (listener) ->
		for name, method of listener
			hub.receive name, method
		
	for listener in listeners
		bindEvents listener.receive