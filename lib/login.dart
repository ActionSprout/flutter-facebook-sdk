import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class FacebookLoginRequest {
  const FacebookLoginRequest({
    this.permissions = _defaultPermissions,
  });

  factory FacebookLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$FacebookLoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FacebookLoginRequestToJson(this);

  static const _defaultPermissions = <String>[];

  @JsonKey()
  final List<String> permissions;
}

@JsonSerializable()
class FacebookLoginResult {
  const FacebookLoginResult({this.type});

  factory FacebookLoginResult.fromJson(Map<String, dynamic> json) =>
      _$FacebookLoginResultFromJson(json);
  Map<String, dynamic> toJson() => _$FacebookLoginResultToJson(this);

  @JsonKey()
  final String type;
}
