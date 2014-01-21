// Generated by CoffeeScript 1.6.3
(function() {
  define(['plugins/router', 'bootstrap'], function(router, bootstrap) {
    return {
      router: router,
      activate: function() {
        var moduleId, route, routes, routesArray;
        routes = {
          '': 'views/welcome',
          'givefeedback/:id': 'views/feedback/give',
          '_=_': 'views/auth/facebook',
          'auth/facebook/failure': 'views/auth/facebook-failure',
          'auth/facebook/success': 'views/auth/signincheck',
          'auth/twitter/failure': 'views/auth/twitter-failure',
          'auth/twitter/success': 'views/auth/signincheck',
          'auth/google/failure': 'views/auth/google-failure',
          'auth/google/success': 'views/auth/signincheck',
          'auth/local/success': 'views/auth/signincheck',
          'auth/local/reset/:token': 'views/auth/localreset',
          'signin/extra': 'views/auth/signinextra',
          'user/verifyemail/:email/:token': 'views/user/verifyemail'
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
        router.mapUnknownRoutes(function(instruction) {
          return instruction.config.moduleId = 'notfound';
        });
        return router.activate();
      },
      compositionComplete: function() {
        return $('.dropdown-toggle').dropdown();
      }
    };
  });

}).call(this);
