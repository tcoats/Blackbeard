define ['knockout', 'odo/auth/local'], (ko, localauth) ->
	class LocalSignup
		constructor: ->
			@displayName = ko.observable ''
				.extend
					required: yes
			@username = ko.observable ''
				.extend
					required: yes
					validation:
						async: yes
						validator: (val, params, callback) =>
							localauth.getUsernameAvailability(val).then (availibility) =>
								callback
									isValid: availibility.isAvailable
									message: availibility.message
						
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
		
		activate: (options) =>
			{ @dialog } = options
		
		close: =>
			@dialog.close()
			
		signup: =>
			# validate here!
			if !@isValid()
				@dialog.shake()
				@errors.showAllMessages()
				return no
				
			return no
			yes