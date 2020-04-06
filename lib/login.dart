import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

enum FacebookLoginStatus {
  unknown,
  success,
  cancelled,
  failed,
}

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
  const FacebookLoginResult({this.status});

  factory FacebookLoginResult.fromJson(Map<String, dynamic> json) =>
      _$FacebookLoginResultFromJson(json);
  Map<String, dynamic> toJson() => _$FacebookLoginResultToJson(this);

  @JsonKey()
  @FacebookLoginStatusConverter()
  final FacebookLoginStatus status;
}

class FacebookLoginStatusConverter
    implements JsonConverter<FacebookLoginStatus, String> {
  const FacebookLoginStatusConverter();

  static const _statusToString = <FacebookLoginStatus, String>{
    FacebookLoginStatus.success: '.success',
    FacebookLoginStatus.cancelled: '.cancelled',
    FacebookLoginStatus.failed: '.failed',
    FacebookLoginStatus.unknown: '.unknown',
  };

  @override
  FacebookLoginStatus fromJson(String json) {
    print(json);

    if (!_statusToString.containsValue(json)) {
      return FacebookLoginStatus.unknown;
    }

    return _statusToString.keys
        .firstWhere((status) => _statusToString[status] == json);
  }

  @override
  String toJson(FacebookLoginStatus status) {
    return _statusToString[status];
  }
}
