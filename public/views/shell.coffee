define ['plugins/router', 'durandal/app', 'bootstrap'], (router, app, bootstrap) ->
	router: router
	activate: ->
		router.map([
			{
				route: ''
				moduleId: 'views/welcome'
				nav: no
			}
			{
				route: 'givefeedback/:id'
				moduleId: 'views/feedback-give/feedback-give'
				nav: no
			}
			{
				route: 'signin'
				moduleId: 'views/signin'
				nav: no
			}
		]).buildNavigationModel()
		router.activate()
	compositionComplete: () ->
		$('.dropdown-toggle').dropdown()