// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacebookLoginRequest _$FacebookLoginRequestFromJson(Map<String, dynamic> json) {
  return FacebookLoginRequest(
    permissions:
        (json['permissions'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$FacebookLoginRequestToJson(
        FacebookLoginRequest instance) =>
    <String, dynamic>{
      'permissions': instance.permissions,
    };

FacebookLoginResult _$FacebookLoginResultFromJson(Map<String, dynamic> json) {
  return FacebookLoginResult(
    appId: json['app_id'] as String,
    declinedPermissions:
        (json['declined'] as List)?.map((e) => e as String)?.toList(),
    expiresAt: const MillisecondsSinceEpochConverter()
        .fromJson(json['expires_at'] as int),
    grantedPermissions:
        (json['granted'] as List)?.map((e) => e as String)?.toList(),
    status:
        const FacebookLoginStatusConverter().fromJson(json['status'] as String),
    token: json['token'] as String,
    userId: json['user_id'] as String,
  );
}

Map<String, dynamic> _$FacebookLoginResultToJson(
        FacebookLoginResult instance) =>
    <String, dynamic>{
      'app_id': instance.appId,
      'declined': instance.declinedPermissions,
      'expires_at':
          const MillisecondsSinceEpochConverter().toJson(instance.expiresAt),
      'granted': instance.grantedPermissions,
      'status': const FacebookLoginStatusConverter().toJson(instance.status),
      'token': instance.token,
      'user_id': instance.userId,
    };
