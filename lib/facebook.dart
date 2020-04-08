import 'dart:async';

import 'package:flutter/services.dart';

import 'login.dart';

export 'login.dart';

class Facebook {
  static const MethodChannel _channel =
      MethodChannel('actionsprout.com/facebook');

  static Future<FacebookLoginResult> logIn() {
    return _channel
        .invokeMethod<Map>('log_in', const FacebookLoginRequest().toJson())
        .then((result) => FacebookLoginResult.fromJson(
              result.cast<String, dynamic>(),
            ));
  }

  static Future<void> logOut() {
    return _channel.invokeMethod<Map>('log_out', {});
  }

  static Future<FacebookAccessToken> getCurrentAccessToken() {
    return _channel.invokeMethod<Map>('get_access_token', {}).then((result) =>
        result == null
            ? null
            : FacebookAccessToken.fromJson(result.cast<String, dynamic>()));
  }
}
