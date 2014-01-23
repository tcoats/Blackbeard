define ['knockout', 'plugins/router'], (ko, router) ->
	router.map
		route: 'givefeedback/:id'
		moduleId: 'views/feedback/give'
	
	class FeedbackGive
		title: ko.observable ''
		constructor: ->
			@composeOptions = ko.observable null
			@feedback = {
				id: 'testtesttest'
				type: 'classic4'
				options: {}
				description: 'Feedback for the last three months of Nigel\'s work at Company X'
				
				reviewee:
					id: 'ffffff'
					name: 'Nigel Matterson'
					short: 'Nigel'
					gender: 'male'
					email: 'nigel.matterson@gmail.com'
				
				reviewer:
					id: 'ttttttt'
					name: 'Bob Fergerson'
					short: 'Bob'
					gender: 'male'
					email: 'bob.fergerson@gmail.com'
				
				feedback: {}
			}
			@title @feedback.description
		
		activate: (id) =>
			@composeOptions {
				model: 'components/wizard'
				activationData: {
					model: 'views/feedback/give/0-introduction'
					activationData: @feedback
				}
			}