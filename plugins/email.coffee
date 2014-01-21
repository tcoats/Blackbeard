define ['odo/mandrill', 'odo/projections/userprofile'], (Mandrill, UserProfile) ->
	class Email
		constructor: ->
			@receive =
				userHasPasswordResetToken: (event, cb) =>
					console.log 'Email userHasPasswordResetToken'
					new UserProfile().get event.payload.id, (err, user) =>
						if err?
							console.log err
							cb()
							return
						
						options =
							message:
								text: "Use this link to reset your password. If you don't want to reset your password ignore this email. The link expires after a day.\n\nhttp://blackbeard.thomascoats.com/#auth/local/reset/#{event.payload.token}"
								subject: 'Blackbeard reset password'
								from_email: 'blackbeard@voodoolabs.net'
								from_name: 'Blackbeard'
								to: [
									email: user.email
									name: user.displayName
									type: 'to'
								]
						
						new Mandrill()
							.send(options)
							.then(=>
								console.log 'Email away!'
								cb()
							)
							.fail((err) =>
								console.log err
								cb()
							)