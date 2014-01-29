define ['knockout', 'odo/inject'], (ko, inject) ->
	class DashboardSelf
		inwidgets: inject.many 'user/dashboard-self/in-widgets'
		outwidgets: inject.many 'user/dashboard-self/out-widgets'
		title: ko.observable ''
		
		viewingUser: ko.observable null
		dashboardUser: ko.observable null
		
		activate: (activationData) =>
			{ viewingUser, dashboardUser } = activationData
			
			@viewingUser viewingUser
			@dashboardUser dashboardUser