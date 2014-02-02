defineQ ['jquery', 'knockout', 'odo/auth', 'odo/auth/current-user'], ($, ko, auth, user) ->
	class ChangeDisplayName
		user: ko.observable null
		
		constructor: ->
			@oldPassword = ko.observable('')
				.extend
					required: yes
					validation:
						async: yes
						validator: (password, param, callback) =>
							auth.testAuthentication(@user().username, password).then (result) =>
								callback
									isValid: result.isValid
									message: result.message
			
			@password = ko.observable('')
				.extend
					required: yes
					pattern:
						params: '^.{8,}$'
						message: 'Eight or more letters for security'
			
			@confirmPassword = ko.observable('')
				.extend
					equal:
						params: @password
						message: 'Type the same password here'
									
			@errors = ko.validation.group @
		
		activate: (options) =>
			{ @wizard, @dialog } = options
			
			@user user
		
		back: =>
			@wizard.back({ model: 'views/user/profile/review' })()
		
		changePassword: =>
			if @isValidating()
				return
				
			if !@isValid()
				@dialog.shake()
				@errors.showAllMessages()
				return
			
			# submit here
			auth
				.assignPasswordToUser(@user().id, @password())
				.then => @back()