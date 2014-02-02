defineQ ['knockout', 'odo/auth', 'odo/auth/current-user'], (ko, auth, user) ->
	class LocalSignup
		user: ko.observable null
		
		constructor: ->
			@displayName = ko.observable ''
			@username = ko.observable ''
			@password = ko.observable ''
			@confirmPassword = ko.observable ''
		
		setup: =>
			if @user()?
				@displayName = ko.observable @user().displayName
				@username = ko.observable @user().username
				
			@displayName
				.extend
					required: yes
					
			@username
				.extend
					required: yes
					validation:
						async: yes
						validator: (val, param, callback) =>
							auth.getUsernameAvailability(val).then (availibility) =>
								callback
									isValid: availibility.isAvailable
									message: availibility.message
						
			@password
				.extend
					required: yes
					pattern:
						params: '^.{8,}$'
						message: 'Eight or more letters for security'
						
			@confirmPassword
				.extend
					equal:
						params: @password
						message: 'Type the same password here'
			
			@errors = ko.validation.group @
		
		activate: (options) =>
			{ @dialog } = options
			
			@user user
			@setup()
		
		close: =>
			@dialog.close()
			
		signup: =>
			if @isValidating()
				return no
			
			if !@isValid()
				@dialog.shake()
				@errors.showAllMessages()
				return no
				
			yes