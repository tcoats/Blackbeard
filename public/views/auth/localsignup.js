// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['knockout', 'odo/auth/local'], function(ko, localauth) {
    var LocalSignup;
    return LocalSignup = (function() {
      function LocalSignup() {
        this.signup = __bind(this.signup, this);
        this.close = __bind(this.close, this);
        this.activate = __bind(this.activate, this);
        var _this = this;
        this.displayName = ko.observable('').extend({
          required: true
        });
        this.username = ko.observable('').extend({
          required: true,
          validation: {
            async: true,
            validator: function(val, params, callback) {
              return localauth.getUsernameAvailability(val).then(function(availibility) {
                return callback({
                  isValid: availibility.isAvailable,
                  message: availibility.message
                });
              });
            }
          }
        });
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

      LocalSignup.prototype.activate = function(options) {
        return this.dialog = options.dialog, options;
      };

      LocalSignup.prototype.close = function() {
        return this.dialog.close();
      };

      LocalSignup.prototype.signup = function() {
        if (!this.isValid()) {
          this.dialog.shake();
          this.errors.showAllMessages();
          return false;
        }
        return true;
      };

      return LocalSignup;

    })();
  });

}).call(this);
