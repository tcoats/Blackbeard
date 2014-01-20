define ['knockout', 'odo/auth', 'components/dialog'], (ko, auth, Dialog) ->
	class ForgotAuthResult
		email: ko.observable null
		result: ko.observable null
		
		activate: (options) =>
			{ @wizard, @dialog, activationData } = options
			
			@email activationData.email
			@result activationData.result
		
		close: =>
			@dialog.close()
		
		back: =>
			@wizard.back({ model: 'views/auth/forgot/email' })()
		
		signinlocal: =>
			@close()
			
			options = {
				model: 'views/auth/localsignin'
			}
			
			new Dialog(options).show()