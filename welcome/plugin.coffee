define [
	'module'
	'odo/express/configure'
	'odo/durandal/plugin'
], (module, configure, durandal) ->
	class Welcome
		web: =>
			configure.route '/views', configure.modulepath(module.uri) + '/public'
			
			durandal.register 'views/welcome'