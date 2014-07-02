define ['q', 'knockout', 'plugins/router', 'components/dialog'], (Q, ko, router, Dialog) ->
	router.map
		route: ''
		moduleId: 'views/welcome'
	
	class Welcome
		title: 'Welcome'
		
		constructor: ->
			@skill = ko.observable 0.3
			@output = ko.observable 0.4
			@delivery = ko.observable 0.5
			@group = ko.observable 0.6
