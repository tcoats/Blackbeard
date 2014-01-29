define [
	'odo/express/app'
], (app) ->
	class UserFeedbackWidget
		web: =>
			# setup web services here
			app.get '/user-feedback-out-widget/:id', (req, res) =>
				if req.user.id isnt req.params.id
					res.send 403, 'Authentication required'
					return
				
				res.send {}