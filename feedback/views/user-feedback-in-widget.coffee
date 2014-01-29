define ['knockout', 'components/dialog'], (ko, Dialog) ->
	class UserFeedbackInWidget
		viewingUser: ko.observable null
		dashboardUser: ko.observable null
		feedback: ko.observable []
		
		activate: (activationData) =>
			{ viewingUser, dashboardUser } = activationData
			
			@viewingUser viewingUser
			@dashboardUser dashboardUser
			
			$
				.get("/user-feedback-in-widget/#{dashboardUser.id}")
				.then (feedback) =>
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