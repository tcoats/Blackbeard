// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  defineQ(['q', 'jquery', 'knockout', 'odo/auth', 'odo/auth/current-user'], function(Q, $, ko, auth, user) {
    var ChangeEmail;
    return ChangeEmail = (function() {
      ChangeEmail.prototype.user = ko.observable(null);

      function ChangeEmail() {
        this.changeEmail = __bind(this.changeEmail, this);
        this.back = __bind(this.back, this);
        this.activate = __bind(this.activate, this);
        this.email = ko.observable('').extend({
          required: true,
          email: true
        });
        this.errors = ko.validation.group(this);
      }

      ChangeEmail.prototype.activate = function(options) {
        this.wizard = options.wizard, this.dialog = options.dialog;
        this.user(user);
        if (user.email != null) {
          return this.email(user.email);
        }
      };

      ChangeEmail.prototype.back = function() {
        return this.wizard.back({
          model: 'views/user/profile/review'
        })();
      };

      ChangeEmail.prototype.changeEmail = function() {
        var _this = this;
        if (this.isValidating()) {
          return;
        }
        if (!this.isValid()) {
          this.dialog.shake();
          this.errors.showAllMessages();
          return;
        }
        if (this.user().email === this.email()) {
          this.back();
        }
        return auth.createVerifyEmailAddressToken(this.email()).then(function() {
          return _this.wizard.forward({
            model: 'views/user/profile/emailresult',
            activationData: {
              email: _this.email()
            }
          })();
        });
      };

      return ChangeEmail;

    })();
  });

}).call(this);
