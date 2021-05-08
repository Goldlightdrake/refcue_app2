import 'package:flutter/material.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<bool> exitFromExamRequest(BuildContext context) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(
              'Czy napewno chcesz opuścić test? Twoje odpowiedzi nie zostaną zapisane!',
              style: kTitleTextStyle.copyWith(
                fontSize: kSpacingUnit.w * 1.8,
              ),
            ),
            actions: [
              TextButton(
                  child: Text('Tak',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1!.color)),
                  onPressed: () {
                    Navigator.pop(context, true);
                  }),
              TextButton(
                child: Text('Nie',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color)),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          ));
}
