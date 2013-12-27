// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define([], function() {
    var Feedback;
    return Feedback = (function() {
      function Feedback(id) {
        this._feedbackCompleted = __bind(this._feedbackCompleted, this);
        this._feedbackCancelled = __bind(this._feedbackCancelled, this);
        this._feedbackBegun = __bind(this._feedbackBegun, this);
        this.completeFeedback = __bind(this.completeFeedback, this);
        this.cancelFeedback = __bind(this.cancelFeedback, this);
        this.beginFeedback = __bind(this.beginFeedback, this);
        this.id = id;
        this._destroy = false;
        this.type = '';
        this.options = {};
        this.description = '';
        this.reviewer = {
          id: null,
          name: '',
          email: ''
        };
        this.feedback = {};
      }

      Feedback.prototype.beginFeedback = function(command, callback) {
        if ((command.description == null) || command.description === '') {
          callback(new Error('Feedback description needed'));
          return;
        }
        this["new"]('feedbackBegun', {
          id: this.id,
          type: command.type,
          options: command.options,
          description: command.description,
          reviewer: command.reviewer
        });
        return callback(null);
      };

      Feedback.prototype.cancelFeedback = function(command, callback) {
        this["new"]('feedbackCancelled', {
          id: this.id,
          type: this.type,
          options: this.options,
          description: this.description,
          reviewer: this.reviewer,
          feedback: this.feedback,
          by: command.by
        });
        return callback(null);
      };

      Feedback.prototype.completeFeedback = function(command, callback) {
        if (command.feedback == null) {
          callback(new Error('Feedback results needed'));
          return;
        }
        return this["new"]('feedbackCompleted', {
          id: this.id,
          type: this.type,
          options: this.options,
          description: this.description,
          reviewer: this.reviewer,
          feedback: this.feedback,
          by: command.by
        });
      };

      Feedback.prototype._feedbackBegun = function(event) {
        this.type = event.payload.type;
        this.options = event.payload.options;
        this.description = event.payload.description;
        return this.reviewer = event.payload.reviewer;
      };

      Feedback.prototype._feedbackCancelled = function(event) {
        return this._destroy = true;
      };

      Feedback.prototype._feedbackCompleted = function(event) {
        return this._destroy = true;
      };

      return Feedback;

    })();
  });

}).call(this);
