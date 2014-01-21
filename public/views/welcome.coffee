define ['q', 'knockout', 'plugins/router', 'components/dialog', 'odo/auth'], (Q, ko, router, Dialog, auth) ->
	class Welcome
		title: 'Welcome'
		
		constructor: ->
			@skill = ko.observable 0.3
			@output = ko.observable 0.4
			@delivery = ko.observable 0.5
			@group = ko.observable 0.6
		
		activate: =>
			dfd = Q.defer()
			
			auth.getUser()
				.then((user) =>
					dfd.resolve()
				)
				.fail((err) =>
					dfd.resolve()
				)
				
			dfd.promise