define [
	'module'
	'odo/express/configure'
	'odo/durandal/plugin'
], (module, configure, durandal) ->
	class LunchboxSlab
		web: =>
			configure.route '/lunchboxslab', configure.modulepath(module.uri) + '/public'