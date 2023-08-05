import 'dart:io';

import 'package:flutter/services.dart';

void vibrateError() {
  HapticFeedback.vibrate();

  sleep(const Duration(milliseconds: 300));
  
  HapticFeedback.vibrate();
}

void vibrateDelete() {
  HapticFeedback.heavyImpact();
}
