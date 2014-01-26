define [], () ->
	class Feedback
		constructor: (id) ->
			@id = id
			@_destroy = no
			@type = ''
			@options = {}
			@description = ''
			@reviewee =
				id: null
				name: ''
				short: ''
				email: ''
			@reviewer =
				id: null
				name: ''
				short: ''
				email: ''
			@feedback = {}
		
		beginFeedback: (command, callback) =>
			if !command.description? or command.description is ''
				callback new Error 'Feedback description needed'
				return
			
			@new 'feedbackBegun',
				id: @id
				type: command.type
				options: command.options
				description: command.description
				
				reviewee: command.reviewee
				reviewer: command.reviewer
			callback null
			
		cancelFeedback: (command, callback) =>
			@new 'feedbackCancelled',
				id: @id
				type: @type
				options: @options
				description: @description
				
				reviewee: @reviewee
				reviewer: @reviewer
				
				feedback: @feedback
				
				by: command.by
			callback null
		
		completeFeedback: (command, callback) =>
			if !command.feedback?
				callback new Error 'Feedback results needed'
				return
			
			@new 'feedbackCompleted',
				id: @id
				type: @type
				options: @options
				description: @description
				
				reviewee: @reviewee
				reviewer: @reviewer
				
				feedback: @feedback
				
				by: command.by
			
		_feedbackBegun: (event) =>
			@type = event.payload.type
			@options = event.payload.options
			@description = event.payload.description
			
			@reviewee = event.payload.reviewee
			@reviewer = event.payload.reviewer
			
		_feedbackCancelled: (event) =>
			@_destroy = yes
			
		_feedbackCompleted: (event) =>
			@_destroy = yes
			@feedback = event.payload.feedback
			