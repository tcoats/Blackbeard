// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['q', 'knockout', 'odo/auth'], function(Q, ko, auth) {
    var LocalSignup;
    return LocalSignup = (function() {
      LocalSignup.prototype.user = ko.observable(null);

      function LocalSignup() {
        this.signup = __bind(this.signup, this);
        this.close = __bind(this.close, this);
        this.activate = __bind(this.activate, this);
        this.setup = __bind(this.setup, this);
        this.displayName = ko.observable('');
        this.username = ko.observable('');
        this.password = ko.observable('');
        this.confirmPassword = ko.observable('');
      }

      LocalSignup.prototype.setup = function() {
        var _this = this;
        if (this.user() != null) {
          this.displayName = ko.observable(this.user().displayName);
          this.username = ko.observable(this.user().username);
        }
        this.displayName.extend({
          required: true
        });
        this.username.extend({
          required: true,
          validation: {
            async: true,
            validator: function(val, param, callback) {
              return auth.getUsernameAvailability(val).then(function(availibility) {
                return callback({
                  isValid: availibility.isAvailable,
                  message: availibility.message
                });
              });
            }
          }
        });
        this.password.extend({
          required: true,
          pattern: {
            params: '^.{8,}$',
            message: 'Eight or more letters for security'
          }
        });
        this.confirmPassword.extend({
          equal: {
            params: this.password,
            message: 'Type the same password here'
          }
        });
        return this.errors = ko.validation.group(this);
      };

      LocalSignup.prototype.activate = function(options) {
        var dfd,
          _this = this;
        this.dialog = options.dialog;
        dfd = Q.defer();
        auth.getUser().then(function(user) {
          _this.user(user);
          _this.setup();
          return dfd.resolve(true);
        }).fail(function(err) {
          _this.setup();
          return dfd.resolve(true);
        });
        return dfd.promise;
      };

      LocalSignup.prototype.close = function() {
        return this.dialog.close();
      };

      LocalSignup.prototype.signup = function() {
        if (this.isValidating()) {
          return false;
        }
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
