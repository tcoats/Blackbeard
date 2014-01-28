define ['knockout', 'components/dialog'], (ko, Dialog) ->
	class UserFeedbackWidget
		user: ko.observable null
		feedback: ko.observable null
		
		activate: (user) =>
			@user user
			$
				.get("/user-feedback-widget/#{user.id}")
				.then (feedback) =>
					console.log feedback
					@parseFeedback feedback
		
		parseFeedback: (feedback) =>
			result = []
			for id, f of feedback
				result.push f
			@feedback result
		
		createFeedbackOpportunity: =>
			options = {
				model: 'views/feedback/create'
			}
			
			new Dialog(options).show()