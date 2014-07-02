define ['odo/auth/current-user'], (user) ->
	class SigninCheck
		canActivate: =>
			if !user?
				return no
			
			if user.email? and user.username?
				return redirect: "#user/#{user.username}"
					
			return redirect: '#signin/extra'
