// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['q', 'knockout', 'odo/auth', 'components/dialog'], function(Q, ko, auth, Dialog) {
    var VerifyEmail;
    return VerifyEmail = (function() {
      function VerifyEmail() {
        this.showProfile = __bind(this.showProfile, this);
        this.activate = __bind(this.activate, this);
      }

      VerifyEmail.prototype.isTokenValid = ko.observable(false);

      VerifyEmail.prototype.result = ko.observable(null);

      VerifyEmail.prototype.email = ko.observable(null);

      VerifyEmail.prototype.token = ko.observable(null);

      VerifyEmail.prototype.activate = function(email, token) {
        var dfd,
          _this = this;
        this.email(email);
        this.token(token);
        dfd = Q.defer();
        auth.checkEmailVerificationToken(this.email(), this.token()).then(function(result) {
          _this.isTokenValid(result.isValid);
          _this.result(result);
          return auth.assignEmailAddressToUserWithToken(_this.email(), _this.token()).then(function() {
            return dfd.resolve(true);
          });
        }).fail(function() {
          return dfd.resolve(false);
        });
        return dfd.promise;
      };

      VerifyEmail.prototype.showProfile = function() {
        return new Dialog({
          model: 'views/user/profile'
        }).show();
      };

      return VerifyEmail;

    })();
  });

}).call(this);
