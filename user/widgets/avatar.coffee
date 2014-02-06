defineQ ['user', 'plugins/widget', 'knockout'], (user, widget, ko) ->
	widget.registerKind 'avatar'
	
	class Avatar
		user: ko.observable null
		
		constructor: ->
			@gravatarHash = ko.computed(=>
				if @user()? and @user().emailHash?
					return @user().emailHash
			, @)
		
		activate: (settings) =>
			user
				.getUser(settings.username)
				.then((user) => @user user)
				.done()