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
				moduleId: 'views/feedback/give'
				nav: no
			}
			{
				route: 'signin'
				moduleId: 'views/auth/signin'
				nav: no
			}
			{
				route: '_=_'
				moduleId: 'views/auth/facebook'
				nav: no
			}
			{
				route: 'user/profile'
				moduleId: 'views/user/profile'
				nav: no
			}
		]).buildNavigationModel()
		router.activate()
	compositionComplete: () ->
		$('.dropdown-toggle').dropdown()