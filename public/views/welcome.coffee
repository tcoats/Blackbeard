define ['q', 'knockout', 'plugins/router', 'components/dialog', 'odo/auth/twitter'], (Q, ko, router, Dialog, twitterauth) ->
	class Search
		constructor: ->
			@isAuth = ko.observable false
		
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
			