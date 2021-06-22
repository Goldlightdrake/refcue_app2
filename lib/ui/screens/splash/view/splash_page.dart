import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Image(
              width: kSpacingUnit.w * 20,
              image: AssetImage(
                ThemeProvider.of(context)!.brightness == Brightness.dark
                    ? logoDarkPath
                    : logoPath,
              )),
        ),
        SizedBox(height: kSpacingUnit.w * 3),
        LinearProgressIndicator(),
      ],
    ));
  }
}
