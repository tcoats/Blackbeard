define ['plugins/router', 'odo/inject'], (router, inject) ->
	
	routes =
		'givefeedback/:id': 'views/feedback/give'
	
	routesArray = for route, moduleId of routes
		route: route
		moduleId: moduleId
	
	router.map routesArray
	
	inject.bind 'user/dashboard/widgets', 'views/feedback/user-feedback-widget'