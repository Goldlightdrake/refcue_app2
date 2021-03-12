import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:refcue_app/firebase_login/authentication/authentication.dart';
import 'package:refcue_app/shared/functions.dart';
import 'package:refcue_app/ui/screens/account/account.dart';
import 'package:refcue_app/ui/screens/home/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);

    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    auth.User authUser = auth.FirebaseAuth.instance.currentUser;

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
                      width: kSpacingUnit.w * 10),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        PageRouteBuilder(
                            reverseTransitionDuration:
                                Duration(milliseconds: 500),
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) => ProfileScreen())),
                    child: Hero(
                      tag: 'avatar',
                      child: Builder(builder: (context) {
                        authUser.reload();

                        if (user.photo != null) {
                          return CachedNetworkImage(
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            imageUrl: user.photo,
                            imageBuilder: (context, imageProvider) {
                              return CircleAvatar(
                                radius: kSpacingUnit.w * 3.5,
                                backgroundImage: imageProvider,
                              );
                            },
                          );
                        }
                        return CircleAvatar(
                          radius: kSpacingUnit.w * 3.5,
                          backgroundImage: AssetImage(basicAvatarImage),
                        );
                      }),
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
                              ? 'Witamy w RefCue'
                              : 'Witaj, ' + user.name.split(' ')[0],
                          style: TextStyle(
                            wordSpacing: 4,
                            fontSize: kSpacingUnit.w * 2.5,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: kSpacingUnit.w * 1),
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: 30,
                          child: FlareActor(
                            handShakeAnimation,
                            animation: 'shake',
                            alignment: Alignment.topLeft,
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
            SizedBox(height: kSpacingUnit.w * 4),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                alignment: Alignment.topLeft,
                child: Text('Zobacz więcej funkcji',
                    style: TextStyle(
                        fontSize: kSpacingUnit.w * 2,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600))),
            SizedBox(
              height: kSpacingUnit.w * 4,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ForUCard(
                    image: choosePath,
                    color: kAccentColor,
                    path: 'customtest',
                  ),
                  ForUCard(image: fitnessPath, color: Color(0xffcaffa6)),
                  ForUCard(image: healthyPath, color: Color(0xff90f0e9)),
                ],
              ),
            ),
            SizedBox(
              height: kSpacingUnit.w * 4,
            ),
          ],
        ),
      ),
    );
  }
}
