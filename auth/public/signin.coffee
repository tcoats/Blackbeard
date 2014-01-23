define ['q', 'knockout', 'odo/auth', 'components/dialog'], (Q, ko, auth, Dialog) ->
	class Signin
		user: ko.observable null
		
		activate: (options) =>
			{ @dialog } = options
			
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
		
		signinlocal: =>
			@close()
			
			if @user()?
				options = {
					model: 'views/auth/localsignup'
				}
			else
				options = {
					model: 'views/auth/localsignin'
				}
			
			new Dialog(options).show()
			
			no
		
		close: =>
			@dialog.close()
		
		forgot: =>
			@close()
			
			options = {
				model: 'views/auth/forgot'
			}
			
			new Dialog(options).show()