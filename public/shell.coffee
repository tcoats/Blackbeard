define ['plugins/router', 'durandal/app', 'bootstrap', 'knockout'], (router, app, bootstrap, ko) ->
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
		
		subscription = null
		router.updateDocumentTitle = (instance, instruction) ->
			if subscription?
				subscription.dispose()
				subscription = null
			
			update = ->
				parts = []
				
				if instance.title?
					parts.push ko.unwrap instance.title
					
				if instruction.config.title?
					parts.push instruction.config.title
				
				if app.title?
					parts.push app.title
				
				# clear out any empty strings
				parts = parts.filter (part) -> part isnt ''
				
				document.title = parts.join ' - ' 
			update()
			
			# changes to an observable title are reflected
			# TODO: cancel the subscription if we've navigated
			if instance.title? and ko.isObservable instance.title
				subscription = instance.title.subscribe ->
					update()
		
		router.activate()
	compositionComplete: () ->
		$('.dropdown-toggle').dropdown()