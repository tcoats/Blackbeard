define ['q', 'knockout', 'odo/auth'], (Q, ko, auth) ->
	class FacebookProfile
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
			
		disconnectStarted: ko.observable no
		
		startDisconnect: =>
			@disconnectStarted yes
			
		stopDisconnect: =>
			@disconnectStarted no
			
		disconnect: =>
			auth
				.disconnectFacebookFromUser(@user().id, @user().facebook.profile)
				.then => @back()
		
		back: =>
			@wizard.back({ model: 'views/user/profile/review' })()