define ['q', 'jquery', 'knockout', 'odo/auth', 'odo/auth/local'], (Q, $, ko, auth, localauth) ->
	class ChangeDisplayName
		user: ko.observable null
		
		constructor: ->
			@oldPassword = ko.observable('')
				.extend
					required: yes
					validation:
						async: yes
						validator: (password, param, callback) =>
							localauth.testAuthentication(@user().username, password).then (result) =>
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
		
		back: =>
			@wizard.back({ model: 'views/user/profile/review' })()
		
		changePassword: =>
			if !@isValid()
				@dialog.shake()
				@errors.showAllMessages()
				return
			
			# submit here
			localauth
				.assignPasswordToUser(@user().id, @password())
				.then => @back()