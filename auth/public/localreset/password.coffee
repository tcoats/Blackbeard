define ['q', 'knockout', 'odo/auth', 'components/dialog'], (Q, ko, auth, Dialog) ->
	class LocalResetPassword
		constructor: ->
			@isTokenValid = ko.observable no
			@result = ko.observable null
			@token = ko.observable null
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
		
		shouldShake: ko.observable no
		
		shake: =>
			@shouldShake true
			
			setTimeout(() =>
				@shouldShake false
			, 1000)
		
		activate: (options) =>
			{ @wizard, activationData } = options
			
			@token activationData.token
			
			dfd = Q.defer()
			
			auth.checkResetToken(@token())
				.then((result) =>
					@isTokenValid result.isValid
					@result result
					dfd.resolve yes
				)
				.fail =>
					dfd.resolve no
				
			dfd.promise
			
		changePassword: =>
			if @isValidating()
				return
				
			if !@isValid()
				@shake()
				@errors.showAllMessages()
				return
				
			# do it here
			auth
				.resetPasswordWithToken(@token(), @password())
				.then =>
					@wizard.forward({
						model: 'views/auth/localreset/result'
						activationData: @result()
					})()
		
		forgot: =>
			new Dialog({ model: 'views/auth/forgot' }).show()