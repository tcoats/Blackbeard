define ['knockout', 'odo/auth/current-user', 'components/dialog'], (ko, user, Dialog) ->
	class Header
		user: ko.observable null
		
		activate: =>
			@user user
		
		showProfile: =>
			options = {
				model: 'views/user/profile'
			}
			
			new Dialog(options).show()
		
		showSignIn: =>
			options = {
				model: 'views/auth/signin'
			}
			
			new Dialog(options).show()
			
