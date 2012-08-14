
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
  
  new Dragdealer('my-slider', {
    vertical: true
    horizontal: false
  })