// Generated by CoffeeScript 1.7.1
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['knockout', 'q', 'odo/auth/current-user', 'plugins/router', 'odo/inject'], function(ko, Q, currentUser, router, inject) {
    var ViewFeedbackOpportunity;
    return ViewFeedbackOpportunity = (function() {
      function ViewFeedbackOpportunity() {
        this.complete = __bind(this.complete, this);
        this.expire = __bind(this.expire, this);
        this.cancel = __bind(this.cancel, this);
        this.getFeedback = __bind(this.getFeedback, this);
        this.activate = __bind(this.activate, this);
        this.canActivate = __bind(this.canActivate, this);
        this.title = ko.observable('');
        this.feedback = ko.observable(null);
        this.user = ko.observable(null);
      }

      ViewFeedbackOpportunity.prototype.canActivate = function(id) {
        var dfd;
        dfd = Q.defer();
        this.getFeedback(id).then((function(_this) {
          return function(feedback) {
            return dfd.resolve(true);
          };
        })(this)).fail((function(_this) {
          return function() {
            return dfd.resolve(false);
          };
        })(this));
        return dfd.promise;
      };

      ViewFeedbackOpportunity.prototype.activate = function(id) {
        return this.getFeedback(id).then((function(_this) {
          return function(feedback) {
            _this.user(currentUser);
            return _this.feedback(feedback);
          };
        })(this));
      };

      ViewFeedbackOpportunity.prototype.getFeedback = function(id) {
        return $.get("/view-feedback-opportunity/" + id);
      };

      ViewFeedbackOpportunity.prototype.cancel = function() {
        return Q($.post('/sendcommand/cancelFeedbackOpportunity', this.feedback())).then((function(_this) {
          return function() {
            return router.navigate('#user/' + _this.user().username);
          };
        })(this));
      };

      ViewFeedbackOpportunity.prototype.expire = function() {
        return Q($.post('/sendcommand/expireFeedbackOpportunity', this.feedback())).then((function(_this) {
          return function() {
            return router.navigate('#user/' + _this.user().username);
          };
        })(this));
      };

      ViewFeedbackOpportunity.prototype.complete = function() {
        return Q($.post('/sendcommand/completeFeedbackOpportunity', this.feedback())).then((function(_this) {
          return function() {
            return router.navigate('#user/' + _this.user().username);
          };
        })(this));
      };

      return ViewFeedbackOpportunity;

    })();
  });

}).call(this);
