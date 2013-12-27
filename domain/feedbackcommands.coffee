define ['odo/eventstore', 'blackbeard/domain/feedback'], (es, Feedback) ->
	
	defaultHandler = (command) ->
		feedback = new Feedback command.payload.id
		es.extend feedback
		feedback.applyHistoryThenCommand command
	
	beginFeedback: defaultHandler
	cancelFeedback: defaultHandler
	completeFeedback: defaultHandler