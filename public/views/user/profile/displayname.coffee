define ['q', 'jquery', 'knockout', 'odo/auth'], (Q, $, ko, auth) ->
	class ChangeDisplayName
		user: ko.observable null
		
		constructor: ->
			@displayName = ko.observable('')
				.extend
					required: yes
									
			@errors = ko.validation.group @
		
		activate: (options) =>
			{ @wizard, @dialog } = options
			
			dfd = Q.defer()
			
			auth.getUser()
				.then((user) =>
					@user user
					@displayName user.displayName
					dfd.resolve yes
				)
				.fail((err) =>
					dfd.resolve yes
				)
				
			dfd.promise
		
		back: =>
			@wizard.back({ model: 'views/user/profile/review' })()
		
		changeDisplayName: =>
			if @isValidating()
				return
				
			if !@isValid()
				@dialog.shake()
				@errors.showAllMessages()
				return
			
			if @user().displayName is @displayName()
				@back()
			
			# submit here
			auth
				.assignDisplayNameToUser(@user().id, @displayName())
				.then => @back()