defineQ ['knockout', 'components/dialog', 'odo/auth/current-user'], (ko, Dialog, user) ->
	class UserFeedbackInWidget
		viewingUser: ko.observable null
		dashboardUser: ko.observable null
		feedback: ko.observable []
		
		activate: (activationData) =>
			{ dashboardUser } = activationData
			
			@viewingUser user
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