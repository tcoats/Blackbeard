define ['knockout', 'q', 'odo/auth', 'odo/inject', 'md5'], (ko, Q, auth, inject, md5) ->
	class DashboardSelf
		inwidgets: inject.many 'user/dashboard-self/in-widgets'
		outwidgets: inject.many 'user/dashboard-self/out-widgets'
		title: ko.observable ''
		
		viewingUser: ko.observable null
		dashboardUser: ko.observable null
		
		user: ko.observable null
		
		constructor: ->
			@gravatarHash = ko.computed(=>
				if @user()? and @user().email?
					return md5 @user().email.trim().toLowerCase()
				''
			, @)
		
		activate: (activationData) =>
			{ viewingUser, dashboardUser } = activationData
			
			@viewingUser viewingUser
			@dashboardUser dashboardUser
			
			dfd = Q.defer()
			
			auth
				.getUser()
				.then((user) =>
					@user user
					dfd.resolve())
				.fail =>
					dfd.resolve()
				
			dfd.promise