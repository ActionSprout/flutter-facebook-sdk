import 'dart:async';

import 'package:flutter/services.dart';

import 'login.dart';

export 'login.dart';

class Facebook {
  const Facebook._();

  static const MethodChannel _channel =
      MethodChannel('actionsprout.com/facebook');

  static const Facebook instance = Facebook._();

  Future<FacebookLoginResult> logIn({List<String> permissions}) {
    return _channel
        .invokeMethod<Map>(
          'log_in',
          FacebookLoginRequest(permissions: permissions ?? []).toJson(),
        )
        .then(
          (result) => FacebookLoginResult.fromJson(
            result.cast<String, dynamic>(),
          ),
        );
  }

  Future<void> logOut() {
    return _channel.invokeMethod<Map>('log_out', {});
  }

  Future<FacebookAccessToken> getCurrentAccessToken() {
    return _channel.invokeMethod<Map>('get_current_access_token', {}).then(
        (result) => result == null
            ? null
            : FacebookAccessToken.fromJson(result.cast<String, dynamic>()));
  }

  Future<void> logAppEvent(
    String name, {
    Map<String, dynamic> parameters,
  }) {
    final args = <String, dynamic>{
      'name': name,
    };

    if (parameters != null) {
      args['parameters'] = parameters;
    }

    return _channel.invokeMethod('log_app_event', args);
  }
}
