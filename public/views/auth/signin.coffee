define ['q', 'odo/auth', 'components/dialog'], (Q, auth, Dialog) ->
	class Signin
		canActivate: =>
			dfd = Q.defer()
			
			auth.getUser()
				.then((user) =>
					dfd.resolve {
						redirect: '#'
					}
				)
				.fail((err) =>
					dfd.resolve yes
				)
				
			dfd.promise
		
		signinlocal: =>
			# typed some characters? New that
			options = {
				model: 'views/auth/local'
			}
			
			new Dialog(options).show()
			
			no