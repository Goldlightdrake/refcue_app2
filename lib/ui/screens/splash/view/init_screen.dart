import 'dart:async';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/firebase_login/app.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_firebase_login/shared/responsive.dart';

class InitScreenPage extends StatefulWidget {
  const InitScreenPage({
    Key key,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  @override
  _InitScreenPageState createState() => _InitScreenPageState();
}

class _InitScreenPageState extends State<InitScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => App(
                    authenticationRepository: AuthenticationRepository()))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Image(
            image: AssetImage(
          ThemeProvider.of(context).brightness == Brightness.dark
              ? logoDarkPath
              : logoPath,
        )),
        width: Responsive.width(50, context));
  }
}
