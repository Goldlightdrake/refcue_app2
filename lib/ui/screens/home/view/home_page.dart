import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_login/firebase_login/authentication/authentication.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_firebase_login/shared/functions.dart';
import 'package:flutter_firebase_login/ui/screens/account/account.dart';
import 'package:flutter_firebase_login/ui/screens/home/widgets/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);

    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: kSpacingUnit.w * 15,
              padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Image.asset(
                      ThemeProvider.of(context).brightness == Brightness.dark
                          ? logoDarkPath
                          : logoPath,
                      width: kSpacingUnit.w * 12),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) => ProfileScreen())),
                    child: Hero(
                      tag: 'avatar',
                      child: CircleAvatar(
                        radius: kSpacingUnit.w * 3,
                        backgroundImage: user.photo == null
                            ? AssetImage(basicAvatarImage)
                            : NetworkImage(user.photo),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: kSpacingUnit.w * 2),
                alignment: Alignment.centerLeft,
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      takeDate(),
                      style: TextStyle(
                        fontSize: kSpacingUnit.w * 2,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          user.name == '' || user.name == null
                              ? 'Witaj, Panie Bezimienny'
                              : 'Witaj, ' + user.name,
                          style: TextStyle(
                            fontSize: kSpacingUnit.w * 2.2,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: kSpacingUnit.w * 1),
                        RotationTransition(
                          turns: AlwaysStoppedAnimation(10 / 360),
                          child: SvgPicture.asset(
                            helloIconPath,
                            width: kSpacingUnit.w * 2.5,
                          ),
                        ),
                      ],
                    )
                  ],
                )),
            SizedBox(height: kSpacingUnit.w * 2),
            Container(
              height: kSpacingUnit.w * 22,
              width: double.infinity,
              child: ListView(
                padding: EdgeInsets.only(bottom: 20.0, left: 8.0),
                scrollDirection: Axis.horizontal,
                children: [
                  ExamCard(
                      examPath: examGreenPath,
                      time: 5,
                      quantity: 5,
                      color1: 0xff81BF5B, //darker color
                      color2: 0xffA4F56D), //lighter color
                  ExamCard(
                      examPath: examYellowPath,
                      time: 10,
                      quantity: 10,
                      color1: 0xFFEBDE34,
                      color2: 0xFFEBDA00),
                  ExamCard(
                      examPath: examBluePath,
                      time: 30,
                      quantity: 30,
                      color1: 0xff4cb3c7,
                      color2: 0xff28d5f7),
                ],
              ),
            ),
            SizedBox(height: 50.0),
            Container(
                height: 40.0,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                alignment: Alignment.topLeft,
                child: Text('Wybrane dla Ciebie',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600))),
            Container(
              height: 180.0,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ForUCard(image: pilatesPath, color: Color(0xfffff98c)),
                  ForUCard(image: fitnessPath, color: Color(0xffcaffa6)),
                  ForUCard(image: healthyPath, color: Color(0xff90f0e9)),
                ],
              ),
            ),
            SizedBox(
              height: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
