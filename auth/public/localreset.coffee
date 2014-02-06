define ['knockout'], (ko) ->
	class LocalReset
		title: "Reset your password"
		
		constructor: ->
			@composeOptions = ko.observable null
		
		activate: (token) =>
			@composeOptions {
				model: 'components/wizard'
				activationData: {
					dialog: @dialog
					model: 'views/auth/localreset/password'
					activationData:
						token: token
				}
			}