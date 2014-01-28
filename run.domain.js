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

  requirejs(['odo/plugins', 'odo/user/plugin', 'local/feedback/plugin'], function() {
    var Plugins, plugins;
    Plugins = arguments[0], plugins = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return new Plugins(plugins).domain();
  });

}).call(this);
