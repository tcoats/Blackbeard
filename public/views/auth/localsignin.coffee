define ['components/dialog'], (Dialog) ->
	class LocalSignin
		activate: (options) =>
			{ @dialog } = options
		
		close: =>
			@dialog.close()
		
		signup: =>
			@dialog.close()
			
			options = {
				model: 'views/auth/localsignup'
			}
			
			new Dialog(options).show()