import 'package:facebook/facebook.dart';
import 'package:flutter/material.dart';

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
        body: Center(
          child: RaisedButton(
            onPressed: () async {
              try {
                final result = await Facebook.logIn();
                print('Login completed with: ${result.toJson()}');
              } on Object catch (error) {
                print('Login failed with: $error');
              }
            },
            child: const Text('Login with Facebook'),
          ),
        ),
      ),
    );
  }
}
