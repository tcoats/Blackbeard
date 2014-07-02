define ['jquery', 'knockout', 'odo/auth', 'odo/auth/current-user'], ($, ko, auth, user) ->
	class ChangeUsername
		constructor: ->
			@user = ko.observable null
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
		
		activate: (options) =>
			{ @wizard, @dialog } = options
			
			@user user
			if user.username?
				@username user.username
		
		back: =>
			@wizard.back({ model: 'views/user/profile/review' })()
		
		changeUsername: =>
			if @isValidating()
				return
				
			if !@isValid()
				@dialog.shake()
				@errors.showAllMessages()
				return
			
			if @user().username is @username()
				@back()
			
			# submit here
			auth
				.assignUsernameToUser(@user().id, @username())
				.then => @back()
