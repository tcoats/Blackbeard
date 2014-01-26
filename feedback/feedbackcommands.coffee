define ['odo/messaging/hub', 'odo/messaging/eventstore', 'local/feedback/feedback'], (hub, es, Feedback) ->
	class FeedbackCommands
		commands: [
			'beginFeedback'
			'cancelFeedback'
			'completeFeedback'
		]
		
		defaultHandler: (command) =>
			feedback = new Feedback command.payload.id
			es.extend feedback
			feedback.applyHistoryThenCommand command
		
		domain: =>
			for command in @commands
				hub.handle command, @defaultHandler