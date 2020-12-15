import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/firebase_login/authentication/authentication.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_screenutil/size_extension.dart';

class ProfileDataView extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ProfileDataView());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);

    ScreenUtil.init(context,
        designSize: Size(414, 896), allowFontScaling: true);
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
        Text(user.email)
      ],
    ));
  }
}
