defineQ ['knockout', 'uuid', 'odo/auth/current-user', 'plugins/router'], (ko, uuid, currentUser, router) ->
	class Description
		constructor: ->
			@userid = ko.observable null
			@description = ko.observable('')
				.extend
					required: yes
									
			@errors = ko.validation.group @
		
		activate: (options) =>
			{ @wizard, @dialog } = options
			@userid currentUser.id
			
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