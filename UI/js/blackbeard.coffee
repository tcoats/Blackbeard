
model = new Backbone.Model {
  projects: new Backbone.Collection [
    new Backbone.Model {
      name: "Project 1"
    }
    new Backbone.Model {
      name: "Project 2"
    }
    new Backbone.Model {
      name: "Project 3"
    }
  ]
}


$ () ->
  ko.applyBindings new kb.ViewModel model
  
  # todo - scale not offset the difference
  sliders = []
  _.each $('.slider'), (silder) ->
    sliders.push new Dragdealer(silder, {
      vertical: true
      horizontal: false
      y: 0.3333333
      animationCallback: (x, y) ->
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
    })