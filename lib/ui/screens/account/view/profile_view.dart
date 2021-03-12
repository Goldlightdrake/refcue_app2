import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:refcue_app/data/shared_preference/user_preference.dart';
import 'package:refcue_app/firebase_login/authentication/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:refcue_app/ui/screens/account/view/widgets/profile_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'widgets/changing_profile_img.dart';

class ProfileScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ProfileScreen());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: kSpacingUnit.w * 10,
            width: kSpacingUnit.w * 10,
            margin: EdgeInsets.only(top: kSpacingUnit.w * 3),
            child: Stack(
              children: <Widget>[
                Hero(
                    tag: 'avatar',
                    child: user.photo != null
                        ? CachedNetworkImage(
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            imageUrl: user.photo,
                            imageBuilder: (context, imageProvider) {
                              return CircleAvatar(
                                radius: kSpacingUnit.w * 5,
                                backgroundImage: imageProvider,
                              );
                            },
                          )
                        : CircleAvatar(
                            radius: kSpacingUnit.w * 5,
                            backgroundImage: AssetImage(basicAvatarImage),
                          )),
                DelayedDisplay(
                  delay: Duration(milliseconds: 500),
                  slidingBeginOffset: Offset(0.35, 0.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () async {
                        Navigator.of(context)
                            .push<void>(ChangingProfileImage.route());
                      },
                      child: Container(
                        height: kSpacingUnit.w * 3,
                        width: kSpacingUnit.w * 3,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          heightFactor: kSpacingUnit.w * 1.5,
                          widthFactor: kSpacingUnit.w * 1.5,
                          child: Icon(
                            LineAwesomeIcons.pen,
                            color: kDarkPrimaryColor,
                            size: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Text(
            user.name == '' || user.name == null ? 'Pan BezImienny' : user.name,
            style: kTitleTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 0.5),
          Text(
            user.email,
            style: kCaptionTextStyle,
          ),
          SizedBox(height: kSpacingUnit.w * 2),
          Container(
            height: kSpacingUnit.w * 5,
            width: kSpacingUnit.w * 22,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
              color: Theme.of(context).accentColor,
            ),
            child: Center(
              child: Text(
                'Zyskaj więcej z PRO',
                style: kButtonTextStyle,
              ),
            ),
          ),
        ],
      ),
    );

    var themeSwitcher = ThemeSwitcher(
      builder: (context) {
        return AnimatedCrossFade(
          duration: Duration(milliseconds: 200),
          crossFadeState:
              ThemeProvider.of(context).brightness == Brightness.dark
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
          firstChild: GestureDetector(
            onTap: () {
              ThemeSwitcher.of(context).changeTheme(theme: kLightTheme);
              UserSharedPreference.setThemeDataPrefs(true);
              UserSharedPreference.getThemeDataPrefs()
                  .then((value) => print(value));
            },
            child: Icon(
              LineAwesomeIcons.sun,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
          secondChild: GestureDetector(
            onTap: () {
              ThemeSwitcher.of(context).changeTheme(theme: kDarkTheme);
              UserSharedPreference.setThemeDataPrefs(false);
            },
            child: Icon(
              LineAwesomeIcons.moon,
              size: ScreenUtil().setSp(kSpacingUnit.w * 3),
            ),
          ),
        );
      },
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: kSpacingUnit.w * 3),
        IconButton(
          onPressed: () => Navigator.of(context).pop<void>(),
          icon: Icon(LineAwesomeIcons.arrow_left),
          iconSize: ScreenUtil().setSp(kSpacingUnit.w * 3),
        ),
        profileInfo,
        themeSwitcher,
        SizedBox(width: kSpacingUnit.w * 3),
      ],
    );

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                SizedBox(height: kSpacingUnit.w * 5),
                header,
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      ProfileListItem(
                          icon: LineAwesomeIcons.user_shield,
                          text: 'Dane konta',
                          where: 'profileDataView'),
                      ProfileListItem(
                        icon: LineAwesomeIcons.history,
                        text: 'Statystyki',
                        where: 'profileStatsView',
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.question_circle,
                        text: 'Pomoc',
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.cog,
                        text: 'Ustawienia',
                        where: 'settingsScreen',
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.user_plus,
                        text: 'Zaproś znajomych!',
                      ),
                      ProfileListItem(
                        icon: LineAwesomeIcons.alternate_sign_out,
                        text: 'Wyloguj się',
                        hasNavigation: false,
                        logOut: true,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
