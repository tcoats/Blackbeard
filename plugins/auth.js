// Generated by CoffeeScript 1.6.3
(function() {
  define(['module'], function(module) {
    var Auth;
    return Auth = (function() {
      function Auth() {}

      Auth.prototype.configure = function(app) {
        app.route('/views/auth', app.modulepath(module.uri) + '/auth-public');
        return app.durandal('views/auth/routes');
      };

      return Auth;

    })();
  });

}).call(this);
