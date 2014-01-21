define ['knockout', 'odo/auth', 'components/dialog'], (ko, auth, Dialog) ->
	class LocalSignin
		constructor: ->
			@password = ko.observable ''
			@username = ko.observable ''
		
		setup: =>
			@password
				.extend
					required: yes
					
			@username
				.extend
					required: yes
					validation:
						async: yes
						params: @password
						validator: (username, password, callback) =>
							# don't validate if there is no password yet
							if password is ''
								callback
									isValid: yes
								return
							auth.testAuthentication(username, password).then (result) =>
								callback
									isValid: result.isValid
									message: result.message
			
			@errors = ko.validation.group @
		
		activate: (options) =>
			{ @dialog, activationData } = options
			
			if activationData? and activationData.username?
				@username activationData.username
			
			@setup()
		
		close: =>
			@dialog.close()
		
		signup: =>
			@close()
			
			options = {
				model: 'views/auth/localsignup'
			}
			
			new Dialog(options).show()
		
		signin: =>
			if @isValidating()
				return no
			
			if !@isValid()
				@dialog.shake()
				@errors.showAllMessages()
				return no
				
			yes
		
		forgot: =>
			@close()
			
			options = {
				model: 'views/auth/forgot'
			}
			
			new Dialog(options).show()
		
		# This is a work around for autocomplete / autofill not firing events knockoutjs can see. Currently autocomplete is disabled as this code causes a race condition inside knockout validation. Two changes in quick succession aren't supported.
		# If you have used 'saved details' the autocomplete="off" attribute is ignored and it will still autocomplete causing the issue.
		#compositionComplete: (child) =>
		#	setTimeout(->
		#		$(child).find("input:not([value=''])").each ->
		#			$(this).change()
		#	, 200)