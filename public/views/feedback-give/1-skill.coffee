define ['knockout'], (ko) ->
	class Skill
		constructor: ->
			@feedback = ko.observable null
			@skill = ko.observable null
			@isShowingInfo = ko.observable no
		
		activate: (options) =>
			{ @wizard, activationData } = options
			@feedback activationData
			if @feedback().feedback.skill?
				@skill @feedback().feedback.skill
			else
				@skill 0.05
		
		back: =>
			@feedback().feedback.skill = @skill()
			options = {
				model: 'views/feedback-give/0-introduction'
				activationData: @feedback()
			}
			@wizard.back(options)()
		
		forward: =>
			@feedback().feedback.skill = @skill()
			options = {
				model: 'views/feedback-give/2-output'
				activationData: @feedback()
			}
			@wizard.forward(options)()
		
		showInfo: =>
			@isShowingInfo yes