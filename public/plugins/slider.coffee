﻿define ['knockout', 'jquery', 'local/plugins/dragdealer'], (ko, $, Slider) ->
	ko.bindingHandlers.slider =
		init: (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) ->
			bind = ->
				$(element).append(
					$('<div/>')
						.addClass('handle')
						.append(
							$('<div />')
								.addClass('slide')))
				
				slider = $(element).data 'slider'
				
				if !slider?
					slider = new Slider element, {
						vertical: true
						horizontal: false
						y: valueAccessor()()
					}
					$(element).data 'slider', slider
				
				slidergroup = $(element).parents '.slider-group'
				
				# wait awhile then make sure we've recorded the proper offsets
				setTimeout(->
					slider.setWrapperOffset()
					slider.setBounds()
					slider.update()
				, 200)
				
				# wait awhile then make sure we've recorded the proper offsets
				setTimeout(->
					slider.setWrapperOffset()
					slider.setBounds()
					slider.update()
				, 1000)
				
				# if we aren't in a group updating is easy
				if !slidergroup.length
					slider.animationCallback = (x, y) ->
						valueAccessor() slider.value.target[1]
					return
				
				# we've detected that this slider is in a group
				# we should access the other sliders in the group
				# and scale them as we move
				
				sliders = slidergroup.data 'sliders'
				if !sliders?
					sliders = []
				
				sliders.push slider
				
				slidergroup.data 'sliders', sliders
				
				slider.animationCallback = (x, y) ->
					valueAccessor() y
					
					current = @
					others = sliders.filter (s) -> s isnt current
					
					# how much do we have in the sliders that aren't moving
					otherstotal = 0
					for other in others
						otherstotal += other.value.current[1]
					alltotal = otherstotal + y
					totaldifference = alltotal - 1.0
					
					# we should distribute by portion if we can't scale
					if otherstotal is 0
						split = totaldifference / others.length
						for other in others
							currenty = other.value.current[1]
							other.setValue x, currenty - split, true
						return
					
					# we should scale if the other sliders have amount
					for other in others
						currenty = other.value.current[1]
						scale = currenty / otherstotal
						other.setValue x, currenty - scale * totaldifference, true
			
			# setTimeout the whole thing. Feels like a hack
			wait = ->
				setTimeout(->
					if $(element).is(':visible')
						bind()
					else
						wait()
				, 10)
			wait()
		
		update: (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) ->
			slider = $(element).data('slider')
			
			if !slider?
				return
			
			value = ko.utils.unwrapObservable(valueAccessor())
			
			if slider.value.target[1] isnt value
				slider.setValue 0, value