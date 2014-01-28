define [
	'redis'
	'odo/messaging/hub'
	'odo/express/app'
], (redis, hub, app) ->
	db = redis.createClient()
	
	class UserFeedbackWidget
		web: =>
			# setup web services here
			app.get '/user-feedback-widget/:id', (req, res) =>
				if req.user.id isnt req.params.id
					res.send 403, 'Authentication required'
					return
				
				db.hget 'blackbeard:userfeedbackwidget', req.params.id, (err, data) =>
					if err?
						console.log err
						cb err
						return
					
					data = JSON.parse data
					
					if !data?
						data = {}
						
					res.send data
			
		projection: =>
			hub.receive 'feedbackOpportunityCreated', (event, cb) =>
				console.log 'UserFeedbackWidget feedbackOpportunityCreated'
				@addOrRemoveValues event, cb, (data) =>
					data[event.payload.id] = event.payload
					data
				
			hub.receive 'feedbackOpportunityCancelled', (event, cb) =>
				@addOrRemoveValues event, cb, (data) =>
					delete data[event.payload.id]
					data
			
			hub.receive 'feedbackOpportunityCompleted', (event, cb) =>
				@addOrRemoveValues event, cb, (data) =>
					delete data[event.payload.id]
					data
				
			hub.receive 'feedbackOpportunityExpired', (event, cb) =>
				@addOrRemoveValues event, cb, (data) =>
					delete data[event.payload.id]
					data
				
		addOrRemoveValues: (event, cb, callback) =>
			db.hget 'blackbeard:userfeedbackwidget', event.payload.for, (err, data) =>
				if err?
					console.log err
					cb err
					return
				
				data = JSON.parse data
				data = {} if !data?
				data = callback data
				
				db.hset 'blackbeard:userfeedbackwidget', event.payload.for, JSON.stringify(data), ->
					cb()