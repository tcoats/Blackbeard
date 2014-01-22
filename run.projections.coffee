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
	'odo/projections/userprofile'
	'odo/plugins/auth'
	'odo/plugins/auth/twitter'
	'odo/plugins/auth/facebook'
	'odo/plugins/auth/google'
	'odo/plugins/auth/local'
	'blackbeard/projections/feedbackforreviewer'
	'blackbeard/plugins/email'
	'blackbeard/plugins/user'
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