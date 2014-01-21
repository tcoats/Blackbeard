define ['knockout', 'components/dialog'], (ko, Dialog) ->
	class LocalResetResult
		username: ko.observable null
		
		activate: (options) =>
			{ activationData } = options
			
			@username activationData.username
		
		signinlocal: =>
			options = {
				model: 'views/auth/localsignin'
				activationData:
					username: @username()
			}
			
			new Dialog(options).show()