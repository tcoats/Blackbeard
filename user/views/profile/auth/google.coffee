defineQ ['knockout', 'odo/auth', 'odo/auth/current-user'], (ko, auth, user) ->
	class GoogleProfile
		user: ko.observable null
		
		activate: (options) =>
			{ @wizard, @dialog } = options
			
			@user user
			
		disconnectStarted: ko.observable no
		
		startDisconnect: =>
			@disconnectStarted yes
			
		stopDisconnect: =>
			@disconnectStarted no
			
		disconnect: =>
			auth
				.disconnectGoogleFromUser(@user().id, @user().google.profile)
				.then => @back()
		
		back: =>
			@wizard.back({ model: 'views/user/profile/review' })()