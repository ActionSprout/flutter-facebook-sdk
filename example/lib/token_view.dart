import 'package:facebook/facebook.dart';
import 'package:flutter/material.dart';

class TokenView extends StatelessWidget {
  const TokenView({Key key, this.token}) : super(key: key);

  final FacebookAccessToken token;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildRow('App ID', '${token.appId}'),
        _buildRow('User ID', '${token.userId}'),
        _buildRow('Expires', '${token.expiresAt}'),
        _buildRow('Token', '<${token.token.length} bytes>'),
        ...token.declinedPermissions
            .map((permission) => _buildRow('Declined', '$permission')),
        ...token.grantedPermissions
            .map((permission) => _buildRow('Granted', '$permission')),
      ],
    );
  }

  Widget _buildRow(String label, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Text('$label: $text'),
    );
  }
}
