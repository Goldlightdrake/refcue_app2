import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // return Scaffold(
    //   backgroundColor: Colors.yellow[400],
    //   body: Center(
    //     child: FlareActor(
    //       loadingAnimation,
    //       animation: 'loading',
    //     ),
    //   ),
    // );
  }
}
