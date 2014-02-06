define ['components/dialog'], (Dialog) ->
	class TwitterFailure
		title: "Twitter sign in didn't work"
		signin: =>
			options = {
				model: 'views/auth/signin'
			}
			
			new Dialog(options).show()