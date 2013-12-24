define [], ->
	###
	Dragdealer JS v0.9.5
	http://code.ovidiu.ch/dragdealer-js

	Copyright (c) 2010, Ovidiu Chereches
	MIT License
	http://legal.ovidiu.ch/licenses/MIT
	###

	# Cursor 
	Cursor =
		x: 0
		y: 0
		init: ->
			@setEvent "mouse"
			@setEvent "touch"

		setEvent: (type) ->
			moveHandler = document["on" + type + "move"] or ->

			document["on" + type + "move"] = (e) ->
				moveHandler e
				Cursor.refresh e

		refresh: (e) ->
			e = window.event  unless e
			if e.type is "mousemove"
				@set e
			else @set e.touches[0]  if e.touches

		set: (e) ->
			if e.pageX or e.pageY
				@x = e.pageX
				@y = e.pageY
			else if e.clientX or e.clientY
				@x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft
				@y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop

	Cursor.init()

	# Position 
	Position = get: (obj) ->
		curleft = curtop = 0
		if obj.offsetParent
			loop
				curleft += obj.offsetLeft
				curtop += obj.offsetTop
				break unless (obj = obj.offsetParent)
		[curleft, curtop]


	# Slider 
	Slider = (wrapper, options) ->
		wrapper = document.getElementById(wrapper) if typeof (wrapper) is "string"
		return unless wrapper
		handle = wrapper.getElementsByTagName("div")[0]
		return if not handle or handle.className.search(/(^|\s)handle(\s|$)/) is -1
		@init wrapper, handle, options or {}
		@setup()
		return

	Slider:: =
		init: (wrapper, handle, options) ->
			@wrapper = wrapper
			@handle = handle
			@options = options
			@disabled = @getOption("disabled", false)
			@horizontal = @getOption("horizontal", true)
			@vertical = @getOption("vertical", false)
			@slide = @getOption("slide", true)
			@steps = @getOption("steps", 0)
			@snap = @getOption("snap", false)
			@loose = @getOption("loose", false)
			@speed = @getOption("speed", 10) / 100
			@xPrecision = @getOption("xPrecision", 0)
			@yPrecision = @getOption("yPrecision", 0)
			@callback = options.callback or null
			@animationCallback = options.animationCallback or null
			@bounds =
				left: options.left or 0
				right: -(options.right or 0)
				top: options.top or 0
				bottom: -(options.bottom or 0)
				x0: 0
				x1: 0
				xRange: 0
				y0: 0
				y1: 0
				yRange: 0

			@value =
				prev: [-1, -1]
				current: [options.x or 0, options.y or 0]
				target: [options.x or 0, options.y or 0]

			@offset =
				wrapper: [0, 0]
				mouse: [0, 0]
				prev: [-999999, -999999]
				current: [0, 0]
				target: [0, 0]

			@change = [0, 0]
			@activity = false
			@dragging = false
			@tapping = false

		getOption: (name, defaultValue) ->
			(if @options[name] isnt `undefined` then @options[name] else defaultValue)

		setup: ->
			@setWrapperOffset()
			@setBoundsPadding()
			@setBounds()
			@setSteps()
			@addListeners()

		setWrapperOffset: ->
			@offset.wrapper = Position.get(@wrapper)

		setBoundsPadding: ->
			if not @bounds.left and not @bounds.right
				@bounds.left = Position.get(@handle)[0] - @offset.wrapper[0]
				@bounds.right = -@bounds.left
			if not @bounds.top and not @bounds.bottom
				@bounds.top = Position.get(@handle)[1] - @offset.wrapper[1]
				@bounds.bottom = -@bounds.top

		setBounds: ->
			@bounds.x0 = @bounds.left
			@bounds.x1 = @wrapper.offsetWidth + @bounds.right
			@bounds.xRange = (@bounds.x1 - @bounds.x0) - @handle.offsetWidth
			@bounds.y0 = @bounds.top
			@bounds.y1 = @wrapper.offsetHeight + @bounds.bottom
			@bounds.yRange = (@bounds.y1 - @bounds.y0) - @handle.offsetHeight
			@bounds.xStep = 1 / (@xPrecision or Math.max(@wrapper.offsetWidth, @handle.offsetWidth))
			@bounds.yStep = 1 / (@yPrecision or Math.max(@wrapper.offsetHeight, @handle.offsetHeight))

		setSteps: ->
			if @steps > 1
				@stepRatios = []
				i = 0

				while i <= @steps - 1
					@stepRatios[i] = i / (@steps - 1)
					i++

		addListeners: ->
			self = this
			@wrapper.onselectstart = ->
				false

			@handle.onmousedown = @handle.ontouchstart = (e) ->
				self.handleDownHandler e

			@wrapper.onmousedown = @wrapper.ontouchstart = (e) ->
				self.wrapperDownHandler e

			mouseUpHandler = document.onmouseup or ->

			document.onmouseup = (e) ->
				mouseUpHandler e
				self.documentUpHandler e

			touchEndHandler = document.ontouchend or ->

			document.ontouchend = (e) ->
				touchEndHandler e
				self.documentUpHandler e

			resizeHandler = window.onresize or ->

			window.onresize = (e) ->
				resizeHandler e
				self.documentResizeHandler e

			@wrapper.onmousemove = (e) ->
				self.activity = true

			@wrapper.onclick = (e) ->
				not self.activity

			@interval = setInterval(->
				self.animate()
			, 25)
			self.animate false, true

		handleDownHandler: (e) ->
			@activity = false
			Cursor.refresh e
			@preventDefaults e, true
			@startDrag()
			@cancelEvent e

		wrapperDownHandler: (e) ->
			Cursor.refresh e
			@preventDefaults e, true
			@startTap()

		documentUpHandler: (e) ->
			@stopDrag()
			@stopTap()

		
		#this.cancelEvent(e);
		documentResizeHandler: (e) ->
			@setWrapperOffset()
			@setBounds()
			@update()

		enable: ->
			@disabled = false
			@handle.className = @handle.className.replace(/\s?disabled/g, "")

		disable: ->
			@disabled = true
			@handle.className += " disabled"

		setStep: (x, y, snap) ->
			@setValue (if @steps and x > 1 then (x - 1) / (@steps - 1) else 0), (if @steps and y > 1 then (y - 1) / (@steps - 1) else 0), snap

		setValue: (x, y, snap) ->
			self = this
			@setTargetValue [x, y or 0]
			if snap
				@groupCopy @value.current, @value.target
				@update()

		startTap: (target) ->
			return  if @disabled
			@tapping = true
			target = [Cursor.x - @offset.wrapper[0] - (@handle.offsetWidth / 2), Cursor.y - @offset.wrapper[1] - (@handle.offsetHeight / 2)]  if target is `undefined`
			@setTargetOffset target

		stopTap: ->
			return  if @disabled or not @tapping
			@tapping = false
			@setTargetValue @value.current
			@result()

		startDrag: ->
			return  if @disabled
			@offset.mouse = [Cursor.x - Position.get(@handle)[0], Cursor.y - Position.get(@handle)[1]]
			@dragging = true

		stopDrag: ->
			return  if @disabled or not @dragging
			@dragging = false
			target = @groupClone(@value.current)
			if @slide
				ratioChange = @change
				target[0] += ratioChange[0] * 4
				target[1] += ratioChange[1] * 4
			@setTargetValue target
			@result()

		feedback: ->
			value = @value.current
			value = @getClosestSteps(value)  if @snap and @steps > 1
			unless @groupCompare(value, @value.prev)
				@animationCallback value[0], value[1]  if typeof (@animationCallback) is "function"
				@groupCopy @value.prev, value

		result: ->
			@callback @value.target[0], @value.target[1]  if typeof (@callback) is "function"

		animate: (direct, first) ->
			return if direct and not @dragging
			if @dragging
				prevTarget = @groupClone(@value.target)
				offset = [Cursor.x - @offset.wrapper[0] - @offset.mouse[0], Cursor.y - @offset.wrapper[1] - @offset.mouse[1]]
				@setTargetOffset offset, @loose
				@change = [@value.target[0] - prevTarget[0], @value.target[1] - prevTarget[1]]
			@groupCopy @value.current, @value.target  if @dragging or first
			if @dragging or @glide() or first
				@update()
				@feedback()

		glide: ->
			diff = [@value.target[0] - @value.current[0], @value.target[1] - @value.current[1]]
			return false  if not diff[0] and not diff[1]
			if Math.abs(diff[0]) > @bounds.xStep or Math.abs(diff[1]) > @bounds.yStep
				@value.current[0] += diff[0] * @speed
				@value.current[1] += diff[1] * @speed
			else
				@groupCopy @value.current, @value.target
			true

		update: ->
			unless @snap
				@offset.current = @getOffsetsByRatios(@value.current)
			else
				@offset.current = @getOffsetsByRatios(@getClosestSteps(@value.current))
			@show()

		show: ->
			unless @groupCompare(@offset.current, @offset.prev)
				@handle.style.left = String(@offset.current[0]) + "px"  if @horizontal
				@handle.style.top = String(@offset.current[1]) + "px"  if @vertical
				@groupCopy @offset.prev, @offset.current

		setTargetValue: (value, loose) ->
			target = (if loose then @getLooseValue(value) else @getProperValue(value))
			@groupCopy @value.target, target
			@offset.target = @getOffsetsByRatios(target)

		setTargetOffset: (offset, loose) ->
			value = @getRatiosByOffsets(offset)
			target = (if loose then @getLooseValue(value) else @getProperValue(value))
			@groupCopy @value.target, target
			@offset.target = @getOffsetsByRatios(target)

		getLooseValue: (value) ->
			proper = @getProperValue(value)
			[proper[0] + ((value[0] - proper[0]) / 4), proper[1] + ((value[1] - proper[1]) / 4)]

		getProperValue: (value) ->
			proper = @groupClone(value)
			proper[0] = Math.max(proper[0], 0)
			proper[1] = Math.max(proper[1], 0)
			proper[0] = Math.min(proper[0], 1)
			proper[1] = Math.min(proper[1], 1)
			proper = @getClosestSteps(proper)  if @steps > 1  if (not @dragging and not @tapping) or @snap
			proper

		getRatiosByOffsets: (group) ->
			[@getRatioByOffset(group[0], @bounds.xRange, @bounds.x0), @getRatioByOffset(group[1], @bounds.yRange, @bounds.y0)]

		getRatioByOffset: (offset, range, padding) ->
			(if range then (offset - padding) / range else 0)

		getOffsetsByRatios: (group) ->
			[
				@getOffsetByRatio(group[0], @bounds.xRange, @bounds.x0)
				@getOffsetByRatio(group[1], @bounds.yRange, @bounds.y0)]

		getOffsetByRatio: (ratio, range, padding) ->
			Math.round(ratio * range) + padding

		getClosestSteps: (group) ->
			[@getClosestStep(group[0]), @getClosestStep(group[1])]

		getClosestStep: (value) ->
			k = 0
			min = 1
			i = 0

			while i <= @steps - 1
				if Math.abs(@stepRatios[i] - value) < min
					min = Math.abs(@stepRatios[i] - value)
					k = i
				i++
			@stepRatios[k]

		groupCompare: (a, b) ->
			a[0] is b[0] and a[1] is b[1]

		groupCopy: (a, b) ->
			a[0] = b[0]
			a[1] = b[1]

		groupClone: (a) ->
			[a[0], a[1]]

		preventDefaults: (e, selection) ->
			e = window.event  unless e
			e.preventDefault()  if e.preventDefault
			e.preventDefault()
			document.selection.empty()  if selection and document.selection

		cancelEvent: (e) ->
			e = window.event  unless e
			e.stopPropagation()  if e.stopPropagation
			e.cancelBubble = true
	
	Slider