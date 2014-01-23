define ['components/dialog'], (Dialog) ->
	title: "Twitter sign in didn't work"
	class TwitterFailure
		signin: =>
			options = {
				model: 'views/auth/signin'
			}
			
			new Dialog(options).show()