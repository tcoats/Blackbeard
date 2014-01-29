define [
	'redis'
	'odo/messaging/hub'
	'odo/express/app'
], (redis, hub, app) ->
	db = redis.createClient()
	
	class ViewFeedbackOpportunity
		web: =>
			# setup web services here
			app.get '/view-feedback-opportunity/:id', (req, res) =>
				db.hget 'blackbeard:viewfeedbackopportunity', req.params.id, (err, feedback) =>
					if err?
						console.log err
						res.send 500, 'Woops'
						return
					
					if !feedback?
						res.send 404, 'Not here'
						return
					
					feedback = JSON.parse feedback
					
					if req.user.id isnt feedback.for
						res.send 403, 'Authentication required'
						return
						
					res.send feedback
			
		projection: =>
			hub.receive 'feedbackOpportunityCreated', (event, cb) =>
				db.hset 'blackbeard:viewfeedbackopportunity', event.payload.id, JSON.stringify(event.payload), ->
					cb()
				
			hub.receive 'feedbackOpportunityCancelled', @remove
			hub.receive 'feedbackOpportunityCompleted', @remove
			hub.receive 'feedbackOpportunityExpired', @remove
		
		remove: (event, cb) =>
			db.hdel 'blackbeard:viewfeedbackopportunity', event.payload.id, ->
				cb()