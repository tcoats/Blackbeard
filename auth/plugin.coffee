define ['module'], (module) ->
	class Auth
		configure: (app) ->
			app.route '/views/auth', app.modulepath(module.uri) + '/public'
			app.durandal 'views/auth/routes'