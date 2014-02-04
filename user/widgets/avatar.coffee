defineQ ['plugins/widget', 'knockout', 'md5'], (widget, ko, md5) ->
	widget.registerKind 'avatar'
	
	class Avatar
		user: ko.observable null
		
		activate: (settings) =>
			@user settings.user
			
			@gravatarHash = ko.computed(=>
				if @user()? and @user().email?
					return md5 @user().email.trim().toLowerCase()
				''
			, @)