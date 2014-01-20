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
				route: '_=_'
				moduleId: 'views/auth/facebook'
				nav: no
			}
			{
				route: 'signin/extra'
				moduleId: 'views/auth/signinextra'
				nav: no
			}
			{
				route: 'auth/facebook/failure'
				moduleId: 'views/auth/facebook-failure'
				nav: no
			}
			{
				route: 'auth/facebook/success'
				moduleId: 'views/auth/signincheck'
				nav: no
			}
			{
				route: 'auth/twitter/failure'
				moduleId: 'views/auth/twitter-failure'
				nav: no
			}
			{
				route: 'auth/twitter/success'
				moduleId: 'views/auth/signincheck'
				nav: no
			}
			{
				route: 'auth/google/failure'
				moduleId: 'views/auth/google-failure'
				nav: no
			}
			{
				route: 'auth/google/success'
				moduleId: 'views/auth/signincheck'
				nav: no
			}
			{
				route: 'auth/local/success'
				moduleId: 'views/auth/signincheck'
				nav: no
			}
		]).buildNavigationModel()
		router.activate()
	compositionComplete: () ->
		$('.dropdown-toggle').dropdown()