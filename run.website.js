// Generated by CoffeeScript 1.6.3
(function() {
  var requirejs;

  requirejs = require('requirejs');

  requirejs.config({
    nodeRequire: require,
    paths: {
      odo: './bower_components/odo',
      'blackbeard': './'
    }
  });

  requirejs(['odo/express'], function(express) {
    var app;
    process.env.PORT = 80;
    return app = express([requirejs('./odo/plugins/peek'), requirejs('./odo/plugins/bower'), requirejs('./odo/plugins/durandal'), requirejs('./odo/plugins/handlebars'), requirejs('./odo/plugins/twitterauth'), requirejs('./odo/plugins/sendcommand'), requirejs('./blackbeard/plugins/public')]);
  });

}).call(this);