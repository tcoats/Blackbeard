define ['q', 'knockout', 'odo/auth', 'components/dialog'], (Q, ko, auth, Dialog) ->
	class ReviewProfile
		user: ko.observable null
		
		activate: (options) =>
			{ @wizard, @dialog } = options
			
			dfd = Q.defer()
			
			auth.getUser()
				.then((user) =>
					@user user
					dfd.resolve yes
				)
				.fail((err) =>
					dfd.resolve yes
				)
				
			dfd.promise
			
		close: =>
			@dialog.close()
		
		signuplocal: =>
			@close()
			
			options = {
				model: 'views/auth/localsignup'
			}
			
			new Dialog(options).show()