// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['q', 'knockout', 'odo/auth'], function(Q, ko, auth) {
    var ReviewProfile;
    return ReviewProfile = (function() {
      function ReviewProfile() {
        this.close = __bind(this.close, this);
        this.activate = __bind(this.activate, this);
      }

      ReviewProfile.prototype.user = ko.observable(null);

      ReviewProfile.prototype.activate = function(options) {
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

      ReviewProfile.prototype.close = function() {
        return this.dialog.close();
      };

      return ReviewProfile;

    })();
  });

}).call(this);