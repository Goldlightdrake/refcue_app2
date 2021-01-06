import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const logoPath = 'assets/images/logo.png';
const logoDarkPath = 'assets/images/logo_dark.png';
const refereePath = 'assets/images/referee.svg';
const settingsIconPath = 'assets/icons/settings_icon.svg';
const avatarIconPath = 'assets/icons/avatar_icon.svg';
const clockIconPath = 'assets/icons/clock_icon.svg';
const elipsPath = 'assets/images/elips.svg';
const examGreenPath = 'assets/images/exam_green.svg';
const examYellowPath = 'assets/images/exam_yellow.svg';
const examBluePath = 'assets/images/exam_blue.svg';
const pilatesPath = 'assets/images/pilates.svg';
const fitnessPath = 'assets/images/fitness.svg';
const healthyPath = 'assets/images/healthy.svg';
const loadingAnimation = 'assets/flare/loading_screen.flr';
const basicAvatarImage = 'assets/images/basic_avatar.png';
const helloIconPath = 'assets/icons/hello_icon.svg';
const handShakeAnimation = 'assets/flare/hand_shake.flr';

//Article's icons
const article1IconPath = 'assets/icons/article_icons/article1.svg';
const article2IconPath = 'assets/icons/article_icons/article2.svg';
const article3IconPath = 'assets/icons/article_icons/article3.svg';
const article4IconPath = 'assets/icons/article_icons/article4.svg';
const article5IconPath = 'assets/icons/article_icons/article5.svg';
const article6IconPath = 'assets/icons/article_icons/article6.svg';
const article7IconPath = 'assets/icons/article_icons/article7.svg';
const article8IconPath = 'assets/icons/article_icons/article8.svg';
const article9IconPath = 'assets/icons/article_icons/article9.svg';
const article10IconPath = 'assets/icons/article_icons/article10.svg';
const article11IconPath = 'assets/icons/article_icons/article11.svg';
const article12IconPath = 'assets/icons/article_icons/article12.svg';
final textStyleClassic = TextStyle(
    color: Colors.black,
    fontSize: 40.0,
    decoration: TextDecoration.none,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold);

//theme

const kSpacingUnit = 10;

const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);

final kTitleTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.3),
  fontWeight: FontWeight.w100,
);

final kButtonTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
  fontWeight: FontWeight.bold,
  color: kDarkPrimaryColor,
);

final kDarkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: 'SFProText',
    primaryColor: kDarkPrimaryColor,
    canvasColor: kDarkPrimaryColor,
    shadowColor: Colors.black,
    backgroundColor: kDarkSecondaryColor,
    accentColor: kAccentColor,
    iconTheme: ThemeData.dark().iconTheme.copyWith(
          color: kLightSecondaryColor,
        ),
    textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'SFProText',
          bodyColor: kLightSecondaryColor,
          displayColor: kLightSecondaryColor,
        ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ));

final kLightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'SFProText',
    primaryColor: kLightPrimaryColor,
    canvasColor: kLightPrimaryColor,
    backgroundColor: kLightSecondaryColor,
    shadowColor: Colors.grey[350],
    accentColor: kAccentColor,
    iconTheme: ThemeData.light().iconTheme.copyWith(
          color: kDarkSecondaryColor,
        ),
    textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'SFProText',
          bodyColor: kDarkSecondaryColor,
          displayColor: kDarkSecondaryColor,
        ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: kAccentColor)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ));
