define ['module', 'odo/express/configure', 'odo/durandal/plugin'], (module, configure, durandal) ->
	class Auth
		web: =>
			configure.route '/views/auth', configure.modulepath(module.uri) + '/public'
			durandal.register 'views/auth/bindings'