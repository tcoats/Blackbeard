defineQ ['knockout'], (ko) ->
	class ChangeEmailResult
		constructor: ->
			@email = ko.observable null
		
		activate: (options) =>
			{ @wizard, @dialog, activationData } = options
			
			@email activationData.email
		
		back: =>
			@wizard.back({ model: 'views/user/profile/review' })()