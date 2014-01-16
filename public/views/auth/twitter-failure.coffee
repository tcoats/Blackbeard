define ['components/dialog'], (Dialog) ->
	class TwitterFailure
		signin: =>
			options = {
				model: 'views/auth/signin'
			}
			
			new Dialog(options).show()