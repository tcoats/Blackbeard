define ['odo/messaging/hub', 'odo/messaging/eventstore', 'local/feedback/feedback-opportunity'], (hub, es, FeedbackOpportunity) ->
	class FeedbackCommands
		commands: [
			'createFeedbackOpportunity'
			'cancelFeedbackOpportunity'
			'expireFeedbackOpportunity'
			'completeFeedbackOpportunity'
		]
		
		defaultHandler: (command) =>
			feedback = new FeedbackOpportunity command.payload.id
			es.extend feedback
			feedback.applyHistoryThenCommand command
		
		domain: =>
			for command in @commands
				hub.handle command, @defaultHandler