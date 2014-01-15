// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['q', 'jquery', 'knockout', 'odo/auth'], function(Q, $, ko, auth) {
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
        var dfd,
          _this = this;
        this.wizard = options.wizard, this.dialog = options.dialog;
        dfd = Q.defer();
        auth.getUser().then(function(user) {
          _this.user(user);
          if (user.email != null) {
            _this.email(user.email);
          }
          return dfd.resolve(true);
        }).fail(function(err) {
          return dfd.resolve(true);
        });
        return dfd.promise;
      };

      ChangeEmail.prototype.back = function() {
        return this.wizard.back({
          model: 'views/user/profile/review'
        })();
      };

      ChangeEmail.prototype.changeEmail = function() {
        var _this = this;
        if (!this.isValid()) {
          this.dialog.shake();
          this.errors.showAllMessages();
          return;
        }
        if (this.user().email === this.email()) {
          this.back();
        }
        return auth.assignEmailAddressToUser(this.user().id, this.email()).then(function() {
          return _this.back();
        });
      };

      return ChangeEmail;

    })();
  });

}).call(this);
