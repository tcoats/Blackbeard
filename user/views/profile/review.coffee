defineQ ['knockout', 'odo/auth/current-user', 'components/dialog'], (ko, user, Dialog) ->
	class ReviewProfile
		user: ko.observable null
		
		activate: (options) =>
			{ @wizard, @dialog } = options
			
			@user user
			
		close: =>
			@dialog.close()
		
		signuplocal: =>
			@close()
			
			options = {
				model: 'views/auth/localsignup'
			}
			
			new Dialog(options).show()