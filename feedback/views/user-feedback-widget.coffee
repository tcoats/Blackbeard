﻿define ['knockout', 'components/dialog'], (ko, Dialog) ->
	class UserFeedbackWidget
		viewingUser: ko.observable null
		dashboardUser: ko.observable null
		feedback: ko.observable null
		
		activate: (activationData) =>
			{ viewingUser, dashboardUser } = activationData
			
			@viewingUser viewingUser
			@dashboardUser dashboardUser
			
			$
				.get("/user-feedback-widget/#{dashboardUser.id}")
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