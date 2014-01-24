// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['module', 'odo/express/configure', 'odo/durandal/plugin'], function(module, configure, durandal) {
    var Auth;
    return Auth = (function() {
      function Auth() {
        this.web = __bind(this.web, this);
      }

      Auth.prototype.web = function() {
        configure.route('/views/auth', configure.modulepath(module.uri) + '/public');
        return durandal.register('views/auth/routes');
      };

      return Auth;

    })();
  });

}).call(this);
