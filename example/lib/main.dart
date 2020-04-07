import 'package:facebook/facebook.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FacebookLoginResult _loginResult;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Facebook example'),
        ),
        body: Column(
          children: [
            if (_loginResult != null) ...[
              Text('Result: ${_loginResult.status}'),
            ],
            RaisedButton(
              onPressed: () async {
                final result = await Facebook.logIn();
                setState(() {
                  _loginResult = result;
                });
              },
              child: const Text('Login with Facebook'),
            ),
          ],
        ),
      ),
    );
  }
}
