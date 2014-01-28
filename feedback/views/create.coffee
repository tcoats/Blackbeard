define ['knockout', 'plugins/router', 'odo/inject'], (ko, router, inject) ->
	class FeedbackCreate
		constructor: ->
			@composeOptions = ko.observable null
		
		activate: (options) =>
			{ @dialog } = options
			
			@composeOptions {
				model: 'components/wizard'
				activationData: {
					dialog: @dialog
					model: 'views/feedback/create/0-description'
				}
			}