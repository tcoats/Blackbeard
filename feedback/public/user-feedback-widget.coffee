define ['knockout'], (ko) ->
	class UserFeedbackWidget
		user: ko.observable null
		activate: (user) =>
			@user user