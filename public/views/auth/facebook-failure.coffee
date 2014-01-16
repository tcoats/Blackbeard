define ['components/dialog'], (Dialog) ->
	class FacebookFailure
		signin: =>
			options = {
				model: 'views/auth/signin'
			}
			
			new Dialog(options).show()