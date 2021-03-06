// Generated by CoffeeScript 1.7.1
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['knockout', 'odo/auth', 'components/dialog'], function(ko, auth, Dialog) {
    var ForgotAuthResult;
    return ForgotAuthResult = (function() {
      function ForgotAuthResult() {
        this.reset = __bind(this.reset, this);
        this.signinlocal = __bind(this.signinlocal, this);
        this.back = __bind(this.back, this);
        this.close = __bind(this.close, this);
        this.activate = __bind(this.activate, this);
        this.email = ko.observable(null);
        this.result = ko.observable(null);
      }

      ForgotAuthResult.prototype.activate = function(options) {
        var activationData;
        this.wizard = options.wizard, this.dialog = options.dialog, activationData = options.activationData;
        this.email(activationData.email);
        return this.result(activationData.result);
      };

      ForgotAuthResult.prototype.close = function() {
        return this.dialog.close();
      };

      ForgotAuthResult.prototype.back = function() {
        return this.wizard.back({
          model: 'views/auth/forgot/email'
        })();
      };

      ForgotAuthResult.prototype.signinlocal = function() {
        var options;
        this.close();
        options = {
          model: 'views/auth/localsignin'
        };
        return new Dialog(options).show();
      };

      ForgotAuthResult.prototype.reset = function() {
        return this.wizard.forward({
          model: 'views/auth/forgot/reset',
          activationData: {
            email: this.email()
          }
        })();
      };

      return ForgotAuthResult;

    })();
  });

}).call(this);
