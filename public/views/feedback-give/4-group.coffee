define ['knockout'], (ko) ->
	class Output
		constructor: ->
			@feedback = ko.observable null
			@group = ko.observable null
		
		activate: (options) =>
			{ @wizard, @dialog, activationData } = options
			@feedback activationData
			if @feedback().feedback.group?
				@group @feedback().feedback.group
			else
				@group 0.05
			
		close: =>
			@dialog.close()
		
		back: =>
			@feedback().feedback.group = @group()
			options = {
				model: 'views/feedback-give/3-delivery'
				activationData: @feedback()
			}
			@wizard.back(options)()
		
		forward: =>
			@feedback().feedback.group = @group()
			options = {
				model: 'views/feedback-give/5-review'
				activationData: @feedback()
			}
			@wizard.forward(options)()