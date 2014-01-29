// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['redis', 'odo/messaging/hub', 'odo/express/app'], function(redis, hub, app) {
    var UserFeedbackWidget, db;
    db = redis.createClient();
    return UserFeedbackWidget = (function() {
      function UserFeedbackWidget() {
        this.addOrRemoveValues = __bind(this.addOrRemoveValues, this);
        this.remove = __bind(this.remove, this);
        this.projection = __bind(this.projection, this);
        this.web = __bind(this.web, this);
      }

      UserFeedbackWidget.prototype.web = function() {
        var _this = this;
        return app.get('/user-feedback-in-widget/:id', function(req, res) {
          if (req.user.id !== req.params.id) {
            res.send(403, 'Authentication required');
            return;
          }
          return db.hget('blackbeard:userfeedbackinwidget', req.params.id, function(err, data) {
            if (err != null) {
              console.log(err);
              cb(err);
              return;
            }
            data = JSON.parse(data);
            if (data == null) {
              data = {};
            }
            return res.send(data);
          });
        });
      };

      UserFeedbackWidget.prototype.projection = function() {
        var _this = this;
        hub.receive('feedbackOpportunityCreated', function(event, cb) {
          return _this.addOrRemoveValues(event, cb, function(data) {
            data[event.payload.id] = event.payload;
            return data;
          });
        });
        hub.receive('feedbackOpportunityCancelled', this.remove);
        hub.receive('feedbackOpportunityCompleted', this.remove);
        return hub.receive('feedbackOpportunityExpired', this.remove);
      };

      UserFeedbackWidget.prototype.remove = function(event, cb) {
        var _this = this;
        return this.addOrRemoveValues(event, cb, function(data) {
          delete data[event.payload.id];
          return data;
        });
      };

      UserFeedbackWidget.prototype.addOrRemoveValues = function(event, cb, callback) {
        var _this = this;
        return db.hget('blackbeard:userfeedbackinwidget', event.payload["for"], function(err, data) {
          if (err != null) {
            console.log(err);
            cb(err);
            return;
          }
          data = JSON.parse(data);
          if (data == null) {
            data = {};
          }
          data = callback(data);
          return db.hset('blackbeard:userfeedbackinwidget', event.payload["for"], JSON.stringify(data), function() {
            return cb();
          });
        });
      };

      return UserFeedbackWidget;

    })();
  });

}).call(this);
