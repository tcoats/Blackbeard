defineQ ['knockout', 'q', 'odo/inject', 'md5', 'odo/auth/current-user'],  (ko, Q, inject, md5, currentUser) ->
	class DashboardSelf
		inwidgets: inject.many 'user/dashboard-self/in-widgets'
		outwidgets: inject.many 'user/dashboard-self/out-widgets'
		title: ko.observable ''
		
		viewingUser: ko.observable null
		dashboardUser: ko.observable null
		
		user: ko.observable null
		
		activate: (activationData) =>
			{ dashboardUser } = activationData
			
			@viewingUser currentUser
			@dashboardUser dashboardUser
			@user currentUser