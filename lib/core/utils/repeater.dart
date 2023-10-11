import 'dart:async';

import 'package:flutter/material.dart';

class Repeater {
  Repeater(this.interval);

  final Duration interval;

  VoidCallback? _action;
  Timer? _timer;

  void call(VoidCallback action, {bool immediateCall = false}) {
    // Let the latest action override whatever was there before
    _action = action;
    // If no timer is running, we want to start one
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }

    //  If immediateCall is true, we handle the action now
    if (immediateCall) {
      _callAction();
    }
    // Start a timer that will temporarily throttle subsequent calls, and eventually make a call to whatever _action is (if anything)
    _timer = Timer.periodic(
      interval,
      (timer) {
        _callAction();
      },
    );
  }

  void _callAction() {
    _action?.call(); // If we have an action queued up, complete it.
  }

  void reset() {
    _action = null;
    _timer?.cancel();
    _timer = null;
  }

  void pause() {
    _timer?.cancel();
    _timer = null;
  }

  void restart() {
    if (_timer == null && _action != null) {
      call(_action!);
    }
  }
}
