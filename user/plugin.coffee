define [
	'module'
	'odo/messaging/hub'
	'odo/express/configure'
	'odo/express/app'
	'odo/durandal/plugin'
	'redis'
	'odo/user/userprofile'
], (module, hub, configure, app, durandal, redis, UserProfile) ->
	db = redis.createClient()
	
	class User
		web: =>
			configure.route '/', configure.modulepath(module.uri) + '/public'
			configure.route '/views/user', configure.modulepath(module.uri) + '/views'
			configure.route '/widgets', configure.modulepath(module.uri) + '/widgets'
			durandal.register 'user'
			durandal.register 'local/widgets/avatar'
			
			app.get '/blackbeard/user', @user
			
		projection: =>
			hub.receive 'userHasUsername', (event, cb) =>
				db.hset 'blackbeard:username', event.payload.username, event.payload.id, cb
		
		user: (req, res) =>
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
					
					if !user?
						callback null, null
						return
					
					callback null,
						id: user.id
						displayName: user.displayName
						username: user.username