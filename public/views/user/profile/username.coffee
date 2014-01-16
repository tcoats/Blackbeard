define ['q', 'jquery', 'knockout', 'odo/auth'], (Q, $, ko, auth) ->
	class ChangeUsername
		user: ko.observable null
		
		constructor: ->
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
			
			dfd = Q.defer()
			
			auth.getUser()
				.then((user) =>
					@user user
					if user.username?
						@username user.username
					dfd.resolve yes
				)
				.fail((err) =>
					dfd.resolve yes
				)
				
			dfd.promise
		
		back: =>
			@wizard.back({ model: 'views/user/profile/review' })()
		
		changeUsername: =>
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