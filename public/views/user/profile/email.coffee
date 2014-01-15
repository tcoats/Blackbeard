define ['q', 'jquery', 'knockout', 'odo/auth'], (Q, $, ko, auth) ->
	class ChangeEmail
		user: ko.observable null
		
		constructor: ->
			@email = ko.observable('')
				.extend
					required: yes
					email: yes
									
			@errors = ko.validation.group @
		
		activate: (options) =>
			{ @wizard, @dialog } = options
			
			dfd = Q.defer()
			
			auth.getUser()
				.then((user) =>
					@user user
					if user.email?
						@email user.email
					dfd.resolve yes
				)
				.fail((err) =>
					dfd.resolve yes
				)
				
			dfd.promise
		
		back: =>
			@wizard.back({ model: 'views/user/profile/review' })()
		
		changeEmail: =>
			if !@isValid()
				@dialog.shake()
				@errors.showAllMessages()
				return
			
			if @user().email is @email()
				@back()
			
			# submit here
			auth
				.assignEmailAddressToUser(@user().id, @email())
				.then => @back()