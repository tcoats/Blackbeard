define ['module', 'redis', 'odo/projections/userprofile'], (module, redis, UserProfile) ->
	db = redis.createClient()
	
	class User
		constructor: ->
			@receive =
				userHasUsername: (event, cb) =>
					db.hset 'blackbeard:username', event.payload.username, event.payload.id, cb
					
		get: (username, callback) ->
			db.hget 'blackbeard:username', username, (err, userid) =>
				if err?
					console.log err
					callback err
					return
				
				new UserProfile().get userid, (err, user) =>
					if err?
						console.log err
						callback err
						return
					
					callback null,
						displayName: user.displayName
						username: user.username
		
		configure: (app) ->
			app.route '/', app.modulepath(module.uri) + '/user-public'
			app.durandal 'user'
		
		init: (app) =>
			app.get '/blackbeard/user', (req, res) =>
				if !req.query.username?
					res.send 'Username required'
					return
				
				@get req.query.username, (err, user) =>
					if err?
						console.log err
						res.send 500, 'Woops'
						return
					
					if !user?
						res.send 404, 'User not found'
						return
					
					res.send user