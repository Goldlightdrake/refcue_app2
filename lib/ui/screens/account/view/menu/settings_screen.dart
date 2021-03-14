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
        Text("Ustawienia ogólne"),
        Container(
          child: Column(
            children: [_SettingListTile(index: 1)],
          ),
        ),
      ],
    );

    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: kSpacingUnit.w * 5),
        header,
      ],
    ));
  }
}

class _SettingListTile extends StatelessWidget {
  final int? index;
  final String? title;
  const _SettingListTile({this.index, this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        activeTrackColor: Theme.of(context).primaryColor,
        activeColor: kAccentColor,
        title: Text(
          'Article ' + index.toString(),
          textAlign: TextAlign.center,
          style: kTitleTextStyle.copyWith(fontSize: kSpacingUnit.w * 2),
        ),
        value: true,
        onChanged: (bool value) {});
  }
}
