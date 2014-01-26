// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['module', 'odo/messaging/hub', 'odo/express/configure', 'odo/express/app', 'odo/durandal/plugin', 'redis'], function(module, hub, configure, app, durandal, redis) {
    var Feedback, db;
    db = redis.createClient();
    return Feedback = (function() {
      function Feedback() {
        this.projection = __bind(this.projection, this);
        this.feedbackforreviewer = __bind(this.feedbackforreviewer, this);
        this.web = __bind(this.web, this);
      }

      Feedback.prototype.web = function() {
        configure.route('/views/feedback', configure.modulepath(module.uri) + '/public');
        durandal.register('views/feedback/give');
        return app.get('/feedbackforreviewer/:id', this.feedbackforreviewer);
      };

      Feedback.prototype.feedbackforreviewer = function(req, res) {
        var _this = this;
        return this.get(req.params.id, function(err, feedback) {
          if (err != null) {
            res.send(500, err);
            return;
          }
          if (feedback == null) {
            res.send(404, err);
            return;
          }
          res.send(feedback);
        });
      };

      Feedback.prototype.projection = function() {
        var _this = this;
        hub.receive('feedbackBegun', function(event, cb) {
          var feedback;
          feedback = {
            id: event.payload.id,
            type: event.payload.type,
            options: event.payload.options,
            description: event.payload.name,
            reviewer: event.payload.reviewer
          };
          return db.set("feedbackforreviewer:" + feedback.id, JSON.stringify(feedback, function() {
            return cb();
          }));
        });
        hub.receive('feedbackCancelled', function(event, cb) {
          var id;
          id = event.payload.id;
          return db.del("feedbackforreviewer:" + id, function() {
            return cb();
          });
        });
        return hub.receive('feedbackCompleted', function(event, cb) {
          var id;
          id = event.payload.id;
          return db.del("feedbackforreviewer:" + id, function() {
            return cb();
          });
        });
      };

      Feedback.prototype.get = function(id, callback) {
        var _this = this;
        return db.get("feedbackforreviewer:" + id, function(err, data) {
          if (err != null) {
            callback(err);
            return;
          }
          data = JSON.parse(data);
          return callback(null, data);
        });
      };

      return Feedback;

    })();
  });

}).call(this);
