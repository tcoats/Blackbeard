define ['plugins/router', 'durandal/app', 'bootstrap'], (router, app, bootstrap) ->
	router: router
	activate: ->
		router.map([
			{
				route: ''
				moduleId: 'views/welcome'
				nav: false
			}
		]).buildNavigationModel()
		router.activate()
	compositionComplete: () ->
		$('.dropdown-toggle').dropdown()