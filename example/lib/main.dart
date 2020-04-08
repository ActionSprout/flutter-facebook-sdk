import 'package:facebook/facebook.dart';
import 'package:flutter/material.dart';

import 'token_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Facebook example'),
        ),
        body: Builder(
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () => _loginWithFacebook(context),
                  child: const Text('Login with Facebook'),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () => _viewCurrentToken(context),
                  child: const Text('View current access token'),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                width: double.infinity,
                child: RaisedButton(
                  onPressed: () => _logout(context),
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loginWithFacebook(BuildContext context) async {
    final loginResult = await Facebook.logIn();

    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: EdgeInsets.zero,
        title: Text(
          describeStatus(loginResult.status),
          textAlign: TextAlign.center,
        ),
        titlePadding: const EdgeInsets.fromLTRB(0, 12, 0, 18),
        children: [
          if (loginResult.accessToken != null)
            TokenView(
              token: loginResult.accessToken,
            ),
          FlatButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  String describeStatus(FacebookLoginStatus status) {
    switch (status) {
      case FacebookLoginStatus.success:
        return 'Success';
      case FacebookLoginStatus.cancelled:
        return 'Cancelled';
      case FacebookLoginStatus.failed:
    }

    return 'Failed';
  }

  Future<void> _logout(BuildContext context) async {
    await Facebook.logOut();

    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: EdgeInsets.zero,
        title: const Text(
          'Success',
          textAlign: TextAlign.center,
        ),
        titlePadding: const EdgeInsets.fromLTRB(0, 12, 0, 18),
        children: [
          FlatButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _viewCurrentToken(BuildContext context) async {
    final token = await Facebook.getCurrentAccessToken();

    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: const EdgeInsets.only(top: 12),
        children: [
          if (token != null)
            TokenView(
              token: token,
            )
          else
            const Text(
              'No current token.',
              textAlign: TextAlign.center,
            ),
          FlatButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
