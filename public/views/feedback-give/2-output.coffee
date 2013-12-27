﻿define ['knockout'], (ko) ->
	class Output
		constructor: ->
			@feedback = ko.observable null
			@output = ko.observable null
		
		activate: (options) =>
			{ @wizard, @dialog, activationData } = options
			@feedback activationData
			if @feedback().feedback.output?
				@output @feedback().feedback.output
			else
				@output 0.05
			
		close: =>
			@dialog.close()
		
		back: =>
			@feedback().feedback.output = @output()
			options = {
				model: 'views/feedback-give/1-skill'
				activationData: @feedback()
			}
			@wizard.back(options)()
		
		forward: =>
			@feedback().feedback.output = @output()
			options = {
				model: 'views/feedback-give/3-delivery'
				activationData: @feedback()
			}
			@wizard.forward(options)()