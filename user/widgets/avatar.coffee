define ['user', 'plugins/widget', 'knockout'], (user, widget, ko) ->
	widget.registerKind 'avatar'
	
	class Avatar
		
		constructor: ->
			@user = ko.observable null
			@size = ko.observable 180
			@hasMenu = ko.observable yes
			@image = ko.observable null
			@gravatarHash = ko.computed(=>
				if @user()? and @user().emailHash?
					return @user().emailHash
			, @)
			@src = ko.computed(=>
				if @image()?
					return @image()
				
				'http://gravatar.com/avatar/' + @gravatarHash() + '?s=180&d=identicon'
			, @)
		
		activate: (settings) =>
			if settings.size?
				@size settings.size
			if settings.hasMenu?
				@hasMenu settings.hasMenu
			if settings.image?
				@image settings.image
				
			if !@image()? or @hasMenu()
				user
					.getUser(settings.username)
					.then((user) => @user user)
					.done()
