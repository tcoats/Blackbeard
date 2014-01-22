define ['plugins/router', 'bootstrap'], (router, bootstrap) ->
	router: router
	
	activate: ->
		router.mapUnknownRoutes (instruction) ->
			instruction.config.moduleId = 'notfound'
		
		router.activate()
		
	compositionComplete: () ->
		$('.dropdown-toggle').dropdown()