define ['knockout', 'q', 'plugins/router', 'odo/inject'], (ko, Q, router, inject) ->
	class ViewFeedbackOpportunity
		title: ko.observable ''
		feedback: ko.observable null
		
		canActivate: (id) =>
			dfd = Q.defer()
			
			@getFeedback(id)
				.then((feedback) =>
					dfd.resolve yes)
				.fail(=>
					dfd.resolve no)
			
			dfd.promise
		
		activate: (id) =>
			dfd = Q.defer()
			
			@getFeedback(id)
				.then (feedback) =>
					@feedback feedback
					dfd.resolve yes
			
			dfd.promise
		
		getFeedback: (id) =>
			$.get("/view-feedback-opportunity/#{id}")