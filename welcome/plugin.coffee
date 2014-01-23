define ['module'], (module) ->
	class Welcome
		configure: (app) ->
			app.route '/views', app.modulepath(module.uri) + '/public'
			app.durandal 'views/welcome'