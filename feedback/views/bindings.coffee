define ['plugins/router', 'odo/inject'], (router, inject) ->
	
	routes =
		'givefeedback/:id': 'views/feedback/give'
		'view-feedback-opportunity/:id': 'views/feedback/view-feedback-opportunity'
	
	routesArray = for route, moduleId of routes
		route: route
		moduleId: moduleId
	
	router.map routesArray
	
	inject.bind 'user/dashboard-self/widgets', 'views/feedback/user-feedback-widget'