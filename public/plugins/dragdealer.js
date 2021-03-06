// Generated by CoffeeScript 1.6.3
(function() {
  define([], function() {
    /*
    	Dragdealer JS v0.9.5
    	http://code.ovidiu.ch/dragdealer-js
    
    	Copyright (c) 2010, Ovidiu Chereches
    	MIT License
    	http://legal.ovidiu.ch/licenses/MIT
    */

    var Cursor, Position, Slider;
    Cursor = {
      x: 0,
      y: 0,
      init: function() {
        this.setEvent("mouse");
        return this.setEvent("touch");
      },
      setEvent: function(type) {
        var moveHandler;
        moveHandler = document["on" + type + "move"] || function() {};
        return document["on" + type + "move"] = function(e) {
          moveHandler(e);
          return Cursor.refresh(e);
        };
      },
      refresh: function(e) {
        if (!e) {
          e = window.event;
        }
        if (e.type === "mousemove") {
          return this.set(e);
        } else {
          if (e.touches) {
            return this.set(e.touches[0]);
          }
        }
      },
      set: function(e) {
        if (e.pageX || e.pageY) {
          this.x = e.pageX;
          return this.y = e.pageY;
        } else if (e.clientX || e.clientY) {
          this.x = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
          return this.y = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
        }
      }
    };
    Cursor.init();
    Position = {
      get: function(obj) {
        var curleft, curtop;
        curleft = curtop = 0;
        if (obj.offsetParent) {
          while (true) {
            curleft += obj.offsetLeft;
            curtop += obj.offsetTop;
            if (!(obj = obj.offsetParent)) {
              break;
            }
          }
        }
        return [curleft, curtop];
      }
    };
    Slider = function(wrapper, options) {
      var handle;
      if (typeof wrapper === "string") {
        wrapper = document.getElementById(wrapper);
      }
      if (!wrapper) {
        return;
      }
      handle = wrapper.getElementsByTagName("div")[0];
      if (!handle || handle.className.search(/(^|\s)handle(\s|$)/) === -1) {
        return;
      }
      this.init(wrapper, handle, options || {});
      this.setup();
    };
    Slider.prototype = {
      init: function(wrapper, handle, options) {
        this.wrapper = wrapper;
        this.handle = handle;
        this.options = options;
        this.disabled = this.getOption("disabled", false);
        this.horizontal = this.getOption("horizontal", true);
        this.vertical = this.getOption("vertical", false);
        this.slide = this.getOption("slide", true);
        this.steps = this.getOption("steps", 0);
        this.snap = this.getOption("snap", false);
        this.loose = this.getOption("loose", false);
        this.speed = this.getOption("speed", 10) / 100;
        this.xPrecision = this.getOption("xPrecision", 0);
        this.yPrecision = this.getOption("yPrecision", 0);
        this.callback = options.callback || null;
        this.animationCallback = options.animationCallback || null;
        this.bounds = {
          left: options.left || 0,
          right: -(options.right || 0),
          top: options.top || 0,
          bottom: -(options.bottom || 0),
          x0: 0,
          x1: 0,
          xRange: 0,
          y0: 0,
          y1: 0,
          yRange: 0
        };
        this.value = {
          prev: [-1, -1],
          current: [options.x || 0, options.y || 0],
          target: [options.x || 0, options.y || 0]
        };
        this.offset = {
          wrapper: [0, 0],
          mouse: [0, 0],
          prev: [-999999, -999999],
          current: [0, 0],
          target: [0, 0]
        };
        this.change = [0, 0];
        this.activity = false;
        this.dragging = false;
        return this.tapping = false;
      },
      getOption: function(name, defaultValue) {
        if (this.options[name] !== undefined) {
          return this.options[name];
        } else {
          return defaultValue;
        }
      },
      setup: function() {
        this.setWrapperOffset();
        this.setBoundsPadding();
        this.setBounds();
        this.setSteps();
        return this.addListeners();
      },
      setWrapperOffset: function() {
        return this.offset.wrapper = Position.get(this.wrapper);
      },
      setBoundsPadding: function() {
        if (!this.bounds.left && !this.bounds.right) {
          this.bounds.left = Position.get(this.handle)[0] - this.offset.wrapper[0];
          this.bounds.right = -this.bounds.left;
        }
        if (!this.bounds.top && !this.bounds.bottom) {
          this.bounds.top = Position.get(this.handle)[1] - this.offset.wrapper[1];
          return this.bounds.bottom = -this.bounds.top;
        }
      },
      setBounds: function() {
        this.bounds.x0 = this.bounds.left;
        this.bounds.x1 = this.wrapper.offsetWidth + this.bounds.right;
        this.bounds.xRange = (this.bounds.x1 - this.bounds.x0) - this.handle.offsetWidth;
        this.bounds.y0 = this.bounds.top;
        this.bounds.y1 = this.wrapper.offsetHeight + this.bounds.bottom;
        this.bounds.yRange = (this.bounds.y1 - this.bounds.y0) - this.handle.offsetHeight;
        this.bounds.xStep = 1 / (this.xPrecision || Math.max(this.wrapper.offsetWidth, this.handle.offsetWidth));
        return this.bounds.yStep = 1 / (this.yPrecision || Math.max(this.wrapper.offsetHeight, this.handle.offsetHeight));
      },
      setSteps: function() {
        var i, _results;
        if (this.steps > 1) {
          this.stepRatios = [];
          i = 0;
          _results = [];
          while (i <= this.steps - 1) {
            this.stepRatios[i] = i / (this.steps - 1);
            _results.push(i++);
          }
          return _results;
        }
      },
      addListeners: function() {
        var mouseUpHandler, resizeHandler, self, touchEndHandler;
        self = this;
        this.wrapper.onselectstart = function() {
          return false;
        };
        this.handle.onmousedown = this.handle.ontouchstart = function(e) {
          return self.handleDownHandler(e);
        };
        this.wrapper.onmousedown = this.wrapper.ontouchstart = function(e) {
          return self.wrapperDownHandler(e);
        };
        mouseUpHandler = document.onmouseup || function() {};
        document.onmouseup = function(e) {
          mouseUpHandler(e);
          return self.documentUpHandler(e);
        };
        touchEndHandler = document.ontouchend || function() {};
        document.ontouchend = function(e) {
          touchEndHandler(e);
          return self.documentUpHandler(e);
        };
        resizeHandler = window.onresize || function() {};
        window.onresize = function(e) {
          resizeHandler(e);
          return self.documentResizeHandler(e);
        };
        this.wrapper.onmousemove = function(e) {
          return self.activity = true;
        };
        this.wrapper.onclick = function(e) {
          return !self.activity;
        };
        this.interval = setInterval(function() {
          return self.animate();
        }, 25);
        return self.animate(false, true);
      },
      handleDownHandler: function(e) {
        this.activity = false;
        Cursor.refresh(e);
        this.preventDefaults(e, true);
        this.startDrag();
        return this.cancelEvent(e);
      },
      wrapperDownHandler: function(e) {
        Cursor.refresh(e);
        this.preventDefaults(e, true);
        return this.startTap();
      },
      documentUpHandler: function(e) {
        this.stopDrag();
        return this.stopTap();
      },
      documentResizeHandler: function(e) {
        this.setWrapperOffset();
        this.setBounds();
        return this.update();
      },
      enable: function() {
        this.disabled = false;
        return this.handle.className = this.handle.className.replace(/\s?disabled/g, "");
      },
      disable: function() {
        this.disabled = true;
        return this.handle.className += " disabled";
      },
      setStep: function(x, y, snap) {
        return this.setValue((this.steps && x > 1 ? (x - 1) / (this.steps - 1) : 0), (this.steps && y > 1 ? (y - 1) / (this.steps - 1) : 0), snap);
      },
      setValue: function(x, y, snap) {
        var self;
        self = this;
        this.setTargetValue([x, y || 0]);
        if (snap) {
          this.groupCopy(this.value.current, this.value.target);
          return this.update();
        }
      },
      startTap: function(target) {
        if (this.disabled) {
          return;
        }
        this.tapping = true;
        if (target === undefined) {
          target = [Cursor.x - this.offset.wrapper[0] - (this.handle.offsetWidth / 2), Cursor.y - this.offset.wrapper[1] - (this.handle.offsetHeight / 2)];
        }
        return this.setTargetOffset(target);
      },
      stopTap: function() {
        if (this.disabled || !this.tapping) {
          return;
        }
        this.tapping = false;
        this.setTargetValue(this.value.current);
        return this.result();
      },
      startDrag: function() {
        if (this.disabled) {
          return;
        }
        this.offset.mouse = [Cursor.x - Position.get(this.handle)[0], Cursor.y - Position.get(this.handle)[1]];
        return this.dragging = true;
      },
      stopDrag: function() {
        var ratioChange, target;
        if (this.disabled || !this.dragging) {
          return;
        }
        this.dragging = false;
        target = this.groupClone(this.value.current);
        if (this.slide) {
          ratioChange = this.change;
          target[0] += ratioChange[0] * 4;
          target[1] += ratioChange[1] * 4;
        }
        this.setTargetValue(target);
        return this.result();
      },
      feedback: function() {
        var value;
        value = this.value.current;
        if (this.snap && this.steps > 1) {
          value = this.getClosestSteps(value);
        }
        if (!this.groupCompare(value, this.value.prev)) {
          if (typeof this.animationCallback === "function") {
            this.animationCallback(value[0], value[1]);
          }
          return this.groupCopy(this.value.prev, value);
        }
      },
      result: function() {
        if (typeof this.callback === "function") {
          return this.callback(this.value.target[0], this.value.target[1]);
        }
      },
      animate: function(direct, first) {
        var offset, prevTarget;
        if (direct && !this.dragging) {
          return;
        }
        if (this.dragging) {
          prevTarget = this.groupClone(this.value.target);
          offset = [Cursor.x - this.offset.wrapper[0] - this.offset.mouse[0], Cursor.y - this.offset.wrapper[1] - this.offset.mouse[1]];
          this.setTargetOffset(offset, this.loose);
          this.change = [this.value.target[0] - prevTarget[0], this.value.target[1] - prevTarget[1]];
        }
        if (this.dragging || first) {
          this.groupCopy(this.value.current, this.value.target);
        }
        if (this.dragging || this.glide() || first) {
          this.update();
          return this.feedback();
        }
      },
      glide: function() {
        var diff;
        diff = [this.value.target[0] - this.value.current[0], this.value.target[1] - this.value.current[1]];
        if (!diff[0] && !diff[1]) {
          return false;
        }
        if (Math.abs(diff[0]) > this.bounds.xStep || Math.abs(diff[1]) > this.bounds.yStep) {
          this.value.current[0] += diff[0] * this.speed;
          this.value.current[1] += diff[1] * this.speed;
        } else {
          this.groupCopy(this.value.current, this.value.target);
        }
        return true;
      },
      update: function() {
        if (!this.snap) {
          this.offset.current = this.getOffsetsByRatios(this.value.current);
        } else {
          this.offset.current = this.getOffsetsByRatios(this.getClosestSteps(this.value.current));
        }
        return this.show();
      },
      show: function() {
        if (!this.groupCompare(this.offset.current, this.offset.prev)) {
          if (this.horizontal) {
            this.handle.style.left = String(this.offset.current[0]) + "px";
          }
          if (this.vertical) {
            this.handle.style.top = String(this.offset.current[1]) + "px";
          }
          return this.groupCopy(this.offset.prev, this.offset.current);
        }
      },
      setTargetValue: function(value, loose) {
        var target;
        target = (loose ? this.getLooseValue(value) : this.getProperValue(value));
        this.groupCopy(this.value.target, target);
        return this.offset.target = this.getOffsetsByRatios(target);
      },
      setTargetOffset: function(offset, loose) {
        var target, value;
        value = this.getRatiosByOffsets(offset);
        target = (loose ? this.getLooseValue(value) : this.getProperValue(value));
        this.groupCopy(this.value.target, target);
        return this.offset.target = this.getOffsetsByRatios(target);
      },
      getLooseValue: function(value) {
        var proper;
        proper = this.getProperValue(value);
        return [proper[0] + ((value[0] - proper[0]) / 4), proper[1] + ((value[1] - proper[1]) / 4)];
      },
      getProperValue: function(value) {
        var proper;
        proper = this.groupClone(value);
        proper[0] = Math.max(proper[0], 0);
        proper[1] = Math.max(proper[1], 0);
        proper[0] = Math.min(proper[0], 1);
        proper[1] = Math.min(proper[1], 1);
        if ((!this.dragging && !this.tapping) || this.snap ? this.steps > 1 : void 0) {
          proper = this.getClosestSteps(proper);
        }
        return proper;
      },
      getRatiosByOffsets: function(group) {
        return [this.getRatioByOffset(group[0], this.bounds.xRange, this.bounds.x0), this.getRatioByOffset(group[1], this.bounds.yRange, this.bounds.y0)];
      },
      getRatioByOffset: function(offset, range, padding) {
        if (range) {
          return (offset - padding) / range;
        } else {
          return 0;
        }
      },
      getOffsetsByRatios: function(group) {
        return [this.getOffsetByRatio(group[0], this.bounds.xRange, this.bounds.x0), this.getOffsetByRatio(group[1], this.bounds.yRange, this.bounds.y0)];
      },
      getOffsetByRatio: function(ratio, range, padding) {
        return Math.round(ratio * range) + padding;
      },
      getClosestSteps: function(group) {
        return [this.getClosestStep(group[0]), this.getClosestStep(group[1])];
      },
      getClosestStep: function(value) {
        var i, k, min;
        k = 0;
        min = 1;
        i = 0;
        while (i <= this.steps - 1) {
          if (Math.abs(this.stepRatios[i] - value) < min) {
            min = Math.abs(this.stepRatios[i] - value);
            k = i;
          }
          i++;
        }
        return this.stepRatios[k];
      },
      groupCompare: function(a, b) {
        return a[0] === b[0] && a[1] === b[1];
      },
      groupCopy: function(a, b) {
        a[0] = b[0];
        return a[1] = b[1];
      },
      groupClone: function(a) {
        return [a[0], a[1]];
      },
      preventDefaults: function(e, selection) {
        if (!e) {
          e = window.event;
        }
        if (e.preventDefault) {
          e.preventDefault();
        }
        e.preventDefault();
        if (selection && document.selection) {
          return document.selection.empty();
        }
      },
      cancelEvent: function(e) {
        if (!e) {
          e = window.event;
        }
        if (e.stopPropagation) {
          e.stopPropagation();
        }
        return e.cancelBubble = true;
      }
    };
    return Slider;
  });

}).call(this);
