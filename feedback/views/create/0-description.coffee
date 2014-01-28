define ['knockout', 'uuid', 'odo/auth', 'plugins/router'], (ko, uuid, auth, router) ->
	class Description
		userid: ko.observable null
		
		constructor: ->
			@description = ko.observable('')
				.extend
					required: yes
									
			@errors = ko.validation.group @
		
		activate: (options) =>
			{ @wizard, @dialog } = options
			auth.getUser().then (user) => @userid user.id
			
		close: =>
			@dialog.close()
		
		createFeedbackOpportunity: =>
			if @isValidating()
				return
				
			if !@isValid()
				@dialog.shake()
				@errors.showAllMessages()
				return
			
			feedback =
				id: uuid.v1()
				for: @userid
				description: @description()
				
			$
				.post('/sendcommand/createFeedbackOpportunity', feedback)
				.then =>
					@dialog.close()
					router.navigate "/view-feedback-opportunity/#{feedback.id}"