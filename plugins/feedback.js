// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['module', 'redis'], function(module, redis) {
    var Feedback, db;
    db = redis.createClient();
    return Feedback = (function() {
      function Feedback() {
        this.init = __bind(this.init, this);
        this.receive = __bind(this.receive, this);
      }

      Feedback.prototype.receive = function(hub) {
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

      Feedback.prototype.configure = function(app) {
        app.route('/views/feedback', app.modulepath(module.uri) + '/feedback-public');
        return app.durandal('views/feedback/give');
      };

      Feedback.prototype.init = function(app) {
        var _this = this;
        return app.get('/feedbackforreviewer/:id', function(req, res) {
          return _this.get(req.params.id, function(err, feedback) {
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
