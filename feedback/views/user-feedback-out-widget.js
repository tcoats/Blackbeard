// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  defineQ(['knockout', 'components/dialog', 'odo/auth/current-user'], function(ko, Dialog, user) {
    var UserFeedbackOutWidget;
    return UserFeedbackOutWidget = (function() {
      function UserFeedbackOutWidget() {
        this.suggestFeedbackOpportunity = __bind(this.suggestFeedbackOpportunity, this);
        this.parseFeedback = __bind(this.parseFeedback, this);
        this.activate = __bind(this.activate, this);
      }

      UserFeedbackOutWidget.prototype.viewingUser = ko.observable(null);

      UserFeedbackOutWidget.prototype.dashboardUser = ko.observable(null);

      UserFeedbackOutWidget.prototype.feedback = ko.observable([]);

      UserFeedbackOutWidget.prototype.activate = function(activationData) {
        var dashboardUser,
          _this = this;
        dashboardUser = activationData.dashboardUser;
        this.viewingUser(user);
        this.dashboardUser(dashboardUser);
        return $.get("/user-feedback-out-widget/" + dashboardUser.id).then(function(feedback) {
          return _this.parseFeedback(feedback);
        });
      };

      UserFeedbackOutWidget.prototype.parseFeedback = function(feedback) {
        var f, id, result;
        result = [];
        for (id in feedback) {
          f = feedback[id];
          result.push(f);
        }
        return this.feedback(result);
      };

      UserFeedbackOutWidget.prototype.suggestFeedbackOpportunity = function() {};

      return UserFeedbackOutWidget;

    })();
  });

}).call(this);
