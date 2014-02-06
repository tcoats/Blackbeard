// Generated by CoffeeScript 1.7.1
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['knockout'], function(ko) {
    var ForgotAuth;
    return ForgotAuth = (function() {
      function ForgotAuth() {
        this.activate = __bind(this.activate, this);
        this.composeOptions = ko.observable(null);
      }

      ForgotAuth.prototype.activate = function(options) {
        this.dialog = options.dialog;
        return this.composeOptions({
          model: 'components/wizard',
          activationData: {
            dialog: this.dialog,
            model: 'views/auth/forgot/email'
          }
        });
      };

      return ForgotAuth;

    })();
  });

}).call(this);
