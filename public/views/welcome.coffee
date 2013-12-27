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