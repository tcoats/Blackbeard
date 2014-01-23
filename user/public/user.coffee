define ['plugins/router', 'jquery', 'q'], (router, $, Q) ->
	routes =
		'user/verifyemail/:email/:token': 'views/user/verifyemail'
		'user/:username':						'views/user/dashboard'
	
	routesArray = for route, moduleId of routes
		route: route
		moduleId: moduleId
	
	router.map routesArray
	
	getUser: (username) ->
		Q $.get '/blackbeard/user',
			username: username