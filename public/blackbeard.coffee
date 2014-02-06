requirejs.config
	# work out a way for each odo plugin to insert itself here?
	paths:
		text: 'requirejs-text/text'
		async: 'requirejs-plugins/src/async',
		font: 'requirejs-plugins/src/font',
		goog: 'requirejs-plugins/src/goog',
		image: 'requirejs-plugins/src/image',
		json: 'requirejs-plugins/src/json',
		noext: 'requirejs-plugins/src/noext',
		mdown: 'requirejs-plugins/src/mdown',
		propertyParser : 'requirejs-plugins/src/propertyParser',
		markdownConverter : 'requirejs-plugins/lib/Markdown.Converter'
		durandal: 'durandal/js'
		plugins: 'durandal/js/plugins'
		transitions: 'odo/durandal/transitions'
		components: 'odo/durandal/components'
		knockout: 'knockout.js/knockout'
		# I've made a change to this library so it's copied locally. A pull request is in :)
		#'ko.validation': 'ko-validation/dist/knockout.validation.min'
		'ko.validation': 'bindings/knockout.validation.min'
		bootstrap: 'bootstrap/dist/js/bootstrap.min'
		bootstrapcss: 'bootstrap/dist/css/bootstrap.min'
		jquery: 'jquery/jquery.min'
		animatecss: 'animate.css/animate.min'
		fontawesome: 'font-awesome/css/font-awesome.min'
		
		uuid: 'node-uuid/uuid'
		q: 'q/q'
		
		odo: 'odo'
		'local/plugins': 'plugins'
		'local/widgets': 'widgets'
		
		mousetrap: 'mousetrap/mousetrap.min'
		marked: 'marked/lib/marked'

	map:
		'*':
			css: 'require-css/css.min'

	shim:
		bootstrap:
			deps: ['jquery']
			exports: 'jQuery'
		'ko.validation':
			deps: ['knockout']
			
		mousetrap:
			exports: 'Mousetrap'
		marked:
			exports: 'marked'
	
	# don't cache in development
	urlArgs: 'v=' + (new Date()).getTime()

# Interesting - can check for 'loaded' status, but there is no callback. Could use this for cool loading animation - ticking large resources as they load
#setInterval(->
#	console.log requirejs.defined 'slider'
#, 100)

define [
	'durandal/system'
	'durandal/app'
], (system, app) ->
		system.debug yes
		app.title = 'Blackbeard'
		app.configurePlugins
			router: yes
			dialog: yes
			widget: yes
		
		# components
		requirejs [
			'odo/durandal/plugins/router'
			'odo/durandal/plugins/dialog'
			'odo/durandal/plugins/bootstrap'
			'odo/durandal/plugins/validation'
			'odo/durandal/plugins/q'
			'odo/durandal/plugins/mousetrap'
			'odo/durandal/plugins/marked'
			'odo/durandal/plugins/viewLocator'
			'odo/durandal/plugins/widget'
			'local/plugins/slider'
			'css!bootstrapcss'
			'font!google,families:[Coming Soon,Patrick Hand]'
			'css!fontawesome'
			'css!odo/durandal/odo'
			'css!rustic'
			'css!blackbeard'
			'css!animatecss'
		], ->
			
			$.get('/odo/components').then (components) ->
				requirejs components, ->
					app.start().then -> app.setRoot 'shell'