defineQ ['knockout', 'q', 'odo/auth/current-user', 'plugins/router', 'odo/inject'], (ko, Q, currentUser, router, inject) ->
	class ViewFeedbackOpportunity
		constructor: ->
			@title = ko.observable ''
			@feedback = ko.observable null
			@user = ko.observable null
		
		canActivate: (id) =>
			dfd = Q.defer()
			
			@getFeedback(id)
				.then((feedback) =>
					dfd.resolve yes)
				.fail(=>
					dfd.resolve no)
			
			dfd.promise
		
		activate: (id) =>
			@getFeedback(id)
				.then (feedback) =>
					@user currentUser
					@feedback feedback
		
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
			