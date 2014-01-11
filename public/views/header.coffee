define ['q', 'knockout', 'odo/auth', 'components/dialog'], (Q, ko, auth, Dialog) ->
	class Header
		user: ko.observable null
		
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
		
		showProfile: =>
			options = {
				model: 'views/user/profile'
			}
			
			new Dialog(options).show()
			