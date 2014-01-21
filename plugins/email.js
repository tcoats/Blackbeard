// Generated by CoffeeScript 1.6.3
(function() {
  define(['odo/mandrill', 'odo/projections/userprofile'], function(Mandrill, UserProfile) {
    var Email;
    return Email = (function() {
      function Email() {
        var _this = this;
        this.receive = {
          userHasPasswordResetToken: function(event, cb) {
            console.log('Email userHasPasswordResetToken');
            return new UserProfile().get(event.payload.id, function(err, user) {
              var options;
              if (err != null) {
                console.log(err);
                cb();
                return;
              }
              options = {
                message: {
                  text: "Use this link to reset your password. If you don't want to reset your password ignore this email. This link expires after a day.\n\nhttp://blackbeard.thomascoats.com/#auth/local/reset/" + event.payload.token,
                  subject: 'Blackbeard reset password',
                  from_email: 'blackbeard@voodoolabs.net',
                  from_name: 'Blackbeard',
                  to: [
                    {
                      email: user.email,
                      name: user.displayName,
                      type: 'to'
                    }
                  ]
                }
              };
              return new Mandrill().send(options).then(function() {
                console.log('Email away!');
                return cb();
              }).fail(function(err) {
                console.log(err);
                return cb();
              });
            });
          },
          userHasVerifyEmailAddressToken: function(event, cb) {
            console.log('Email userHasVerifyEmailAddressToken');
            return new UserProfile().get(event.payload.id, function(err, user) {
              var options;
              if (err != null) {
                console.log(err);
                cb();
                return;
              }
              options = {
                message: {
                  text: "Use this link to verify your email address. If you don't want this email address enabled for your Blackbeard account please ignore this email. This link expires after a day.\n\nhttp://blackbeard.thomascoats.com/#user/verifyemail/" + event.payload.email + "/" + event.payload.token,
                  subject: 'Blackbeard verify email address',
                  from_email: 'blackbeard@voodoolabs.net',
                  from_name: 'Blackbeard',
                  to: [
                    {
                      email: event.payload.email,
                      name: user.displayName,
                      type: 'to'
                    }
                  ]
                }
              };
              return new Mandrill().send(options).then(function() {
                console.log('Email away!');
                return cb();
              }).fail(function(err) {
                console.log(err);
                return cb();
              });
            });
          }
        };
      }

      return Email;

    })();
  });

}).call(this);