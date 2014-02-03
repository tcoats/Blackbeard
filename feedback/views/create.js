// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  defineQ(['knockout', 'plugins/router', 'odo/inject'], function(ko, router, inject) {
    var FeedbackCreate;
    return FeedbackCreate = (function() {
      function FeedbackCreate() {
        this.activate = __bind(this.activate, this);
        this.composeOptions = ko.observable(null);
      }

      FeedbackCreate.prototype.activate = function(options) {
        this.dialog = options.dialog;
        return this.composeOptions({
          model: 'components/wizard',
          activationData: {
            dialog: this.dialog,
            model: 'views/feedback/create/0-description'
          }
        });
      };

      return FeedbackCreate;

    })();
  });

}).call(this);
