define ['knockout', 'odo/inject'], (ko, inject) ->
	class DashboardSelf
		widgets: inject.many 'user/dashboard-self/widgets'
		title: ko.observable ''
		
		viewingUser: ko.observable null
		dashboardUser: ko.observable null
		
		activate: (activationData) =>
			{ viewingUser, dashboardUser } = activationData
			
			@viewingUser viewingUser
			@dashboardUser dashboardUser