define ['odo/infra/eventstore', 'local/domain/feedback'], (es, Feedback) ->
	
	defaultHandler = (command) ->
		feedback = new Feedback command.payload.id
		es.extend feedback
		feedback.applyHistoryThenCommand command
		
	handle: (hub) ->
		commands = [
			'beginFeedback'
			'cancelFeedback'
			'completeFeedback'
		]
		
		for command in commands
			hub.handle command, defaultHandler