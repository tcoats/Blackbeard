define ['module', 'odo/messaging/hub', 'odo/express/configure', 'odo/express/app', 'odo/durandal/plugin', 'redis'], (module, hub, configure, app, durandal, redis) ->
	db = redis.createClient()
	
	class Feedback
		web: =>
			configure.route '/views/feedback', configure.modulepath(module.uri) + '/public'
			durandal.register 'views/feedback/bindings'
		
			app.get '/feedbackforreviewer/:id', @feedbackforreviewer
		
		feedbackforreviewer: (req, res) =>
			@get req.params.id, (err, feedback) =>
				if err?
					res.send 500, err
					return
				
				if !feedback?
					res.send 404, err
					return
				
				res.send feedback
				return
		
		projection: =>
			hub.receive 'feedbackBegun', (event, cb) =>
				feedback =
					id: event.payload.id
					type: event.payload.type
					options: event.payload.options
					description: event.payload.name
					
					reviewer: event.payload.reviewer
				
				db.set "feedbackforreviewer:#{feedback.id}", JSON.stringify feedback, ->
					cb()

			hub.receive 'feedbackCancelled', (event, cb) =>
				id = event.payload.id
				db.del "feedbackforreviewer:#{id}", ->
					cb()

			hub.receive 'feedbackCompleted', (event, cb) =>
				id = event.payload.id
				db.del "feedbackforreviewer:#{id}", ->
					cb()
		
		get: (id, callback) ->
			db.get "feedbackforreviewer:#{id}", (err, data) =>
				if err?
					callback err
					return
				
				data = JSON.parse data
				
				callback null, data