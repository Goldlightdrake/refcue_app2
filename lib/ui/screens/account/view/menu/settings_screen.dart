import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SettingsScreen());
  }

  @override
  Widget build(BuildContext context) {
    var header = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: kSpacingUnit.w * 3),
          IconButton(
            onPressed: () => Navigator.of(context).pop<void>(),
            icon: Icon(LineAwesomeIcons.arrow_left),
            iconSize: ScreenUtil().setSp(kSpacingUnit.w * 3),
          ),
        ]);

    var generalSettings = Column(
      children: [
        Text("Ustawienia ogólne",
            style: TextStyle(fontSize: kSpacingUnit.w * 2)),
        SizedBox(height: kSpacingUnit.w * 3),
        Container(
          child: Column(
            children: [
              _SettingListTile(
                index: 0,
                title: "Dzwięki",
                icon: Icon(Icons.volume_up),
              ),
              _SettingListTile(
                index: 1,
                title: "Powiadomienia",
                icon: Icon(Icons.notifications_active),
              )
            ],
          ),
        ),
      ],
    );

    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: kSpacingUnit.w * 5),
        header,
        SizedBox(height: kSpacingUnit.w * 5),
        generalSettings
      ],
    ));
  }
}

class _SettingListTile extends StatelessWidget {
  final int index;
  final Icon icon;
  final String title;
  const _SettingListTile(
      {required this.index, required this.title, required this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SwitchListTile(
          secondary: icon,
          activeTrackColor: Theme.of(context).primaryColor,
          tileColor: Theme.of(context).cardColor,
          activeColor: kAccentColor,
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: kTitleTextStyle.copyWith(fontSize: kSpacingUnit.w * 1.8),
          ),
          value: true,
          onChanged: (bool value) {}),
    );
  }
}
