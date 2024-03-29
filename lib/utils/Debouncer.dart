// https://stackoverflow.com/a/55119208
import 'dart:async';
import 'package:flutter/foundation.dart';

class Debouncer {
  
  Debouncer({this.milliseconds});

  final int milliseconds;
  VoidCallback action;
  Timer _timer;


  void run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
