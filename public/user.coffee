define ['jquery', 'q'], ($, Q) ->
	getUser: (username) ->
		Q $.get '/blackbeard/user',
			username: username