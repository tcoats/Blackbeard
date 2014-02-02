defineQ ['knockout', 'odo/auth/current-user', 'components/dialog'], (ko, user, Dialog) ->
	class Signin
		user: ko.observable null
		
		activate: (options) =>
			{ @dialog } = options
			
			@user user
		
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