import 'package:flutter/material.dart';
import 'package:refcue_app/shared/const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

questionAnswerLegend(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: kSpacingUnit.w * 40,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    color: Colors.white),
              ),
              SizedBox(
                height: kSpacingUnit.w * 2,
              ),
              Text('Legenda',
                  style:
                      kTitleTextStyle.copyWith(fontSize: kSpacingUnit.w * 2)),
              SizedBox(height: kSpacingUnit.w * 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'G - grać dalej\n\nP - rzut wolny pośredni\n\nJ - jeszcze raz\n\nBr - bramka\n\nR - rzut rożny\n\nRb - rzut od bramki',
                    style: kTitleTextStyle.copyWith(
                        fontSize: kSpacingUnit.w * 1.7),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    'B - rzut wolny bezpośredni\n\nK - rzut karny\n\nS - rzut sędziowski\n\nW - wrzut\n\nZ - zakończenie\n\n',
                    style: kTitleTextStyle.copyWith(
                        fontSize: kSpacingUnit.w * 1.7),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
