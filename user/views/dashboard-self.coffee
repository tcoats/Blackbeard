defineQ ['knockout', 'q', 'odo/inject', 'odo/auth/current-user'],  (ko, Q, inject, currentUser) ->
	class DashboardSelf
		inwidgets: inject.many 'user/dashboard-self/in-widgets'
		outwidgets: inject.many 'user/dashboard-self/out-widgets'
		title: ko.observable ''
		
		viewingUser: ko.observable null
		dashboardUser: ko.observable null
		
		activate: (activationData) =>
			{ dashboardUser } = activationData
			
			@viewingUser currentUser
			@dashboardUser dashboardUser