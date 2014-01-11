// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['knockout', 'odo/auth/local', 'components/dialog'], function(ko, localauth, Dialog) {
    var LocalSignin;
    return LocalSignin = (function() {
      function LocalSignin() {
        this.signin = __bind(this.signin, this);
        this.signup = __bind(this.signup, this);
        this.close = __bind(this.close, this);
        this.activate = __bind(this.activate, this);
        var _this = this;
        this.password = ko.observable('').extend({
          required: true
        });
        this.username = ko.observable('').extend({
          required: true,
          validation: {
            async: true,
            params: this.password,
            validator: function(username, password, callback) {
              if (password() === '') {
                callback({
                  isValid: true
                });
                return;
              }
              return localauth.testAuthentication(username, password()).then(function(result) {
                return callback({
                  isValid: result.isValid,
                  message: result.message
                });
              });
            }
          }
        });
        this.errors = ko.validation.group(this);
      }

      LocalSignin.prototype.activate = function(options) {
        return this.dialog = options.dialog, options;
      };

      LocalSignin.prototype.close = function() {
        return this.dialog.close();
      };

      LocalSignin.prototype.signup = function() {
        var options;
        this.dialog.close();
        options = {
          model: 'views/auth/localsignup'
        };
        return new Dialog(options).show();
      };

      LocalSignin.prototype.signin = function() {
        if (!this.isValid()) {
          console.log(this.username() + ' ' + this.password());
          this.dialog.shake();
          this.errors.showAllMessages();
          return false;
        }
        return true;
      };

      return LocalSignin;

    })();
  });

}).call(this);
