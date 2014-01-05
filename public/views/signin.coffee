define ['q', 'odo/auth'], (Q, auth) ->
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