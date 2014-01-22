define ['plugins/router'], (router) ->
	routes =
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
	
	routesArray = for route, moduleId of routes
		route: route
		moduleId: moduleId
	
	router.map routesArray