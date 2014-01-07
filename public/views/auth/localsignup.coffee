define ['q', 'knockout', 'odo/auth', 'components/dialog'], (Q, ko, auth, Dialog) ->
	class LocalSignup
		activate: (options) =>
			{ @dialog } = options
		
		close: =>
			@dialog.close()
			
		signup: =>
			# validate here!
			
			yes