define ['components/dialog'], (Dialog) ->
	title: "Google sign in didn't work"
	class GoogleFailure
		signin: =>
			options = {
				model: 'views/auth/signin'
			}
			
			new Dialog(options).show()