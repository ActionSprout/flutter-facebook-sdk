import 'dart:async';

import 'package:flutter/services.dart';

import 'login.dart';

class Facebook {
  static const MethodChannel _channel =
      MethodChannel('actionsprout.com/facebook');

  static Future<FacebookLoginResult> logIn() {
    return _channel
        .invokeMethod<Map>('login', const FacebookLoginRequest().toJson())
        .then((result) => FacebookLoginResult.fromJson(
              result.cast<String, dynamic>(),
            ));
  }
}

// FBSDKLog: fbauth2 is missing from your Info.plist under
// LSApplicationQueriesSchemes and is required for iOS 9.0
// =>
// PlatformException(3, Unknown error building URL., null)
