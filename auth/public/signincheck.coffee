define ['q', 'odo/auth'], (Q, auth) ->
	class SigninCheck
		canActivate: =>
			dfd = Q.defer()
			
			auth.getUser()
				.then((user) =>
					if user.email? and user.username?
						dfd.resolve {
							redirect: '#'
						}
					dfd.resolve {
						redirect: '#signin/extra'
					}
				)
				.fail((err) =>
					dfd.resolve no
				)
				
			dfd.promise