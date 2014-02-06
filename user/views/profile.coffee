defineQ ['knockout'], (ko) ->
	class Profile
		constructor: ->
			@composeOptions = ko.observable null
		
		activate: (options) =>
			{ @dialog } = options
			
			@composeOptions {
				model: 'components/wizard'
				activationData: {
					dialog: @dialog
					model: 'views/user/profile/review'
				}
			}