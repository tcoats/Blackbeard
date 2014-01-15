define ['knockout'], (ko) ->
	class Introduction
		feedback: ko.observable null
		
		activate: (options) =>
			{ @wizard, @dialog, activationData } = options
			@feedback activationData
			
		close: =>
			@dialog.close()
		
		forward: =>
			@wizard.forward({ model: 'views/feedback/give/1-skill', activationData: @feedback() })()
			