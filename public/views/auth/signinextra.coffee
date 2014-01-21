define ['knockout', 'q', 'odo/auth', 'plugins/router'], (ko, Q, auth, router) ->
	class SigninExtra
		user: ko.observable null
		shouldShake: ko.observable no
		
		constructor: ->
			@email = ko.observable('')
				.extend
					required: yes
					email: yes
					
			@username = ko.observable('')
				.extend
					required: yes
					validation:
						async: yes
						validator: (val, param, callback) =>
							if @user().username? and @user().username is val
								callback
									isValid: yes
									message: 'Same username as existing'
								return
							
							auth.getUsernameAvailability(val).then (availibility) =>
								callback
									isValid: availibility.isAvailable
									message: availibility.message
									
			@errors = ko.validation.group @
		
		activate: =>
			dfd = Q.defer()
			
			auth.getUser()
				.then (user) =>
					@user user
					
					if user.google? and user.google.profile.emails.length > 0
						@email user.google.profile.emails[0].value
						
					if user.username?
						@username user.username
					
					dfd.resolve yes
				
			dfd.promise
		
		shake: =>
			@shouldShake true
			
			setTimeout(() =>
				@shouldShake false
			, 1000)
		
		assignUsername: =>
			auth
				.assignUsernameToUser(@user().id, @username())
		
		assignEmailAddress: =>
			auth
				.createVerifyEmailAddressToken(@email())
		
		assignUsernameAndEmailAddress: =>
			if @isValidating()
				return
			
			if !@isValid()
				@shake()
				@errors.showAllMessages()
				return
			
			tasks = []
			
			if @user().username isnt @username()
				tasks.push @assignUsername()
			
			if @user().email isnt @email()
				tasks.push @assignEmailAddress()
			
			Q
				.allSettled(tasks)
				.then(=> router.navigate '#')