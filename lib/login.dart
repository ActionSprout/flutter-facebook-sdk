import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

enum FacebookLoginStatus {
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
  const FacebookLoginResult({
    this.appId,
    this.declinedPermissions,
    this.expiresAt,
    this.grantedPermissions,
    this.status,
    this.token,
    this.userId,
  });

  factory FacebookLoginResult.fromJson(Map<String, dynamic> json) {
    return _$FacebookLoginResultFromJson(json);
  }
  Map<String, dynamic> toJson() => _$FacebookLoginResultToJson(this);

  @JsonKey(name: 'app_id')
  final String appId;

  @JsonKey(name: 'declined')
  final List<String> declinedPermissions;

  @JsonKey(name: 'expires_at')
  @MillisecondsSinceEpochConverter()
  final DateTime expiresAt;

  @JsonKey(name: 'granted')
  final List<String> grantedPermissions;

  @JsonKey()
  @FacebookLoginStatusConverter()
  final FacebookLoginStatus status;

  @JsonKey()
  final String token;

  @JsonKey(name: 'user_id')
  final String userId;
}

class FacebookLoginStatusConverter
    implements JsonConverter<FacebookLoginStatus, String> {
  const FacebookLoginStatusConverter();

  static const _statusToString = <FacebookLoginStatus, String>{
    FacebookLoginStatus.success: '.success',
    FacebookLoginStatus.cancelled: '.cancelled',
    FacebookLoginStatus.failed: '.failed',
  };

  @override
  FacebookLoginStatus fromJson(String json) {
    if (!_statusToString.containsValue(json)) {
      return null;
    }

    return _statusToString.keys
        .firstWhere((status) => _statusToString[status] == json);
  }

  @override
  String toJson(FacebookLoginStatus status) {
    return _statusToString[status];
  }
}

class MillisecondsSinceEpochConverter implements JsonConverter<DateTime, int> {
  const MillisecondsSinceEpochConverter();

  @override
  DateTime fromJson(int ms) => DateTime.fromMillisecondsSinceEpoch(ms);

  @override
  int toJson(DateTime dateTime) => dateTime.millisecondsSinceEpoch;
}
