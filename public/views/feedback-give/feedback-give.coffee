define ['knockout'], (ko) ->
	class FeedbackGive
		constructor: ->
			@composeOptions = ko.observable null
		
		activate: (id) =>
			@composeOptions {
				model: 'components/wizard'
				activationData: {
					model: 'views/feedback-give/0-introduction'
					activationData: {
						id: 'testtesttest'
						type: 'classic4'
						options: {}
						description: 'Feedback for Nigel for the last three months of his work at Company X'
						
						reviewer:
							id: 'ttttttt'
							name: 'Bob Fergerson'
							email: 'bob.fergerson@gmail.com'
						
						feedback: {}
					}
				}
			}