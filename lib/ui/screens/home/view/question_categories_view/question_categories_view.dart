import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class QuestionCategoriesView extends StatelessWidget {
  const QuestionCategoriesView({Key key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => QuestionCategoriesView());
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

    return Scaffold(
        body: Column(
      children: [
        SizedBox(height: kSpacingUnit.w * 5),
        header,
      ],
    ));
  }
}
