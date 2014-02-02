defineQ ['knockout', 'odo/auth', 'odo/auth/current-user'], (ko, auth, user) ->
	class ChangeDisplayName
		user: ko.observable null
		
		constructor: ->
			@displayName = ko.observable('')
				.extend
					required: yes
									
			@errors = ko.validation.group @
		
		activate: (options) =>
			{ @wizard, @dialog } = options
			
			@user user
			@displayName user.displayName
		
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