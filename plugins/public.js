// Generated by CoffeeScript 1.6.3
(function() {
  define(['module'], function(module) {
    return {
      configure: function(app) {
        return app.route('/', app.modulepath(module.uri) + '/../public');
      }
    };
  });

}).call(this);
