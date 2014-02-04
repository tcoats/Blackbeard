// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  defineQ(['knockout', 'q', 'odo/inject', 'md5', 'odo/auth/current-user'], function(ko, Q, inject, md5, currentUser) {
    var DashboardSelf;
    return DashboardSelf = (function() {
      function DashboardSelf() {
        this.activate = __bind(this.activate, this);
      }

      DashboardSelf.prototype.inwidgets = inject.many('user/dashboard-self/in-widgets');

      DashboardSelf.prototype.outwidgets = inject.many('user/dashboard-self/out-widgets');

      DashboardSelf.prototype.title = ko.observable('');

      DashboardSelf.prototype.viewingUser = ko.observable(null);

      DashboardSelf.prototype.dashboardUser = ko.observable(null);

      DashboardSelf.prototype.user = ko.observable(null);

      DashboardSelf.prototype.activate = function(activationData) {
        var dashboardUser;
        dashboardUser = activationData.dashboardUser;
        this.viewingUser(currentUser);
        this.dashboardUser(dashboardUser);
        return this.user(currentUser);
      };

      return DashboardSelf;

    })();
  });

}).call(this);
