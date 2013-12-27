define ['q', 'knockout', 'plugins/router', 'components/dialog', 'odo/auth/twitter'], (Q, ko, router, Dialog, twitterauth) ->
	class Search
		constructor: ->
			@isAuth = ko.observable false
			
			@skill = ko.observable 0.3
			@output = ko.observable 0.4
			@delivery = ko.observable 0.5
			@group = ko.observable 0.6
		
		activate: =>
			dfd = Q.defer()
			
			twitterauth.getUser()
				.then((user) =>
					@isAuth yes
					dfd.resolve yes
				)
				.fail((err) =>
					dfd.resolve no
				)
				
			dfd.promise
		
		launch: =>
			options = {
				model: 'components/wizard'
				activationData: {
					model: 'views/feedback-give/0-introduction'
					activationData: {
						id: 'testtesttest'
						type: 'classic4'
						options: {}
						description: 'Feedback for Nigel for the last three months of his work at Company X'
						
						reviewer:
							id: 'ttttttt'
							name: 'Bob Fergerson'
							email: 'bob.fergerson@gmail.com'
						
						feedback: {}
					}
				}
			}
			
			new Dialog(options).show().then (feedback) =>
				console.log feedback
											
			no