// Generated by CoffeeScript 1.7.1
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  defineQ(['knockout'], function(ko) {
    var Introduction;
    return Introduction = (function() {
      function Introduction() {
        this.forward = __bind(this.forward, this);
        this.close = __bind(this.close, this);
        this.activate = __bind(this.activate, this);
        this.feedback = ko.observable(null);
      }

      Introduction.prototype.activate = function(options) {
        var activationData;
        this.wizard = options.wizard, this.dialog = options.dialog, activationData = options.activationData;
        return this.feedback(activationData);
      };

      Introduction.prototype.close = function() {
        return this.dialog.close();
      };

      Introduction.prototype.forward = function() {
        return this.wizard.forward({
          model: 'views/feedback/give/1-skill',
          activationData: this.feedback()
        })();
      };

      return Introduction;

    })();
  });

}).call(this);
