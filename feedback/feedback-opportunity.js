// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define([], function() {
    var FeedbackOpportunity;
    return FeedbackOpportunity = (function() {
      function FeedbackOpportunity(id) {
        this._feedbackOpportunityCompleted = __bind(this._feedbackOpportunityCompleted, this);
        this._feedbackOpportunityExpired = __bind(this._feedbackOpportunityExpired, this);
        this._feedbackOpportunityCancelled = __bind(this._feedbackOpportunityCancelled, this);
        this._feedbackOpportunityCreated = __bind(this._feedbackOpportunityCreated, this);
        this.completeFeedbackOpportunity = __bind(this.completeFeedbackOpportunity, this);
        this.expireFeedbackOpportunity = __bind(this.expireFeedbackOpportunity, this);
        this.cancelFeedbackOpportunity = __bind(this.cancelFeedbackOpportunity, this);
        this.createFeedbackOpportunity = __bind(this.createFeedbackOpportunity, this);
        this.id = id;
        this._destroy = false;
        this.description = '';
      }

      FeedbackOpportunity.prototype.createFeedbackOpportunity = function(command, callback) {
        if ((command.description == null) || command.description === '') {
          callback(new Error('Feedback description needed'));
          return;
        }
        this["new"]('feedbackOpportunityCreated', {
          id: this.id,
          by: command.by,
          "for": command["for"],
          description: command.description
        });
        return callback(null);
      };

      FeedbackOpportunity.prototype.cancelFeedbackOpportunity = function(command, callback) {
        this["new"]('feedbackOpportunityCancelled', {
          id: this.id,
          by: command.by,
          description: this.description
        });
        return callback(null);
      };

      FeedbackOpportunity.prototype.expireFeedbackOpportunity = function(command, callback) {
        this["new"]('feedbackOpportunityExpired', {
          id: this.id,
          description: this.description,
          by: command.by
        });
        return callback(null);
      };

      FeedbackOpportunity.prototype.completeFeedbackOpportunity = function(command, callback) {
        this["new"]('feedbackOpportunityCompleted', {
          id: this.id,
          description: this.description,
          by: command.by
        });
        return callback(null);
      };

      FeedbackOpportunity.prototype._feedbackOpportunityCreated = function(event) {
        return this.description = event.payload.description;
      };

      FeedbackOpportunity.prototype._feedbackOpportunityCancelled = function(event) {
        return this._destroy = true;
      };

      FeedbackOpportunity.prototype._feedbackOpportunityExpired = function(event) {
        return this._destroy = true;
      };

      FeedbackOpportunity.prototype._feedbackOpportunityCompleted = function(event) {
        return this._destroy = true;
      };

      return FeedbackOpportunity;

    })();
  });

}).call(this);
