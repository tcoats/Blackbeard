define [], () ->
	class SigninLocal
		canActivate: =>
			{
				redirect: '#'
			}