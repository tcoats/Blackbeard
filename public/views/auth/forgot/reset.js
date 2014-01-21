// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['knockout', 'q', 'odo/auth'], function(ko, Q, auth) {
    var ForgotAuthReset;
    return ForgotAuthReset = (function() {
      function ForgotAuthReset() {
        this.close = __bind(this.close, this);
        this.activate = __bind(this.activate, this);
      }

      ForgotAuthReset.prototype.email = ko.observable(null);

      ForgotAuthReset.prototype.activate = function(options) {
        var activationData, dfd,
          _this = this;
        this.wizard = options.wizard, this.dialog = options.dialog, activationData = options.activationData;
        this.email(activationData.email);
        dfd = Q.defer();
        auth.createPasswordResetToken(this.email()).then(function() {
          return dfd.resolve(true);
        });
        return dfd.promise;
      };

      ForgotAuthReset.prototype.close = function() {
        return this.dialog.close();
      };

      return ForgotAuthReset;

    })();
  });

}).call(this);