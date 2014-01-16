// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['q', 'jquery', 'knockout', 'odo/auth'], function(Q, $, ko, auth) {
    var ChangeUsername;
    return ChangeUsername = (function() {
      ChangeUsername.prototype.user = ko.observable(null);

      function ChangeUsername() {
        this.changeUsername = __bind(this.changeUsername, this);
        this.back = __bind(this.back, this);
        this.activate = __bind(this.activate, this);
        var _this = this;
        this.username = ko.observable('').extend({
          required: true,
          validation: {
            async: true,
            validator: function(val, param, callback) {
              if ((_this.user().username != null) && _this.user().username === val) {
                callback({
                  isValid: true,
                  message: 'Same username as existing'
                });
                return;
              }
              return auth.getUsernameAvailability(val).then(function(availibility) {
                return callback({
                  isValid: availibility.isAvailable,
                  message: availibility.message
                });
              });
            }
          }
        });
        this.errors = ko.validation.group(this);
      }

      ChangeUsername.prototype.activate = function(options) {
        var dfd,
          _this = this;
        this.wizard = options.wizard, this.dialog = options.dialog;
        dfd = Q.defer();
        auth.getUser().then(function(user) {
          _this.user(user);
          if (user.username != null) {
            _this.username(user.username);
          }
          return dfd.resolve(true);
        }).fail(function(err) {
          return dfd.resolve(true);
        });
        return dfd.promise;
      };

      ChangeUsername.prototype.back = function() {
        return this.wizard.back({
          model: 'views/user/profile/review'
        })();
      };

      ChangeUsername.prototype.changeUsername = function() {
        var _this = this;
        if (!this.isValid()) {
          this.dialog.shake();
          this.errors.showAllMessages();
          return;
        }
        if (this.user().username === this.username()) {
          this.back();
        }
        return auth.assignUsernameToUser(this.user().id, this.username()).then(function() {
          return _this.back();
        });
      };

      return ChangeUsername;

    })();
  });

}).call(this);
