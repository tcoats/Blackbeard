// Generated by CoffeeScript 1.6.3
(function() {
  var requirejs,
    __slice = [].slice;

  requirejs = require('requirejs');

  requirejs.config({
    nodeRequire: require,
    paths: {
      odo: './bower_components/odo',
      local: './'
    }
  });

  requirejs(['odo/express', 'odo/plugins/peek', 'odo/plugins/bower', 'odo/plugins/durandal', 'odo/plugins/handlebars', 'odo/plugins/auth', 'odo/plugins/auth/twitter', 'odo/plugins/auth/facebook', 'odo/plugins/auth/google', 'odo/plugins/auth/local', 'odo/plugins/sendcommand', 'odo/plugins/public', 'local/plugins/welcome', 'local/plugins/auth', 'local/plugins/email', 'local/plugins/user', 'local/plugins/feedback'], function() {
    var app, express, plugins;
    express = arguments[0], plugins = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    process.env.PORT = 4834;
    return app = express(plugins);
  });

}).call(this);
