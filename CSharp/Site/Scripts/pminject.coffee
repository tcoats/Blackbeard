root = global ? (process ? this)

#todo - marker interfaces
#todo - cooler scoping (by message? by request?)
#todo - extensibility
#todo - cooler bindings (factories, etc.)
#todo - when injected into - use the context parameter of the construct method to remember what we're currently injecting into, use that value as an additional lookup into the bindings

# Poor Man's Dependency Injection Framework
class PMInject
	constructor: () ->
		# component registry indexed by key
		@factory = {}
		
		# list of how to build a component indexed by contract
		@bindings = {}
		
		# instances of components for 'single' indexed by contract + ':' + key
		@singleInstances = {}
	
	# key = what it's called (usually class name)
	# construct = how to build it, including what things to inject
	register: (key, opt1, opt2) =>
		if @factory[key]?
			throw "[pminject] '#{key}' is already registered!"
		
		if _.isArray opt1
			@factory[key] =
				key: key
				markers: opt1
				construct: opt2
		else
			@factory[key] =
				key: key
				markers: []
				construct: opt1
	
	# contract = something you want to support, usually an interface style name
	# or a description of what it does
	bind: (contract) =>
		to: (key) =>
		
			single: () =>
				@addBinding contract, key, () =>
					# have we created this instance before?
					if !@singleInstances[contract + ':' + key]?
						registration = @factory[key]
						@singleInstances["#{contract}:#{key}"] = @createFromRegistration registration
					@singleInstances["#{contract}:#{key}"]
					
			many: () =>
				@addBinding contract, key, () =>
					registration = @factory[key]
					@createFromRegistration registration
	
	addBinding: (contract, key, howToGet) =>
		if !@bindings[contract]?
			@bindings[contract] = []
		@bindings[contract].push
			# key so we can reflect over the bindings later
			key: key
			howToGet: howToGet
	
	createFromRegistration: (registration) =>
		registration.construct @
				
	one: (contract) =>
		console.log "[pminject] Injecting one '#{contract}'"
		bindings = @getBindings contract
		if bindings.length > 1
			throw "[pminject] '#{contract}' has too many bindings to inject one!"
		bindings[0].howToGet()
			
	many: (contract) =>
		console.log "[pminject] Injecting many '#{contract}'"
		@getBindings(contract).map b -> b.howToGet()
	
	new: (contract) =>
		console.log "[pminject] New '#{contract}'"
		bindings = @getBindings contract
		if bindings.length > 1
			throw "[pminject] '#{contract}' has too many bindings to new!"
		registration = @factory[bindings[0].key]
		@createFromRegistration registration
		
	getBindings: (contract) =>
		if !@bindings[contract]?
			throw "[pminject] No bindings found for '#{contract}'!"
		@bindings[contract]
		
root.inject = new PMInject