define ['module', 'redis'], (module, redis) ->
	db = redis.createClient()
	
	class Feedback
		receive: (hub) =>
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
		
		configure: (app) ->
			app.route '/views/feedback', app.modulepath(module.uri) + '/public'
			app.durandal 'views/feedback/give'
		
		init: (app) =>
			app.get '/feedbackforreviewer/:id', (req, res) =>
				@get req.params.id, (err, feedback) =>
					if err?
						res.send 500, err
						return
					
					if !feedback?
						res.send 404, err
						return
					
					res.send feedback
					return
		
		get: (id, callback) ->
			db.get "feedbackforreviewer:#{id}", (err, data) =>
				if err?
					callback err
					return
				
				data = JSON.parse data
				
				callback null, data