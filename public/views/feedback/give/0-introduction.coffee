define ['knockout'], (ko) ->
	class Introduction
		feedback: ko.observable null
		
		activate: (options) =>
			{ @wizard, @dialog, activationData } = options
			@feedback activationData
			
		close: =>
			@dialog.close()
			