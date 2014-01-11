define ['knockout'], (ko) ->
	class Output
		constructor: ->
			@feedback = ko.observable null
			@delivery = ko.observable null
			@isShowingInfo = ko.observable no
		
		activate: (options) =>
			{ @wizard, activationData } = options
			@feedback activationData
			if @feedback().feedback.delivery?
				@delivery @feedback().feedback.delivery
			else
				@delivery 0.05
		
		back: =>
			@feedback().feedback.delivery = @delivery()
			options = {
				model: 'views/feedback/give/2-output'
				activationData: @feedback()
			}
			@wizard.back(options)()
		
		forward: =>
			@feedback().feedback.delivery = @delivery()
			options = {
				model: 'views/feedback/give/4-group'
				activationData: @feedback()
			}
			@wizard.forward(options)()
		
		showInfo: =>
			@isShowingInfo yes