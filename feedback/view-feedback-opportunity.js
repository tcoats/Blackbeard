// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['redis', 'odo/messaging/hub', 'odo/express/app'], function(redis, hub, app) {
    var ViewFeedbackOpportunity, db;
    db = redis.createClient();
    return ViewFeedbackOpportunity = (function() {
      function ViewFeedbackOpportunity() {
        this.remove = __bind(this.remove, this);
        this.projection = __bind(this.projection, this);
        this.web = __bind(this.web, this);
      }

      ViewFeedbackOpportunity.prototype.web = function() {
        var _this = this;
        return app.get('/view-feedback-opportunity/:id', function(req, res) {
          return db.hget('blackbeard:viewfeedbackopportunity', req.params.id, function(err, feedback) {
            if (err != null) {
              console.log(err);
              res.send(500, 'Woops');
              return;
            }
            if (feedback == null) {
              res.send(404, 'Not here');
              return;
            }
            feedback = JSON.parse(feedback);
            if (req.user.id !== feedback["for"]) {
              res.send(403, 'Authentication required');
              return;
            }
            return res.send(feedback);
          });
        });
      };

      ViewFeedbackOpportunity.prototype.projection = function() {
        var _this = this;
        hub.receive('feedbackOpportunityCreated', function(event, cb) {
          console.log('ViewFeedbackOpportunity feedbackOpportunityCreated');
          return db.hset('blackbeard:viewfeedbackopportunity', event.payload.id, JSON.stringify(event.payload), function() {
            return cb();
          });
        });
        hub.receive('feedbackOpportunityCancelled', this.remove);
        hub.receive('feedbackOpportunityCompleted', this.remove);
        return hub.receive('feedbackOpportunityExpired', this.remove);
      };

      ViewFeedbackOpportunity.prototype.remove = function(event, cb) {
        return db.hdel('blackbeard:viewfeedbackopportunity', event.payload.id, function() {
          return cb();
        });
      };

      return ViewFeedbackOpportunity;

    })();
  });

}).call(this);
