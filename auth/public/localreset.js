// Generated by CoffeeScript 1.7.1
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['knockout'], function(ko) {
    var LocalReset;
    return LocalReset = (function() {
      LocalReset.prototype.title = "Reset your password";

      function LocalReset() {
        this.activate = __bind(this.activate, this);
        this.composeOptions = ko.observable(null);
      }

      LocalReset.prototype.activate = function(token) {
        return this.composeOptions({
          model: 'components/wizard',
          activationData: {
            dialog: this.dialog,
            model: 'views/auth/localreset/password',
            activationData: {
              token: token
            }
          }
        });
      };

      return LocalReset;

    })();
  });

}).call(this);
