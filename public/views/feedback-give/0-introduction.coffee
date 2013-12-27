define ['knockout'], (ko) ->
	class Introduction
		constructor: ->
			@feedback = ko.observable null
		
		activate: (options) =>
			{ @wizard, @dialog, activationData } = options
			@feedback activationData
			
		close: =>
			@dialog.close()
			