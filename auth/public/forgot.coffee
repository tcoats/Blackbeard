define ['knockout'], (ko) ->
	class ForgotAuth
		constructor: ->
			@composeOptions = ko.observable null
		
		activate: (options) =>
			{ @dialog } = options
			
			@composeOptions {
				model: 'components/wizard'
				activationData: {
					dialog: @dialog
					model: 'views/auth/forgot/email'
				}
			}