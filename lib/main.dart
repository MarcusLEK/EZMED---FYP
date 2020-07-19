import 'package:ezmed/models/user.dart';
import 'package:ezmed/screens/wrapper.dart';
import 'package:ezmed/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        // this and all descendents below can listen to stream
        home: Wrapper(),
      ),
    );
  }
}

