define ['knockout', 'components/dialog'], (ko, Dialog) ->
	class UserFeedbackOutWidget
		viewingUser: ko.observable null
		dashboardUser: ko.observable null
		feedback: ko.observable []
		
		activate: (activationData) =>
			{ viewingUser, dashboardUser } = activationData
			
			@viewingUser viewingUser
			@dashboardUser dashboardUser
			
			$
				.get("/user-feedback-out-widget/#{dashboardUser.id}")
				.then (feedback) =>
					@parseFeedback feedback
		
		parseFeedback: (feedback) =>
			result = []
			for id, f of feedback
				result.push f
			@feedback result
		
		suggestFeedbackOpportunity: =>
			#options = {
			#	model: 'views/feedback/suggest'
			#}
			#
			#new Dialog(options).show()