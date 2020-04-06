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
    status:
        const FacebookLoginStatusConverter().fromJson(json['status'] as String),
  );
}

Map<String, dynamic> _$FacebookLoginResultToJson(
        FacebookLoginResult instance) =>
    <String, dynamic>{
      'status': const FacebookLoginStatusConverter().toJson(instance.status),
    };
