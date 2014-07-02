define ['q', 'knockout', 'odo/auth/current-user', 'user', 'odo/inject'], (Q, ko, currentUser, user, inject) ->
	class UserDashboard
		constructor: ->
			@dashboardUser = ko.observable null
			@dashboardModel = ko.observable null
		
		canActivate: (username) =>
			dfd = Q.defer()
			
			user
				.getUser(username)
				.then((dashboardUser) => dfd.resolve yes )
				.fail((err) => dfd.resolve no)
				.done()
					
			dfd.promise
			
		
		activate: (username) =>
			dfd = Q.defer()
			
			user
				.getUser(username)
				.then((dashboardUser) =>
					@dashboardUser dashboardUser
					
					if currentUser.id is dashboardUser.id
						@dashboardModel 'views/user/dashboard-self'
					else
						@dashboardModel 'views/user/dashboard-other'
					
					dfd.resolve yes
				)
				.fail((err) => dfd.resolve no)
				.done()
				
			dfd.promise
