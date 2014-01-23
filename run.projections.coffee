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
	'odo/infra/hub'
	'odo/user/userprofile'
	'odo/auth/plugin'
	'odo/auth/twitter'
	'odo/auth/facebook'
	'odo/auth/google'
	'odo/auth/local'
	'local/plugins/email'
	'local/plugins/user'
	'local/plugins/feedback'
	# add more event listeners here
], (hub, listeners...) ->
	
	# construct classes
	listeners = listeners.map (listener) ->
		if typeof(listener) is 'function'
			return new listener
		listener
	
	# let listeners bind
	for listener in listeners
		if listener.receive?
			listener.receive hub