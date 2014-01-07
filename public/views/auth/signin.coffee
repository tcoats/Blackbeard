define ['q', 'knockout', 'jquery', 'odo/auth', 'components/dialog'], (Q, ko, $, auth, Dialog) ->
	class Signin
		user: ko.observable null
		
		activate: =>
			dfd = Q.defer()
			
			auth.getUser()
				.then((user) =>
					@user user
					dfd.resolve yes
				)
				.fail((err) =>
					dfd.resolve yes
				)
				
			dfd.promise
		
		signinlocal: =>
			if @user()?
				options = {
					model: 'views/auth/localsignup'
				}
			else
				options = {
					model: 'views/auth/localsignin'
				}
			
			new Dialog(options).show()
			
			no
		
		compositionComplete: =>
			$('.authentication-mechanisms').tooltip {
				selector: 'a'
				container: 'body'
				placement: 'bottom'
			}