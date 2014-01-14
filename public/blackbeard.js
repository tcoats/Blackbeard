// Generated by CoffeeScript 1.6.3
(function() {
  requirejs.config({
    paths: {
      text: 'requirejs-text/text',
      durandal: 'durandal/js',
      plugins: 'durandal/js/plugins',
      knockout: 'knockout.js/knockout',
      'ko.validation': 'lib/knockout.validation.min',
      bootstrap: 'bootstrap/dist/js/bootstrap.min',
      jquery: 'jquery/jquery.min',
      underscore: 'underscore/underscore-min',
      mousetrap: 'mousetrap/mousetrap.min',
      uuid: 'node-uuid/uuid',
      marked: 'marked/lib/marked',
      transitions: 'odo/durandal/transitions',
      components: 'odo/durandal/components',
      odo: 'odo',
      q: 'q/q',
      slider: 'bindings/slider'
    },
    shim: {
      bootstrap: {
        deps: ['jquery'],
        exports: 'jQuery'
      },
      underscore: {
        exports: '_'
      },
      mousetrap: {
        exports: 'Mousetrap'
      },
      marked: {
        exports: 'marked'
      },
      'ko.validation': {
        deps: ['knockout']
      }
    },
    urlArgs: 'v=' + (new Date()).getTime()
  });

  define(['durandal/system', 'durandal/app', 'durandal/viewLocator', 'odo/durandal/bindings', 'bindings/blackbeardbindings'], function(system, app, locator, bindings, blackbeardbindings) {
    system.debug(true);
    app.title = 'Blackbeard';
    app.configurePlugins({
      router: true,
      dialog: true,
      widget: true
    });
    bindings.init(requirejs, {
      mousetrap: true,
      q: true,
      bootstrap: true,
      marked: true,
      dialog: true,
      validation: true
    });
    blackbeardbindings.init(requirejs, {
      slider: true
    });
    return app.start().then(function() {
      locator.useConvention('views');
      return app.setRoot('views/shell');
    });
  });

}).call(this);
