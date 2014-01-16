// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['q', 'knockout', 'odo/auth'], function(Q, ko, auth) {
    var FacebookProfile;
    return FacebookProfile = (function() {
      function FacebookProfile() {
        this.back = __bind(this.back, this);
        this.disconnect = __bind(this.disconnect, this);
        this.stopDisconnect = __bind(this.stopDisconnect, this);
        this.startDisconnect = __bind(this.startDisconnect, this);
        this.activate = __bind(this.activate, this);
      }

      FacebookProfile.prototype.user = ko.observable(null);

      FacebookProfile.prototype.activate = function(options) {
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

      FacebookProfile.prototype.disconnectStarted = ko.observable(false);

      FacebookProfile.prototype.startDisconnect = function() {
        return this.disconnectStarted(true);
      };

      FacebookProfile.prototype.stopDisconnect = function() {
        return this.disconnectStarted(false);
      };

      FacebookProfile.prototype.disconnect = function() {
        var _this = this;
        return auth.disconnectFacebookFromUser(this.user().id, this.user().facebook.profile).then(function() {
          return _this.back();
        });
      };

      FacebookProfile.prototype.back = function() {
        return this.wizard.back({
          model: 'views/user/profile/review'
        })();
      };

      return FacebookProfile;

    })();
  });

}).call(this);
