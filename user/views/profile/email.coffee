defineQ ['q', 'jquery', 'knockout', 'odo/auth', 'odo/auth/current-user'], (Q, $, ko, auth, user) ->
	class ChangeEmail
		constructor: ->
			@user = ko.observable null
			@email = ko.observable('')
				.extend
					required: yes
					email: yes
									
			@errors = ko.validation.group @
		
		activate: (options) =>
			{ @wizard, @dialog } = options
			
			@user user
			if user.email?
				@email user.email
		
		back: =>
			@wizard.back({ model: 'views/user/profile/review' })()
		
		changeEmail: =>
			if @isValidating()
				return
				
			if !@isValid()
				@dialog.shake()
				@errors.showAllMessages()
				return
			
			if @user().email is @email()
				@back()
			
			# submit here
			auth
				.createVerifyEmailAddressToken(@email())
				.then => @wizard.forward({
					model: 'views/user/profile/emailresult'
					activationData:
						email: @email()
				})()