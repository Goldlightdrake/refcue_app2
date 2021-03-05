import 'package:flutter/material.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Coś poszło nie tak...\nSpróbuj zrestartować aplikację",
                textAlign: TextAlign.justify,
                style:
                    kTitleTextStyle.copyWith(fontSize: kSpacingUnit.w * 1.8)),
            SizedBox(width: kSpacingUnit.w * 1),
            Icon(Icons.error, size: 40)
          ],
        ),
      ),
    );
  }
}
