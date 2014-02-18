// Generated by CoffeeScript 1.7.1
(function() {
  defineQ(['plugins/router', 'odo/inject'], function(router, inject) {
    var moduleId, route, routes, routesArray;
    routes = {
      'givefeedback/:id': 'views/feedback/give',
      'view-feedback-opportunity/:id': 'views/feedback/view-feedback-opportunity'
    };
    routesArray = (function() {
      var _results;
      _results = [];
      for (route in routes) {
        moduleId = routes[route];
        _results.push({
          route: route,
          moduleId: moduleId
        });
      }
      return _results;
    })();
    router.map(routesArray);
    return inject.bind('user/dashboard-self/in-widgets', 'views/feedback/user-feedback-in-widget');
  });

}).call(this);
