// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['q', 'knockout', 'odo/auth', 'components/dialog'], function(Q, ko, auth, Dialog) {
    var LocalResetPassword;
    return LocalResetPassword = (function() {
      LocalResetPassword.prototype.isTokenValid = ko.observable(false);

      LocalResetPassword.prototype.result = ko.observable(null);

      LocalResetPassword.prototype.token = ko.observable(null);

      function LocalResetPassword() {
        this.forgot = __bind(this.forgot, this);
        this.changePassword = __bind(this.changePassword, this);
        this.activate = __bind(this.activate, this);
        this.shake = __bind(this.shake, this);
        this.password = ko.observable('').extend({
          required: true,
          pattern: {
            params: '^.{8,}$',
            message: 'Eight or more letters for security'
          }
        });
        this.confirmPassword = ko.observable('').extend({
          equal: {
            params: this.password,
            message: 'Type the same password here'
          }
        });
        this.errors = ko.validation.group(this);
      }

      LocalResetPassword.prototype.shouldShake = ko.observable(false);

      LocalResetPassword.prototype.shake = function() {
        var _this = this;
        this.shouldShake(true);
        return setTimeout(function() {
          return _this.shouldShake(false);
        }, 1000);
      };

      LocalResetPassword.prototype.activate = function(options) {
        var activationData, dfd,
          _this = this;
        this.wizard = options.wizard, activationData = options.activationData;
        this.token(activationData.token);
        dfd = Q.defer();
        auth.checkResetToken(this.token()).then(function(result) {
          _this.isTokenValid(result.isValid);
          _this.result(result);
          return dfd.resolve(true);
        }).fail(function() {
          return dfd.resolve(false);
        });
        return dfd.promise;
      };

      LocalResetPassword.prototype.changePassword = function() {
        var _this = this;
        if (!this.isValid()) {
          this.shake();
          this.errors.showAllMessages();
          return;
        }
        return auth.resetPasswordWithToken(this.token(), this.password()).then(function() {
          return _this.wizard.forward({
            model: 'views/auth/localreset/result',
            activationData: _this.result()
          })();
        });
      };

      LocalResetPassword.prototype.forgot = function() {
        return new Dialog({
          model: 'views/auth/forgot'
        }).show();
      };

      return LocalResetPassword;

    })();
  });

}).call(this);
