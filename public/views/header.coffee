define ['q', 'knockout', 'odo/auth'], (Q, ko, auth) ->
	class Header
		activate: =>
			dfd = Q.defer()
			auth.getUser()
				.then((user) =>
					@user user
					dfd.resolve yes
				)
				.fail(->
					dfd.resolve no
				)
			dfd.promise
		
		user: ko.observable null