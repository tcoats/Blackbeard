define ['components/dialog'], (Dialog) ->
	class GoogleFailure
		title: "Google sign in didn't work"
		
		signin: =>
			options = {
				model: 'views/auth/signin'
			}
			
			new Dialog(options).show()