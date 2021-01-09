import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnswerCardsView extends StatelessWidget {
  const AnswerCardsView(this.resumption, this.yellowCards, this.redCards,
      {Key key})
      : super(key: key);

  final String resumption;
  final String yellowCards;
  final String redCards;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(resumption, style: TextStyle(fontSize: kSpacingUnit.w * 2.5)),
      SizedBox(width: kSpacingUnit.w * 1),
      Container(
          width: kSpacingUnit.w * 3,
          height: kSpacingUnit.w * 5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Color(0xddEBDE34),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: Offset(0, 5),
                blurRadius: 3.0,
              )
            ],
          ),
          child: Text(yellowCards)),
      SizedBox(width: kSpacingUnit.w * 1),
      Container(
          width: kSpacingUnit.w * 3,
          height: kSpacingUnit.w * 5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.red,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor,
                offset: Offset(0, 5),
                blurRadius: 3.0,
              )
            ],
          ),
          child: Text(redCards))
    ]);
  }
}
