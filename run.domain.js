// Generated by CoffeeScript 1.6.3
(function() {
  var requirejs,
    __slice = [].slice;

  requirejs = require('requirejs');

  requirejs.config({
    nodeRequire: require,
    paths: {
      odo: './node_modules/odo',
      local: './'
    }
  });

  requirejs(['odo/infra/hub', 'local/domain/feedbackcommands', 'odo/user/usercommands'], function() {
    var handler, handlers, hub, _i, _len, _results;
    hub = arguments[0], handlers = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    handlers = handlers.map(function(handler) {
      if (typeof handler === 'function') {
        return new handler;
      }
      return handler;
    });
    _results = [];
    for (_i = 0, _len = handlers.length; _i < _len; _i++) {
      handler = handlers[_i];
      if (handler.handle != null) {
        _results.push(handler.handle(hub));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  });

}).call(this);
