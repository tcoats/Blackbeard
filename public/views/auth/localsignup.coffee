define ['knockout'], (ko) ->
	class LocalSignup
		constructor: ->
			@displayName = ko.observable('')
				.extend
					required: yes
			@username = ko.observable('')
				.extend
					required: yes
					email: yes
			@password = ko.observable('')
				.extend
					required: yes
					pattern:
						params: '^.{8,}$'
						message: 'A good password is probably eight or more letters'
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
				@errors.showAllMessages()
				return no
				
			return no
			yes