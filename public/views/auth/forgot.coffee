define ['knockout', 'odo/auth', 'components/dialog'], (ko, auth, Dialog) ->
	class ForgotAuth
		result: ko.observable null
		
		constructor: ->
			@email = ko.observable('')
				.extend
					required: yes
					email: yes
			
			@errors = ko.validation.group @
		
		activate: (options) =>
			{ @dialog } = options
		
		close: =>
			@dialog.close()
		
		back: =>
			@dialog.close()
			
			options = {
				model: 'views/auth/signin'
			}
			
			new Dialog(options).show()
		
		forgot: =>
			if !@isValid() || @isValidating()
				@dialog.shake()
				@errors.showAllMessages()
				return
				
			auth
				.forgotCheckEmailAddress(@email())
				.then (result) =>
					@result result
			
		signinlocal: =>
			@close()
			
			options = {
				model: 'views/auth/localsignin'
			}
			
			new Dialog(options).show()