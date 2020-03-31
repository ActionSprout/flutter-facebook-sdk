import 'dart:async';

import 'package:flutter/services.dart';

class Facebook {
  static const MethodChannel _channel =
      MethodChannel('actionsprout.com/facebook');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
