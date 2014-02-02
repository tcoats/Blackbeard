defineQ ['knockout', 'odo/inject', 'odo/auth/current-user'], (ko, inject, currentUser) ->
	class DashboardOther
		widgets: inject.many 'user/dashboard-other/widgets'
		title: ko.observable ''
		
		viewingUser: ko.observable null
		dashboardUser: ko.observable null
		
		activate: (activationData) =>
			{ dashboardUser } = activationData
			
			@viewingUser currentUser
			@dashboardUser dashboardUser