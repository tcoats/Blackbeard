// Generated by CoffeeScript 1.6.3
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  define(['knockout'], function(ko) {
    var Skill;
    return Skill = (function() {
      function Skill() {
        this.showInfo = __bind(this.showInfo, this);
        this.forward = __bind(this.forward, this);
        this.back = __bind(this.back, this);
        this.activate = __bind(this.activate, this);
        this.shouldShow = __bind(this.shouldShow, this);
        this.feedback = ko.observable(null);
        this.skill = ko.observable(null);
        this.isShowingInfo = ko.observable(false);
        this.descriptions = [
          {
            text: '{name} does not contribute with {thirdpersonpossessive} skill or technical ability.',
            startAt: 0,
            endAt: 0
          }, {
            text: '{name} is learning skills and abilities and knows a few techniques.',
            startAfter: 0,
            endBefore: 0.1
          }, {
            text: '{name} is learning skills and abilities and knows the basics to get the job done.',
            startAt: 0.1,
            endBefore: 0.2
          }, {
            text: '{name} is beginning to get a grasp on the rules and principles.',
            startAt: 0.2,
            endBefore: 0.3
          }, {
            text: '{name} understands most of the rules and principles and is beginning to understand when certain rules aren\'t applicable.',
            startAt: 0.3,
            endBefore: 0.4
          }, {
            text: '{name} shows great skill and ability in most situations and understands that in some situations {thirdpersonpossessive} own judgement is needed.',
            startAt: 0.4,
            endBefore: 0.5
          }, {
            text: 'A crafter, {name} is well skilled and engages in new teritories with ease.',
            startAt: 0.5,
            endBefore: 0.6
          }, {
            text: '{name} has great depth of skill and ability and regularily pursues new ideas.',
            startAt: 0.6,
            endBefore: 0.7
          }, {
            text: '{name} follows the latest developments in {thirdpersonpossessive} field, incorporating these advancements into {thirdpersonpossessive} work.',
            startAt: 0.7,
            endBefore: 0.8
          }, {
            text: '{name} develops new ideas and pushes the boundaries of what is possible in {thirdpersonpossessive} field.',
            startAt: 0.8,
            endBefore: 0.9
          }, {
            text: '{name} is well respected in the community for {thirdpersonpossessive} ability and technical excellence.',
            startAt: 0.9,
            endBefore: 1
          }, {
            text: 'At the pinnacle of {thirdpersonpossessive} field, {name} has a PHD or equivalent and likely publishes articles.',
            startAt: 1,
            endAt: 1
          }
        ];
      }

      Skill.prototype.shouldShow = function(range, value) {
        if (((range.startAt != null) && value < range.startAt) || ((range.startAfter != null) && value <= range.startAfter) || ((range.endAt != null) && value > range.endAt) || ((range.endBefore != null) && value >= range.endBefore)) {
          return false;
        }
        return true;
      };

      Skill.prototype.activate = function(options) {
        var activationData, description, that, thirdpersonpossessive, thirdpersonpronoun, _i, _len, _ref, _results;
        this.wizard = options.wizard, activationData = options.activationData;
        this.feedback(activationData);
        if (this.feedback().feedback.skill != null) {
          this.skill(this.feedback().feedback.skill);
        } else {
          this.skill(0.05);
        }
        thirdpersonpossessive = 'its';
        thirdpersonpronoun = 'it';
        if (this.feedback().reviewee.gender === 'male') {
          thirdpersonpossessive = 'his';
          thirdpersonpronoun = 'he';
        }
        if (this.feedback().reviewee.gender === 'female') {
          thirdpersonpossessive = 'her';
          thirdpersonpronoun = 'she';
        }
        _ref = this.descriptions;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          description = _ref[_i];
          that = description;
          _results.push(that.text = that.text.replace(/\{name\}/g, this.feedback().reviewee.short).replace(/\{thirdpersonpossessive\}/g, thirdpersonpossessive).replace(/\{thirdpersonpronoun\}/g, thirdpersonpronoun));
        }
        return _results;
      };

      Skill.prototype.back = function() {
        var options;
        this.feedback().feedback.skill = this.skill();
        options = {
          model: 'views/feedback-give/0-introduction',
          activationData: this.feedback()
        };
        return this.wizard.back(options)();
      };

      Skill.prototype.forward = function() {
        var options;
        this.feedback().feedback.skill = this.skill();
        options = {
          model: 'views/feedback-give/2-output',
          activationData: this.feedback()
        };
        return this.wizard.forward(options)();
      };

      Skill.prototype.showInfo = function() {
        return this.isShowingInfo(true);
      };

      return Skill;

    })();
  });

}).call(this);
