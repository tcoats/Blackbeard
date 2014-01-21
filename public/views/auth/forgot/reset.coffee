define ['knockout', 'q', 'odo/auth'], (ko, Q, auth) ->
	class ForgotAuthReset
		email: ko.observable null
		
		activate: (options) =>
			{ @wizard, @dialog, activationData } = options
			
			@email activationData.email
			
			
			
			dfd = Q.defer()
			# send email here
			auth
				.createPasswordResetToken(@email())
				.then =>
					dfd.resolve yes
			
			return dfd.promise
		
		close: =>
			@dialog.close()