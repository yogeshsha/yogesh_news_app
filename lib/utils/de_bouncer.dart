import 'dart:async';
import 'package:flutter/material.dart';

class DeBouncer {
  final Duration delay;
  Timer? _timer;

  DeBouncer({required this.delay});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}