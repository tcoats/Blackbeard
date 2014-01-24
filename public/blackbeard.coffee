﻿requirejs.config
	# work out a way for each odo plugin to insert itself here?
	paths:
		text: 'requirejs-text/text'
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
		
		mousetrap: 'mousetrap/mousetrap.min'
		marked: 'marked/lib/marked'
		slider: 'bindings/slider'

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

define [
	'jquery'
	'durandal/system'
	'durandal/app'
	'durandal/viewLocator'
	'odo/durandal/bindings'
	'bindings/blackbeardbindings'
], ($, system, app, locator, bindings, blackbeardbindings) ->
		system.debug yes
		app.title = 'Blackbeard'
		app.configurePlugins
			router: yes
			dialog: yes
			widget: yes
		
		bindings.init requirejs,
			router: yes
			mousetrap: yes
			q: yes
			bootstrap: yes
			marked: yes
			dialog: yes
			validation: yes
		
		blackbeardbindings.init requirejs,
			slider: yes
		
		$.get('/odo/components').then (components) ->
			requirejs components, ->
				app.start().then ->
					#Replace 'viewmodels' in the moduleId with 'views' to locate the view.
					#Look for partial views in a 'views' folder in the root.
					locator.useConvention 'views'
					
					#Show the app by setting the root view model for our application
					app.setRoot 'shell'