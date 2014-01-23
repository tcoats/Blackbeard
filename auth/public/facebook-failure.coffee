define ['components/dialog'], (Dialog) ->
	title: "Facebook sign in didn't work"
	class FacebookFailure
		signin: =>
			options = {
				model: 'views/auth/signin'
			}
			
			new Dialog(options).show()