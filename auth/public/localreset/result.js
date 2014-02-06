// Generated by CoffeeScript 1.7.1
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['knockout', 'components/dialog'], function(ko, Dialog) {
    var LocalResetResult;
    return LocalResetResult = (function() {
      function LocalResetResult() {
        this.signinlocal = __bind(this.signinlocal, this);
        this.activate = __bind(this.activate, this);
        this.username = ko.observable(null);
      }

      LocalResetResult.prototype.activate = function(options) {
        var activationData;
        activationData = options.activationData;
        return this.username(activationData.username);
      };

      LocalResetResult.prototype.signinlocal = function() {
        var options;
        options = {
          model: 'views/auth/localsignin',
          activationData: {
            username: this.username()
          }
        };
        return new Dialog(options).show();
      };

      return LocalResetResult;

    })();
  });

}).call(this);
