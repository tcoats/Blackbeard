// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['q', 'knockout', 'odo/auth'], function(Q, ko, auth) {
    var GoogleProfile;
    return GoogleProfile = (function() {
      function GoogleProfile() {
        this.back = __bind(this.back, this);
        this.activate = __bind(this.activate, this);
      }

      GoogleProfile.prototype.user = ko.observable(null);

      GoogleProfile.prototype.activate = function(options) {
        var dfd,
          _this = this;
        this.wizard = options.wizard, this.dialog = options.dialog;
        dfd = Q.defer();
        auth.getUser().then(function(user) {
          _this.user(user);
          return dfd.resolve(true);
        }).fail(function(err) {
          return dfd.resolve(true);
        });
        return dfd.promise;
      };

      GoogleProfile.prototype.back = function() {
        return this.wizard.back({
          model: 'views/user/profile/review'
        })();
      };

      return GoogleProfile;

    })();
  });

}).call(this);
