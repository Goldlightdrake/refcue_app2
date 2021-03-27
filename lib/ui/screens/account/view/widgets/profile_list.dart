import 'package:flutter/material.dart';
import 'package:refcue_app/firebase_login/authentication/authentication.dart';
import 'package:refcue_app/ui/screens/account/view/menu/profile_data_view.dart';
import 'package:refcue_app/ui/screens/account/view/menu/profile_stats_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refcue_app/ui/screens/account/view/menu/settings_screen.dart';

class ProfileListItem extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final bool hasNavigation;
  final bool logOut;
  final String? where;

  Route<dynamic>? navigationNames(String? where) {
    switch (where) {
      case 'profileDataView':
        return ProfileDataView.route();
      case 'profileStatsView':
        return ProfileStatsView.route();
      case 'settingsScreen':
        return SettingsScreen.route();
      default:
        return null;
    }
  }

  const ProfileListItem({
    Key? key,
    this.logOut = false,
    this.icon,
    this.text,
    this.hasNavigation = true,
    this.where,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !hasNavigation
          ? () => context
              .read<AuthenticationBloc>()
              .add(AuthenticationLogoutRequested())
          : () => Navigator.of(context).push<void>(
                navigationNames(where)!,
              ),
      child: Container(
        height: kSpacingUnit.w * 5.5,
        margin: EdgeInsets.symmetric(
          horizontal: kSpacingUnit.w * 4,
        ).copyWith(
          bottom: kSpacingUnit.w * 2,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: kSpacingUnit.w * 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kSpacingUnit.w * 3),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.icon,
              size: kSpacingUnit.w * 2.5,
            ),
            SizedBox(width: kSpacingUnit.w * 1.5),
            Text(
              this.text!,
              style: kTitleTextStyle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            if (this.hasNavigation)
              Icon(
                LineAwesomeIcons.angle_right,
                size: kSpacingUnit.w * 2.5,
              ),
          ],
        ),
      ),
    );
  }
}
