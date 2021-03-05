import 'dart:async';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:refcue_app/firebase_login/app.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);

    return Scaffold(
        backgroundColor: ThemeProvider.of(context).primaryColor,
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Image(
                width: kSpacingUnit.w * 20,
                image: AssetImage(
                  ThemeProvider.of(context).brightness == Brightness.dark
                      ? logoDarkPath
                      : logoPath,
                )),
          ),
        ));
  }
}
