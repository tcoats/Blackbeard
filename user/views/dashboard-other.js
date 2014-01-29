// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['knockout', 'odo/inject'], function(ko, inject) {
    var DashboardSelf;
    return DashboardSelf = (function() {
      function DashboardSelf() {
        this.activate = __bind(this.activate, this);
      }

      DashboardSelf.prototype.widgets = inject.many('user/dashboard-other/widgets');

      DashboardSelf.prototype.title = ko.observable('');

      DashboardSelf.prototype.viewingUser = ko.observable(null);

      DashboardSelf.prototype.dashboardUser = ko.observable(null);

      DashboardSelf.prototype.activate = function(activationData) {
        var dashboardUser, viewingUser;
        viewingUser = activationData.viewingUser, dashboardUser = activationData.dashboardUser;
        this.viewingUser(viewingUser);
        return this.dashboardUser(dashboardUser);
      };

      return DashboardSelf;

    })();
  });

}).call(this);