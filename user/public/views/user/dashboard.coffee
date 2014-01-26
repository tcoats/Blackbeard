﻿define ['q', 'knockout', 'odo/auth', 'user', 'odo/inject'], (Q, ko, auth, user, inject) ->
	class UserDashboard
		widgets: inject.many 'user/dashboard/widgets'
		title: ko.observable ''
		user: ko.observable null
		
		canActivate: (username) =>
			dfd = Q.defer()
			
			user.getUser(username)
				.then((user) =>
					dfd.resolve yes
				)
				.fail((err) =>
					dfd.resolve no
				)
				
			dfd.promise
			
		
		activate: (username) =>
			dfd = Q.defer()
			
			user.getUser(username)
				.then((user) =>
					@user user
					dfd.resolve()
				)
				.fail((err) =>
					dfd.resolve()
				)
				
			dfd.promise