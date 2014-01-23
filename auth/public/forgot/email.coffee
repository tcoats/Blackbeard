define ['knockout', 'odo/auth', 'components/dialog'], (ko, auth, Dialog) ->
	class ForgotEmail
		message: ko.observable null
		
		constructor: ->
			@email = ko.observable('')
				.extend
					required: yes
					email: yes
					validation:
						async: yes
						validator: (val, param, callback) =>
							auth.forgotCheckEmailAddress(val).then (result) =>
								callback
									isValid: result.account
									message: result.message
			
			@errors = ko.validation.group @
		
		activate: (options) =>
			{ @wizard, @dialog } = options
		
		close: =>
			@dialog.close()
		
		back: =>
			@dialog.close()
			
			options = {
				model: 'views/auth/signin'
			}
			
			new Dialog(options).show()
		
		forgot: =>
			if @isValidating()
				return
				
			if !@isValid()
				@dialog.shake()
				@errors.showAllMessages()
				return
			
			@message null
			auth
				.forgotCheckEmailAddress(@email())
				.then (result) =>
					@wizard.forward({
						model: 'views/auth/forgot/result'
						activationData:
							email: @email()
							result: result
					})()