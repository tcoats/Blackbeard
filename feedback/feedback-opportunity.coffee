define [], () ->
	class FeedbackOpportunity
		constructor: (id) ->
			@id = id
			@_destroy = no
			@description = ''
		
		createFeedbackOpportunity: (command, callback) =>
			if !command.description? or command.description is ''
				callback new Error 'Feedback description needed'
				return
			
			@new 'feedbackOpportunityCreated',
				id: @id
				by: command.by
				for: command.for
				description: command.description
			callback null
			
		cancelFeedbackOpportunity: (command, callback) =>
			@new 'feedbackOpportunityCancelled',
				id: @id
				by: command.by
				description: @description
			callback null
		
		expireFeedbackOpportunity: (command, callback) =>
			@new 'feedbackOpportunityExpired',
				id: @id
				description: @description
				by: command.by
			callback null
		
		completeFeedbackOpportunity: (command, callback) =>
			@new 'feedbackOpportunityCompleted',
				id: @id
				description: @description
				by: command.by
			callback null
			
		_feedbackOpportunityCreated: (event) =>
			@description = event.payload.description
			
		_feedbackOpportunityCancelled: (event) =>
			@_destroy = yes
			
		_feedbackOpportunityExpired: (event) =>
			@_destroy = yes
			
		_feedbackOpportunityCompleted: (event) =>
			@_destroy = yes