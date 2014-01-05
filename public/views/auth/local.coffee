define ['q', 'odo/auth'], (Q, auth) ->
	class SigninLocal
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
						
		activate: (options) =>
			{ @dialog } = options
		
		close: =>
			@dialog.close()
			