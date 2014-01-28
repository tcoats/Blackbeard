define ['knockout', 'q', 'odo/auth', 'plugins/router', 'odo/inject'], (ko, Q, auth, router, inject) ->
	class ViewFeedbackOpportunity
		title: ko.observable ''
		feedback: ko.observable null
		user: ko.observable null
		
		canActivate: (id) =>
			dfd = Q.defer()
			
			@getFeedback(id)
				.then((feedback) =>
					dfd.resolve yes)
				.fail(=>
					dfd.resolve no)
			
			dfd.promise
		
		activate: (id) =>
			dfd = Q.defer()
			
			auth.getUser()
				.then((user) =>
					@getFeedback(id)
						.then (feedback) =>
							@user user
							@feedback feedback
							dfd.resolve yes
					)
			
			dfd.promise
		
		getFeedback: (id) =>
			$.get("/view-feedback-opportunity/#{id}")
		
		cancel: =>
			Q($.post '/sendcommand/cancelFeedbackOpportunity', @feedback())
				.then =>
					router.navigate '#user/' + @user().username
			
		expire: =>
			Q($.post '/sendcommand/expireFeedbackOpportunity', @feedback())
				.then =>
					router.navigate '#user/' + @user().username
			
		complete: =>
			Q($.post '/sendcommand/completeFeedbackOpportunity', @feedback())
				.then =>
					router.navigate '#user/' + @user().username
			