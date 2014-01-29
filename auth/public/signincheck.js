// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['q', 'odo/auth'], function(Q, auth) {
    var SigninCheck;
    return SigninCheck = (function() {
      function SigninCheck() {
        this.canActivate = __bind(this.canActivate, this);
      }

      SigninCheck.prototype.canActivate = function() {
        var dfd,
          _this = this;
        dfd = Q.defer();
        auth.getUser().then(function(user) {
          if ((user.email != null) && (user.username != null)) {
            dfd.resolve({
              redirect: "#user/" + user.username
            });
          }
          return dfd.resolve({
            redirect: '#signin/extra'
          });
        }).fail(function(err) {
          return dfd.resolve(false);
        });
        return dfd.promise;
      };

      return SigninCheck;

    })();
  });

}).call(this);
