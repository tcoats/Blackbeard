define ['odo/infra/mandrill', 'odo/projections/userprofile'], (Mandrill, UserProfile) ->
	class Email
		receive: (hub) =>
			hub.receive 'userHasPasswordResetToken', (event, cb) =>
				console.log 'Email userHasPasswordResetToken'
				new UserProfile().get event.payload.id, (err, user) =>
					if err?
						console.log err
						cb()
						return
					
					options =
						message:
							text: "Use this link to reset your password. If you don't want to reset your password ignore this email. This link expires after a day.\n\nhttp://blackbeard.thomascoats.com/#auth/local/reset/#{event.payload.token}"
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
		
			hub.receive 'userHasVerifyEmailAddressToken', (event, cb) =>
				console.log 'Email userHasVerifyEmailAddressToken'
				new UserProfile().get event.payload.id, (err, user) =>
					if err?
						console.log err
						cb()
						return
					
					options =
						message:
							text: "Use this link to verify your email address. If you don't want this email address enabled for your Blackbeard account please ignore this email. This link expires after a day.\n\nhttp://blackbeard.thomascoats.com/#user/verifyemail/#{event.payload.email}/#{event.payload.token}"
							subject: 'Blackbeard verify email address'
							from_email: 'blackbeard@voodoolabs.net'
							from_name: 'Blackbeard'
							to: [
								email: event.payload.email
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