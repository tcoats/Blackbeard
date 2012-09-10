ko.bindingHandlers.slider =
  init: (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) ->
    $(element).append(
      $('<div/>')
        .addClass('handle')
        .append(
          $('<div />')
            .addClass('slide')))
    
    slider = $(element).data 'slider'
    
    if !slider?
      slider = new Dragdealer element, {
        vertical: true
        horizontal: false
        y: valueAccessor()()
      }
      $(element).data 'slider', slider
    
    slidergroup = $(element).parents '.slider-group'
    
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
      others = _.filter(sliders, (s) -> s isnt current)
      
      # how much do we have in the sliders that aren't moving
      otherstotal = _.reduce(
        others,
        (memo, s) -> memo + s.value.current[1],
        0)
      alltotal = otherstotal + y
      totaldifference = alltotal - 1.0
      
      # we should distribute by portion if we can't scale
      if otherstotal is 0
        split = totaldifference / others.length
        _.each(others, (s) ->
          currenty = s.value.current[1]
          s.setValue x, currenty - split, true
        )
        return
      
      # we should scale if the other sliders have amount
      _.each(others, (s) ->
        currenty = s.value.current[1]
        scale = currenty / otherstotal
        s.setValue x, currenty - scale * totaldifference, true
      )
  
  update: (element, valueAccessor, allBindingsAccessor, viewModel, bindingContext) ->
    slider = $(element).data('slider')
    
    if !slider?
      ko.bindingHandlers.slider.create element, valueAccessor, allBindingsAccessor, viewModel, bindingContext
      slider = $(element).data('slider')
    
    value = ko.utils.unwrapObservable(valueAccessor())
    if slider.value.target[1] != value
      slider.setValue 0, value