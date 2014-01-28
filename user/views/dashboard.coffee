define ['q', 'knockout', 'odo/auth', 'user', 'odo/inject'], (Q, ko, auth, user, inject) ->
	class UserDashboard
		widgets: inject.many 'user/dashboard/widgets'
		title: ko.observable ''
		
		viewingUser: ko.observable null
		dashboardUser: ko.observable null
		
		dashboardModel: ko.observable null
		
		canActivate: (username) =>
			dfd = Q.defer()
			
			auth.getUser()
				.then((viewingUser) =>
					user.getUser(username)
						.then((dashboardUser) =>
							dfd.resolve yes
						)
						.fail((err) =>
							dfd.resolve no
						)
				)
				.fail (err) =>
					dfd.resolve no
					
			dfd.promise
			
		
		activate: (username) =>
			dfd = Q.defer()
			
			
			auth.getUser()
				.then((viewingUser) =>
					user.getUser(username)
						.then((dashboardUser) =>
							@viewingUser viewingUser
							@dashboardUser dashboardUser
							
							if viewingUser.id is dashboardUser.id
								@dashboardModel 'views/user/dashboard-self'
							else
								@dashboardModel 'views/user/dashboard-other'
							
							dfd.resolve yes
						)
						.fail((err) =>
							dfd.resolve no
						)
				)
				.fail (err) =>
					dfd.resolve no
				
			dfd.promise