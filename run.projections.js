// Generated by CoffeeScript 1.6.3
(function() {
  var requirejs,
    __slice = [].slice;

  requirejs = require('requirejs');

  requirejs.config({
    nodeRequire: require,
    paths: {
      odo: './bower_components/odo',
      blackbeard: './'
    }
  });

  requirejs(['odo/hub', 'blackbeard/projections/feedbackforreviewer', 'odo/projections/userprofile', 'odo/plugins/auth/twitter', 'odo/plugins/auth/facebook', 'odo/plugins/auth/google', 'odo/plugins/auth/local'], function() {
    var bindEvents, hub, listener, listeners, _i, _len, _results;
    hub = arguments[0], listeners = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    listeners = listeners.map(function(listener) {
      if (typeof listener === 'function') {
        return new listener;
      }
      return listener;
    });
    bindEvents = function(listener) {
      var method, name, _results;
      _results = [];
      for (name in listener) {
        method = listener[name];
        _results.push(hub.receive(name, method));
      }
      return _results;
    };
    _results = [];
    for (_i = 0, _len = listeners.length; _i < _len; _i++) {
      listener = listeners[_i];
      _results.push(bindEvents(listener.receive));
    }
    return _results;
  });

}).call(this);
