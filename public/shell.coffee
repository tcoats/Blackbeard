define ['plugins/router', 'durandal/app', 'bootstrap'], (router, app, bootstrap) ->
	router: router
	activate: ->
		routes =
			'': 												'views/welcome'
			'givefeedback/:id': 				'views/feedback/give'
			
			'_=_': 											'views/auth/facebook'
			'auth/facebook/failure':		'views/auth/facebook-failure'
			'auth/facebook/success':		'views/auth/signincheck'
			
			'auth/twitter/failure':			'views/auth/twitter-failure'
			'auth/twitter/success':			'views/auth/signincheck'
			
			'auth/google/failure':			'views/auth/google-failure'
			'auth/google/success':			'views/auth/signincheck'
			
			'auth/local/success':				'views/auth/signincheck'
			'auth/local/reset/:token':	'views/auth/localreset'
			
			'signin/extra': 						'views/auth/signinextra'
			'user/verifyemail/:email/:token': 'views/user/verifyemail'
		
		routesArray = for route, moduleId of routes
			route: route
			moduleId: moduleId
		
		router.map routesArray
		router.mapUnknownRoutes (instruction) ->
			instruction.config.moduleId = 'notfound'
			
		router.activate()
	compositionComplete: () ->
		$('.dropdown-toggle').dropdown()