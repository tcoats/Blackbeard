// Generated by CoffeeScript 1.7.1
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['knockout', 'odo/auth', 'components/dialog'], function(ko, auth, Dialog) {
    var ForgotEmail;
    return ForgotEmail = (function() {
      function ForgotEmail() {
        this.forgot = __bind(this.forgot, this);
        this.back = __bind(this.back, this);
        this.close = __bind(this.close, this);
        this.activate = __bind(this.activate, this);
        this.message = ko.observable(null);
        this.email = ko.observable('').extend({
          required: true,
          email: true,
          validation: {
            async: true,
            validator: (function(_this) {
              return function(val, param, callback) {
                return auth.forgotCheckEmailAddress(val).then(function(result) {
                  return callback({
                    isValid: result.account,
                    message: result.message
                  });
                });
              };
            })(this)
          }
        });
        this.errors = ko.validation.group(this);
      }

      ForgotEmail.prototype.activate = function(options) {
        return this.wizard = options.wizard, this.dialog = options.dialog, options;
      };

      ForgotEmail.prototype.close = function() {
        return this.dialog.close();
      };

      ForgotEmail.prototype.back = function() {
        var options;
        this.dialog.close();
        options = {
          model: 'views/auth/signin'
        };
        return new Dialog(options).show();
      };

      ForgotEmail.prototype.forgot = function() {
        if (this.isValidating()) {
          return;
        }
        if (!this.isValid()) {
          this.dialog.shake();
          this.errors.showAllMessages();
          return;
        }
        this.message(null);
        return auth.forgotCheckEmailAddress(this.email()).then((function(_this) {
          return function(result) {
            return _this.wizard.forward({
              model: 'views/auth/forgot/result',
              activationData: {
                email: _this.email(),
                result: result
              }
            })();
          };
        })(this));
      };

      return ForgotEmail;

    })();
  });

}).call(this);
