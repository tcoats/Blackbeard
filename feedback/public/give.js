// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['knockout', 'plugins/router', 'odo/inject'], function(ko, router, inject) {
    var FeedbackGive;
    router.map({
      route: 'givefeedback/:id',
      moduleId: 'views/feedback/give'
    });
    inject.bind('user/dashboard/widgets', 'views/feedback/givewidget');
    return FeedbackGive = (function() {
      FeedbackGive.prototype.title = ko.observable('');

      function FeedbackGive() {
        this.activate = __bind(this.activate, this);
        this.composeOptions = ko.observable(null);
        this.feedback = {
          id: 'testtesttest',
          type: 'classic4',
          options: {},
          description: 'Feedback for the last three months of Nigel\'s work at Company X',
          reviewee: {
            id: 'ffffff',
            name: 'Nigel Matterson',
            short: 'Nigel',
            gender: 'male',
            email: 'nigel.matterson@gmail.com'
          },
          reviewer: {
            id: 'ttttttt',
            name: 'Bob Fergerson',
            short: 'Bob',
            gender: 'male',
            email: 'bob.fergerson@gmail.com'
          },
          feedback: {}
        };
        this.title(this.feedback.description);
      }

      FeedbackGive.prototype.activate = function(id) {
        return this.composeOptions({
          model: 'components/wizard',
          activationData: {
            model: 'views/feedback/give/0-introduction',
            activationData: this.feedback
          }
        });
      };

      return FeedbackGive;

    })();
  });

}).call(this);
