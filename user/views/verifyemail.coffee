define ['q', 'knockout', 'odo/auth', 'components/dialog'], (Q, ko, auth, Dialog) ->
	class VerifyEmail
		title: ko.observable ''
		
		isTokenValid: ko.observable no
		result: ko.observable null
		email: ko.observable null
		token: ko.observable null
		
		user: ko.observable null
		
		activate: (email, token) =>
			@email email
			@token token
			@title "Verifying #{email}"
			
			dfd = Q.defer()
			
			auth.checkEmailVerificationToken(@email(), @token())
				.then((result) =>
					@isTokenValid result.isValid
					@result result
					
					auth
						.assignEmailAddressToUserWithToken(@email(), @token())
						.then =>
							
							auth
								.getUser()
								.then((user) =>
									@user user
									dfd.resolve yes
								)
								.fail =>
									dfd.resolve yes
				)
				.fail =>
					dfd.resolve no
				
			dfd.promise
		
		showProfile: =>
			new Dialog({ model: 'views/user/profile' }).show()