requirejs.config
	# work out a way for each odo plugin to insert itself here?
	paths:
		text: 'requirejs-text/text'
		durandal: 'durandal/js'
		plugins: 'durandal/js/plugins'
		knockout: 'knockout.js/knockout'
		'ko.validation': 'ko-validation/dist/knockout.validation.min'
		bootstrap: 'bootstrap/dist/js/bootstrap.min'
		jquery: 'jquery/jquery.min'
		underscore: 'underscore/underscore-min'
		mousetrap: 'mousetrap/mousetrap.min'
		uuid: 'node-uuid/uuid'
		marked: 'marked/lib/marked'
		transitions: 'odo/durandal/transitions'
		components: 'odo/durandal/components'
		odo: 'odo'
		q: 'q/q'
		slider: 'bindings/slider'

	shim:
		bootstrap:
			deps: ['jquery']
			exports: 'jQuery'
		underscore:
			exports: '_'
		mousetrap:
			exports: 'Mousetrap'
		marked:
			exports: 'marked'
		'ko.validation':
			deps: ['knockout']
	
	# don't cache in development
	urlArgs: 'v=' + (new Date()).getTime()

define ['durandal/system', 'durandal/app', 'durandal/viewLocator', 'odo/durandal/bindings', 'bindings/blackbeardbindings'], (system, app, locator, bindings, blackbeardbindings) ->
		system.debug yes
		app.title = 'Blackbeard'
		app.configurePlugins
			router: yes
			dialog: yes
			widget: yes
		
		bindings.init requirejs,
			mousetrap: yes
			q: yes
			bootstrap: yes
			marked: yes
			dialog: yes
			validation: yes
		
		blackbeardbindings.init requirejs,
			slider: yes

		app.start().then ->
			#Replace 'viewmodels' in the moduleId with 'views' to locate the view.
			#Look for partial views in a 'views' folder in the root.
			locator.useConvention 'views'
			
			#Show the app by setting the root view model for our application
			app.setRoot 'views/shell'