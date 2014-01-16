define ['components/dialog'], (Dialog) ->
	class GoogleFailure
		signin: =>
			options = {
				model: 'views/auth/signin'
			}
			
			new Dialog(options).show()